
#[test_only]
module ethos::checker_board_tests {
    use ethos::checker_board::{Self, CheckerBoard};

    const PLAYER1: u8 = 1;
    const PLAYER2: u8 = 2;

    #[test_only]
    fun print_board(board: &CheckerBoard) {
        use ethos::checker_board::{spaces, valid_space, player_at, king_at};
        use std::debug::print;
        use std::vector::{length, borrow, push_back};

        let s = spaces(board);
        let row_count = length(s);

        let row_index = 0;
        while (row_index < row_count) {
            let row = borrow(s, row_index);
            let column_count = length(row);

            let print_row = vector<u64>[];

            let column_index = 0;
            while (column_index < column_count) {
                let position = &vector[row_index, column_index];
                if (valid_space(position)) {
                    let player = *player_at(board, position);
                    let king = *king_at(board, position);
                    if (king) {
                        push_back(&mut print_row, (player as u64) + 7);
                    } else {
                        push_back(&mut print_row, (player as u64));
                    };
                } else {
                    push_back(&mut print_row, 0);
                };
                
                column_index = column_index + 1;
            };


            print(&print_row);
            row_index = row_index + 1;
        }
    }

    #[test]
    fun test_new() {
        use ethos::checker_board::{new, row_count, column_count, empty_space_count};

        let board = new();
        assert!(row_count() == 8, row_count());
        assert!(column_count() == 8, column_count());
        let empty_space_count = empty_space_count(&board);
        assert!(empty_space_count == 8, empty_space_count);
    }

    #[test]
    fun test_modify() {
        use ethos::checker_board::{new, modify, player_at};

        let board = new();
        modify(&mut board, PLAYER1, vector[vector[2, 1], vector[3, 2]]);

        assert!(player_at(&board, &vector[2, 1]) == &0, (*player_at(&board, &vector[2, 1]) as u64));
        assert!(player_at(&board, &vector[3, 2]) == &1, (*player_at(&board, &vector[3, 2]) as u64));

    }

    #[test]
    #[expected_failure(abort_code = checker_board::EINVALID_PLAYER)]
    fun test_modify_bad_from() {
        use ethos::checker_board::{new, modify};

        let board = new();
        modify(&mut board, PLAYER1, vector[vector[3, 2], vector[4, 1]]);
    }

    #[test]
    #[expected_failure(abort_code = checker_board::EBAD_DESTINATION)]
    fun test_modify_bad_to_player1() {
        use ethos::checker_board::{new, modify};

        let board = new();
        modify(&mut board, PLAYER1, vector[vector[2, 1], vector[1, 2]]);
    }

    #[test]
    #[expected_failure(abort_code = checker_board::EBAD_DESTINATION)]
    fun test_modify_bad_to_player2() {
        use ethos::checker_board::{new, modify};

        let board = new();
        modify(&mut board, PLAYER2, vector[vector[5, 2], vector[6, 1]]);
    }

    #[test]
    #[expected_failure(abort_code = checker_board::EOCCUPIED_SPACE)]
    fun test_modify_occupied_space() {
        use ethos::checker_board::{new, modify};

        let board = new();
        modify(&mut board, PLAYER2, vector[vector[6, 1], vector[5, 2]]);
    }

    #[test]
    #[expected_failure(abort_code = checker_board::EBAD_DESTINATION)]
    fun test_modify_destination_not_allowed_player_1() {
        use ethos::checker_board::{new, modify};

        let board = new();
        modify(&mut board, PLAYER1, vector[vector[2, 1], vector[3, 6]]);
    }

    #[test]
    #[expected_failure(abort_code = checker_board::EBAD_DESTINATION)]
    fun test_modify_destination_not_allowed_player_2() {
        use ethos::checker_board::{new, modify};

        let board = new();
        modify(&mut board, PLAYER2, vector[vector[5, 0], vector[4, 3]]);
    }

    #[test]
    #[expected_failure(abort_code = checker_board::EINVALID_PLAYER)]
    fun test_modify_player_1_cant_move_player_2() {
        use ethos::checker_board::{new, modify};

        let board = new();
        modify(&mut board, PLAYER1, vector[vector[5, 0], vector[4, 1]]);
    }

    #[test]
    #[expected_failure(abort_code = checker_board::EINVALID_PLAYER)]
    fun test_modify_player_2_cant_move_player_1() {
        use ethos::checker_board::{new, modify};

        let board = new();
        modify(&mut board, PLAYER2, vector[vector[2, 1], vector[3, 2]]);
    }

    #[test]
    fun test_modify_jump_player2() {
        use ethos::checker_board::{new, modify, empty_space_count};

        let board = new();
        modify(&mut board, PLAYER1, vector[vector[2, 3], vector[3, 4]]);
        modify(&mut board, PLAYER1, vector[vector[3, 4], vector[4, 5]]);

        assert!(empty_space_count(&board) == 8, empty_space_count(&board));
        modify(&mut board, PLAYER2, vector[vector[5, 4], vector[3, 6]]);
        assert!(empty_space_count(&board) == 9, empty_space_count(&board));
    }

     #[test]
    fun test_modify_jump_player1() {
        use ethos::checker_board::{new, modify, empty_space_count};

        let board = new();
        modify(&mut board, PLAYER2, vector[vector[5, 4], vector[4, 3]]);
        modify(&mut board, PLAYER2, vector[vector[4, 3], vector[3, 2]]);

        assert!(empty_space_count(&board) == 8, empty_space_count(&board));
        modify(&mut board, PLAYER1, vector[vector[2, 3], vector[4, 1]]);
        assert!(empty_space_count(&board) == 9, empty_space_count(&board));
    }

    #[test]
    fun test_modify_double_jump_player2() {
        use ethos::checker_board::{new, modify, empty_space_count};

        let board = new();
        modify(&mut board, PLAYER1, vector[vector[2, 3], vector[3, 2]]);
        modify(&mut board, PLAYER1, vector[vector[3, 2], vector[4, 1]]);
        modify(&mut board, PLAYER1, vector[vector[1, 2], vector[2, 3]]);

        assert!(empty_space_count(&board) == 8, empty_space_count(&board));
        modify(&mut board, PLAYER2, vector[vector[5, 2], vector[3, 0], vector[1, 2]]);
        assert!(empty_space_count(&board) == 10, empty_space_count(&board));
    }

    #[test]
    fun test_modify_double_jump_player1() {
        use ethos::checker_board::{new, modify, empty_space_count};

        let board = new();
        modify(&mut board, PLAYER2, vector[vector[5, 4], vector[4, 3]]);
        modify(&mut board, PLAYER2, vector[vector[4, 3], vector[3, 2]]);
        modify(&mut board, PLAYER2, vector[vector[6, 3], vector[5, 4]]);

        assert!(empty_space_count(&board) == 8, empty_space_count(&board));
        modify(&mut board, PLAYER1, vector[vector[2, 3], vector[4, 1], vector[6, 3]]);
        assert!(empty_space_count(&board) == 10, empty_space_count(&board));
    }

    #[test]
    fun test_modify_king_player1() {
        use ethos::checker_board::{new, modify, king_at};

        let board = new();
        modify(&mut board, PLAYER2, vector[vector[5, 4], vector[4, 3]]);
        modify(&mut board, PLAYER2, vector[vector[4, 3], vector[3, 2]]);
        modify(&mut board, PLAYER2, vector[vector[6, 3], vector[5, 4]]);
        modify(&mut board, PLAYER1, vector[vector[2, 3], vector[4, 1], vector[6, 3]]);
        modify(&mut board, PLAYER2, vector[vector[6, 1], vector[5, 2]]);
        modify(&mut board, PLAYER2, vector[vector[7, 2], vector[6, 1]]);
        modify(&mut board, PLAYER1, vector[vector[6, 3], vector[7, 2]]);

        assert!(*king_at(&board, &vector[7, 2]), 1);
    }

    #[test]
    fun test_modify_king_player2() {
        use ethos::checker_board::{new, modify, king_at};

        let board = new();
        modify(&mut board, PLAYER1, vector[vector[2, 1], vector[3, 2]]);
        modify(&mut board, PLAYER2, vector[vector[5, 2], vector[4, 3]]);
        modify(&mut board, PLAYER1, vector[vector[3, 2], vector[4, 1]]);
        modify(&mut board, PLAYER2, vector[vector[5, 0], vector[3, 2]]);
        modify(&mut board, PLAYER1, vector[vector[2, 3], vector[4, 1]]);
        modify(&mut board, PLAYER2, vector[vector[4, 3], vector[3, 2]]);
        modify(&mut board, PLAYER1, vector[vector[1, 2], vector[2, 1]]);
        modify(&mut board, PLAYER2, vector[vector[6, 3], vector[5, 2]]);
        modify(&mut board, PLAYER1, vector[vector[2, 5], vector[3, 4]]);
        modify(&mut board, PLAYER2, vector[vector[5, 2], vector[3, 0], vector[1, 2]]);
        modify(&mut board, PLAYER1, vector[vector[0, 1], vector[2, 3]]);
        modify(&mut board, PLAYER2, vector[vector[6, 1], vector[5, 2]]);
        modify(&mut board, PLAYER1, vector[vector[1, 0], vector[2, 1]]);
        modify(&mut board, PLAYER2, vector[vector[3, 2], vector[1, 0]]);
        modify(&mut board, PLAYER1, vector[vector[3, 4], vector[4, 3]]);
        modify(&mut board, PLAYER2, vector[vector[1, 0], vector[0, 1]]);

        assert!(*king_at(&board, &vector[0, 1]), 1);
    }

    #[test]
    fun test_modify_king_player2_double_jump() {
        use ethos::checker_board::{new, modify, king_at};

        let board = new();
        modify(&mut board, PLAYER1, vector[vector[2, 1], vector[3, 2]]);
        modify(&mut board, PLAYER2, vector[vector[5, 2], vector[4, 3]]);
        modify(&mut board, PLAYER1, vector[vector[2, 3], vector[3, 4]]);
        modify(&mut board, PLAYER2, vector[vector[5, 6], vector[4, 5]]);
        modify(&mut board, PLAYER1, vector[vector[1, 4], vector[2, 3]]);
        modify(&mut board, PLAYER2, vector[vector[6, 7], vector[5, 6]]);
        modify(&mut board, PLAYER1, vector[vector[0, 3], vector[1, 4]]);
        modify(&mut board, PLAYER2, vector[vector[4, 3], vector[2, 1], vector[0, 3]]);

        assert!(*king_at(&board, &vector[0, 3]), 1);
    }

    #[test]
    fun test_king_can_jump() {
        use ethos::checker_board::{new, modify, empty_space_count};
        
        let board = new();
        modify(&mut board, PLAYER1, vector[vector[2, 1], vector[3, 2]]);
        modify(&mut board, PLAYER2, vector[vector[5, 2], vector[4, 3]]);
        modify(&mut board, PLAYER1, vector[vector[2, 3], vector[3, 4]]);
        modify(&mut board, PLAYER2, vector[vector[5, 6], vector[4, 5]]);
        modify(&mut board, PLAYER1, vector[vector[1, 4], vector[2, 3]]);
        modify(&mut board, PLAYER2, vector[vector[6, 7], vector[5, 6]]);
        modify(&mut board, PLAYER1, vector[vector[0, 3], vector[1, 4]]);
        modify(&mut board, PLAYER2, vector[vector[4, 3], vector[2, 1], vector[0, 3]]);
        modify(&mut board, PLAYER1, vector[vector[2, 5], vector[3, 6]]);

        assert!(empty_space_count(&board) == 10, empty_space_count(&board));
        modify(&mut board, PLAYER2, vector[vector[0, 3], vector[2, 5]]);
        assert!(empty_space_count(&board) == 11, empty_space_count(&board));
    }

    #[test]
    fun test_king_can_double_jump() {
        use ethos::checker_board::{new, modify, empty_space_count};

        let board = new();
        modify(&mut board, PLAYER1, vector[vector[2, 1], vector[3, 2]]);
        modify(&mut board, PLAYER2, vector[vector[5, 2], vector[4, 3]]);
        modify(&mut board, PLAYER1, vector[vector[2, 3], vector[3, 4]]);
        modify(&mut board, PLAYER2, vector[vector[5, 6], vector[4, 5]]);
        modify(&mut board, PLAYER1, vector[vector[1, 4], vector[2, 3]]);
        modify(&mut board, PLAYER2, vector[vector[6, 7], vector[5, 6]]);
        modify(&mut board, PLAYER1, vector[vector[0, 3], vector[1, 4]]);
        modify(&mut board, PLAYER2, vector[vector[4, 3], vector[2, 1], vector[0, 3]]);
        modify(&mut board, PLAYER1, vector[vector[2, 5], vector[3, 6]]);

        assert!(empty_space_count(&board) == 10, empty_space_count(&board));
        modify(&mut board, PLAYER2, vector[vector[0, 3], vector[2, 5], vector[4, 7]]);
        assert!(empty_space_count(&board) == 12, empty_space_count(&board));  
    }

    #[test]
    fun test_triple_jump() {
        use ethos::checker_board::{new, modify, empty_space_count};

        let board = new();
        modify(&mut board, PLAYER1, vector[vector[2, 1], vector[3, 2]]);
        modify(&mut board, PLAYER2, vector[vector[5, 2], vector[4, 3]]);
        modify(&mut board, PLAYER1, vector[vector[2, 3], vector[3, 4]]);
        modify(&mut board, PLAYER2, vector[vector[5, 6], vector[4, 5]]);
        modify(&mut board, PLAYER1, vector[vector[1, 4], vector[2, 3]]);
        modify(&mut board, PLAYER2, vector[vector[6, 7], vector[5, 6]]);
        modify(&mut board, PLAYER1, vector[vector[0, 3], vector[1, 4]]);
        modify(&mut board, PLAYER2, vector[vector[4, 3], vector[2, 1], vector[0, 3]]);
        modify(&mut board, PLAYER1, vector[vector[2, 5], vector[3, 6]]);
        modify(&mut board, PLAYER1, vector[vector[2, 3], vector[3, 2]]);
         
        assert!(empty_space_count(&board) == 10, empty_space_count(&board));
        modify(&mut board, PLAYER2, vector[vector[0, 3], vector[2, 5], vector[4, 3], vector[2, 1]]);
        assert!(empty_space_count(&board) == 13, empty_space_count(&board));  
    }

    #[test]
    fun test_triple_jump__king_in_middle() {
        use ethos::checker_board::{new, modify, empty_space_count, king_at};

        let board = new();
        modify(&mut board, PLAYER1, vector[vector[2, 1], vector[3, 2]]);
        modify(&mut board, PLAYER2, vector[vector[5, 2], vector[4, 3]]);
        modify(&mut board, PLAYER1, vector[vector[2, 3], vector[3, 4]]);
        modify(&mut board, PLAYER2, vector[vector[5, 6], vector[4, 5]]);
        modify(&mut board, PLAYER1, vector[vector[1, 4], vector[2, 3]]);
        modify(&mut board, PLAYER2, vector[vector[6, 7], vector[5, 6]]);
        modify(&mut board, PLAYER1, vector[vector[0, 3], vector[1, 4]]);
        modify(&mut board, PLAYER1, vector[vector[2, 5], vector[3, 6]]);
        
        assert!(!*king_at(&board, &vector[4, 3]), 1);

        assert!(empty_space_count(&board) == 8, empty_space_count(&board));
        modify(&mut board, PLAYER2, vector[vector[4, 3], vector[2, 1], vector[0, 3], vector[2, 5]]);
        assert!(empty_space_count(&board) == 11, empty_space_count(&board));  

        assert!(*king_at(&board, &vector[2, 5]), 2);
    }

    // #[test]
    // fun test_modify_full_game() {
    //     use ethos::checker_board::{new, modify, empty_space_count};

    //     let board = new();
    //     modify(&mut board, 5, 4, 4, 3);
    //     modify(&mut board, 4, 3, 3, 2);
    //     modify(&mut board, 6, 3, 5, 4);

    //     assert!(empty_space_count(&board) == 8, empty_space_count(&board));
    //     modify(&mut board, 2, 3, 6, 3);
    //     assert!(empty_space_count(&board) == 10, empty_space_count(&board));

    //     transfer::share_object(TestCheckerBoard { board });
    // }
}