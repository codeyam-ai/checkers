module ethos::checker_board {
    use std::option::{Self, Option};
    use std::vector;
    
    friend ethos::checkers;

    #[test_only]
    friend ethos::checker_board_tests;

    #[test_only]
    friend ethos::checkers_tests;

    const EMPTY: u8 = 0;
    const PLAYER1: u8 = 1;
    const PLAYER2: u8 = 2;

    const ROW_COUNT: u64 = 8;
    const COLUMN_COUNT: u64 = 8;
    const PLAYER_PIECES: u64 = 12;

    const EEMPTY_SPACE: u64 = 0;
    const EBAD_DESTINATION: u64 = 1;
    const EOCCUPIED_SPACE: u64 = 2;
    const EBAD_JUMP: u64 = 3;
    const EINVALID_PLAYER: u64 = 4;
    
    struct CheckerBoard has store, copy, drop {
        spaces: vector<vector<Option<CheckerBoardPiece>>>,
        game_over: bool
    }

    struct CheckerBoardPiece has store, copy, drop {
        player_number: u8,
        king: bool
    }

    struct SpacePosition has copy, drop {
        row: u64,
        column: u64
    }

    struct PlayerPositions has copy, drop {
        player1: vector<SpacePosition>,
        player2: vector<SpacePosition>,
    }

    struct PlayerCounts has copy, drop {
        player1: u64,
        player2: u64
    }

    struct MoveEffects has drop {
        jumps: vector<SpacePosition>
    }

    public(friend) fun new(): CheckerBoard {
        let spaces = vector[];

        let i=0;
        while (i < ROW_COUNT) {
            let row = vector[];

            let j=0;
            while (j < COLUMN_COUNT) {
                if (valid_space(&vector[i, j])) {
                    if (i < 3) {
                        vector::push_back(&mut row, option::some(create_piece(PLAYER1)))
                    } else if (i > 4) {
                        vector::push_back(&mut row, option::some(create_piece(PLAYER2)))
                    } else {
                        vector::push_back(&mut row, option::some(create_piece(EMPTY)))
                    }        
                } else {
                    vector::push_back(&mut row, option::none())
                };

                j = j + 1;
            };

            vector::push_back(&mut spaces, row);

            i = i + 1;
        };

        let game_board = create_board(spaces);

        game_board 
    }
 
    public(friend) fun create_board(spaces: vector<vector<Option<CheckerBoardPiece>>>): CheckerBoard {
        CheckerBoard { 
            spaces, 
            game_over: false
        }
    }

    public(friend) fun modify(board: &mut CheckerBoard, player_number: u8, positions: vector<vector<u64>>): bool {
        let initial_position = vector::borrow(&positions, 0);
        let player = player_at(board, initial_position);
        let king = *king_at(board, initial_position);
        let move_effects = analyze_move(board, player_number, player, king, 0, &positions);
             
        let old_space = space_at_mut(board, initial_position);
        let piece = option::swap(
            old_space, 
            CheckerBoardPiece { 
                player_number: EMPTY, 
                king: false
            }
        );

        let to_position = vector::borrow(&positions, vector::length(&positions) - 1);
        let new_space = space_at_mut(board, to_position);
        
        let position_index = 0;
        while (position_index < vector::length(&positions)) {
            let position = vector::borrow(&positions, position_index);
            let row = *vector::borrow(position, 0);
            if ((player_number == PLAYER1 && row == 7) || (player_number == PLAYER2 && row == 0)) {
                piece.king = true;
            };

            position_index = position_index + 1;
        };

        option::swap(new_space, piece);

        let jump_index = 0;
        let jumps_count = vector::length(&move_effects.jumps);
        while (jump_index < jumps_count) {
            let position = vector::borrow(&move_effects.jumps, jump_index);
            let jump_space = space_at_mut(board, &vector[position.row, position.column]);
            option::swap(
                jump_space, 
                CheckerBoardPiece { 
                    player_number: EMPTY, 
                    king: false
                }
            );

            jump_index = jump_index + 1;
        };

        let counts = player_counts(board);
        if (counts.player1 == 0 || counts.player2 == 0) {
            board.game_over = true;
        };

        true
    }

    public(friend) fun create_piece(player_number: u8): CheckerBoardPiece {
        CheckerBoardPiece {
            player_number,
            king: false
        }
    }
    
    public fun row_count(): u64 {
        ROW_COUNT
    }

    public fun column_count(): u64 {
        COLUMN_COUNT
    }

    fun spaces_at(spaces: &vector<vector<Option<CheckerBoardPiece>>>, position: &vector<u64>): &Option<CheckerBoardPiece> {
        let row_index = *vector::borrow(position, 0);
        let column_index = *vector::borrow(position, 1);
        let row = vector::borrow(spaces, row_index);
        vector::borrow(row, column_index)
    }

    fun spaces_at_mut(spaces: &mut vector<vector<Option<CheckerBoardPiece>>>, position: &vector<u64>): &mut Option<CheckerBoardPiece> {
        let row_index = *vector::borrow(position, 0);
        let column_index = *vector::borrow(position, 1);
        
        let row = vector::borrow_mut(spaces, row_index);
        vector::borrow_mut(row, column_index)
    }

    public(friend) fun spaces(board: &CheckerBoard): &vector<vector<Option<CheckerBoardPiece>>> {
        &board.spaces
    }

    public(friend) fun space_at(board: &CheckerBoard, position: &vector<u64>): &Option<CheckerBoardPiece> {
        spaces_at(&board.spaces, position)
    }

    public(friend) fun space_at_mut(board: &mut CheckerBoard, position: &vector<u64>): &mut Option<CheckerBoardPiece> {
        spaces_at_mut(&mut board.spaces, position)
    }

    public(friend) fun piece_at(board: &CheckerBoard, position: &vector<u64>): &CheckerBoardPiece {
        option::borrow(space_at(board, position))
    }

    public(friend) fun player_at(board: &CheckerBoard, position: &vector<u64>): &u8 {
        let space = space_at(board, position);
        let piece = option::borrow(space);
        &piece.player_number
    }

    public(friend) fun king_at(board: &CheckerBoard, position: &vector<u64>): &bool {
        let space = space_at(board, position);
        let piece = option::borrow(space);
        &piece.king
    }

    public(friend) fun game_over(board: &CheckerBoard): &bool {
        &board.game_over
    }

    public(friend) fun empty_space_positions(game_board: &CheckerBoard): vector<SpacePosition> {
        let empty_spaces = vector<SpacePosition>[];

        let row = 0;
        while (row < ROW_COUNT) {
          let column = 0;
          while (column < COLUMN_COUNT) {
            if (valid_space(&vector[row, column])) {
                let player = player_at(game_board, &vector[row, column]);
                if (player == &EMPTY) {
                    vector::push_back(&mut empty_spaces, SpacePosition { row, column })
                };
            };
            column = column + 1;
          };
          row = row + 1;
        };

        empty_spaces
    }

    public(friend) fun empty_space_count(game_board: &CheckerBoard): u64 {
        vector::length(&empty_space_positions(game_board))
    }

    public(friend) fun player_positions(game_board: &CheckerBoard): PlayerPositions {
        let positions1 = vector<SpacePosition>[];
        let positions2 = vector<SpacePosition>[];

        let row = 0;
        while (row < ROW_COUNT) {
            let column = 0;
            while (column < COLUMN_COUNT) {
                if (valid_space(&vector[row, column])) {
                    let player = player_at(game_board, &vector[row, column]);
                    if (player == &PLAYER1) {
                        vector::push_back(&mut positions1, SpacePosition { row, column })
                    } else if (player == &PLAYER2) {
                        vector::push_back(&mut positions2, SpacePosition { row, column })
                    };
                };
                column = column + 1;
            };
            row = row + 1;
        };

        PlayerPositions {
            player1: positions1,
            player2: positions2
        }
    }

    public(friend) fun player_counts(game_board: &CheckerBoard): PlayerCounts {
        let positions = player_positions(game_board);
        PlayerCounts {
            player1: vector::length(&positions.player1),
            player2: vector::length(&positions.player2)
        }
    }


    public(friend) fun valid_space(position: &vector<u64>): bool {
        let row = *vector::borrow(position, 0);
        let column = *vector::borrow(position, 1);
        
        if (row % 2 == 1) {
            column % 2 == 0
        } else {
            column % 2 == 1
        }
    }

    fun analyze_move(board: &CheckerBoard, player_number: u8, piece_player: &u8, king: bool, position_index: u64, positions: &vector<vector<u64>>): MoveEffects {
        let from_position = vector::borrow(positions, position_index);
        let from_row = *vector::borrow(from_position, 0);
        let from_col = *vector::borrow(from_position, 1);

        let to_position = vector::borrow(positions, position_index + 1);
        let to_row = *vector::borrow(to_position, 0);
        let to_col = *vector::borrow(to_position, 1);

        assert!(piece_player == &player_number, EINVALID_PLAYER);
        assert!(to_row < ROW_COUNT, EBAD_DESTINATION);
        assert!(to_col < COLUMN_COUNT, EBAD_DESTINATION);

        let move_effects = MoveEffects {
            jumps: vector[]
        };

        let new_space_player = player_at(board, to_position);

        let player1_move = (piece_player == &PLAYER1);
        let player2_move = (piece_player == &PLAYER2);
        assert!(player1_move || player2_move, EEMPTY_SPACE);

        if (!king) {
            if (player1_move) {
                assert!(to_row > from_row, EBAD_DESTINATION);
            } else {
                assert!(to_row < from_row, EBAD_DESTINATION);
            };
        };

        assert!(new_space_player == &EMPTY, EOCCUPIED_SPACE);

        let jump = ((player1_move || king) && from_row <= 5 && from_row + 2 == to_row) || 
                   ((player2_move || king) && from_row >= 2 && from_row - 2 == to_row);

        if (jump) {
            let over_piece = PLAYER2;
            let over_row = from_row + 1;
            let over_col = from_col + 1;
            
            if (player2_move) {
                over_piece = PLAYER1;
            };

            if (from_row > to_row) {
                over_row = from_row - 1;
            };
            
            if (from_col > to_col ) {
                over_col = from_col - 1;
            };

            let over_position = vector[over_row, over_col];
            
            assert!(player_at(board, &over_position) == &over_piece, EBAD_JUMP);
            
            let jump_position = SpacePosition {
                row: over_row,
                column: over_col
            };
            vector::push_back(&mut move_effects.jumps, jump_position);
        } else {
            if (king) {
                assert!(from_row + 1 == to_row || from_row > 0 && from_row - 1 == to_row, EBAD_DESTINATION);
            } else if (player1_move) {
                assert!(from_row + 1 == to_row, EBAD_DESTINATION);
            } else {
                assert!(from_row - 1 == to_row, EBAD_DESTINATION);
            };
            assert!(from_col + 1 == to_col || from_col == to_col + 1, EBAD_DESTINATION);
        };

        if ((player1_move && to_row == 7) || (player2_move && to_row == 0)) {
            king = true;
        };

        if (position_index + 1 < vector::length(positions) - 1) {
            let next_jump_effects = analyze_move(
                board, 
                player_number,
                piece_player,
                king,
                position_index + 1,
                positions
            );

            vector::append(&mut move_effects.jumps, next_jump_effects.jumps);
        };

        move_effects
    }

}

