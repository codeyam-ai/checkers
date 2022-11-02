 
#[test_only]
module ethos::checkers_tests {
    use std::vector;
    use sui::test_scenario::{Self, Scenario};
    use sui::object;

    use ethos::checkers::{Self, CheckersGame, CheckersPlayerCap};
    use ethos::checker_board;
   
    const PLAYER1: address = @0xCAFE;
    const PLAYER2: address = @0xA1C05;
    const NONPLAYER: address = @0xFACE;

    #[test_only]
    struct Position has drop {
      row: u64,
      col: u64
    }

    #[test_only]
    struct ChessMove has drop {
        start: Position,
        end: Position
    }

    #[test_only]
    fun cm(start_row: u64, start_col: u64, end_row: u64, end_col: u64): ChessMove {
        ChessMove { 
            start: Position { row: start_row, col: start_col }, 
            end: Position { row: end_row, col: end_col } }
    }

    #[test_only]
    fun test_move(game: &mut CheckersGame, m: &ChessMove, scenario: &mut Scenario) {
        checkers::make_move(
            game, 
            m.start.row, 
            m.start.col,
            m.end.row,
            m.end.col,
            test_scenario::ctx(scenario)
        )
    }

    #[test]
    fun test_game_create() {
        let scenario = test_scenario::begin(PLAYER1);
        {
            checkers::create_game(PLAYER2, test_scenario::ctx(&mut scenario));
        };

        test_scenario::next_tx(&mut scenario, PLAYER1);
        {
            let game = test_scenario::take_shared<CheckersGame>(&mut scenario);
            let player1_cap = test_scenario::take_from_address<CheckersPlayerCap>(&mut scenario, PLAYER1);
            
            assert!(checkers::player1(&game) == &PLAYER1, 0);
            assert!(checkers::player2(&game) == &PLAYER2, 0);
            assert!(checkers::move_count(&game) == 0, checkers::move_count(&game));
          
            let game_board = checkers::board_at(&game, 0);
            let empty_space_count = checker_board::empty_space_count(game_board);
            assert!(empty_space_count == 8, empty_space_count);

            let game_id = object::uid_to_inner(checkers::game_id(&game));
            assert!(checkers::player_cap_game_id(&player1_cap) == &game_id, 1);

            test_scenario::return_to_address(PLAYER1, player1_cap);
            test_scenario::return_shared<CheckersGame>(game);
        };  

        test_scenario::next_tx(&mut scenario, PLAYER1);
        {
            let game = test_scenario::take_shared<CheckersGame>(&mut scenario);
            let player2_cap = test_scenario::take_from_address<CheckersPlayerCap>(&mut scenario, PLAYER2);

            let game_id = object::uid_to_inner(checkers::game_id(&game));
            assert!(checkers::player_cap_game_id(&player2_cap) == &game_id, 1);
            test_scenario::return_to_address(PLAYER2, player2_cap);

            test_scenario::return_shared<CheckersGame>(game);
        };

        test_scenario::end(scenario);
    }

    #[test]
    fun test_make_move() {
        use ethos::checkers::{create_game, make_move, piece_at, current_player};

        let scenario = test_scenario::begin(PLAYER1);
        {
            create_game(PLAYER2, test_scenario::ctx(&mut scenario));
        };

        test_scenario::next_tx(&mut scenario, PLAYER1);
        {
            let game = test_scenario::take_shared<CheckersGame>(&mut scenario);
           
            make_move(&mut game, 2, 1, 3, 2, test_scenario::ctx(&mut scenario));

            test_scenario::return_shared<CheckersGame>(game);
        };

        test_scenario::next_tx(&mut scenario, PLAYER2);
        {
            let game = test_scenario::take_shared<CheckersGame>(&mut scenario);

            assert!(piece_at(&game, 2, 1) == &0, (*piece_at(&game, 2, 1) as u64));
            assert!(piece_at(&game, 3, 2) == &1, (*piece_at(&game, 3, 2) as u64));
            assert!(current_player(&game) == &PLAYER2, 1);

            make_move(&mut game, 5, 4, 4, 3, test_scenario::ctx(&mut scenario));

            test_scenario::return_shared<CheckersGame>(game);
        };

        test_scenario::next_tx(&mut scenario, PLAYER1);
        {
            let game = test_scenario::take_shared<CheckersGame>(&mut scenario);

            assert!(piece_at(&game, 5, 4) == &0, (*piece_at(&game, 5, 4) as u64));
            assert!(piece_at(&game, 4, 3) == &2, (*piece_at(&game, 4, 3) as u64));
            assert!(current_player(&game) == &PLAYER1, 2);

            test_scenario::return_shared<CheckersGame>(game);
        };

        test_scenario::end(scenario);
    }

    #[test]
    #[expected_failure(abort_code = 0)]
    fun test_aborts_if_wrong_player_tries_to_move() {
        use ethos::checkers::{create_game, make_move};

        let scenario = test_scenario::begin(PLAYER1);
        {
            create_game(PLAYER2, test_scenario::ctx(&mut scenario));
        };

        test_scenario::next_tx(&mut scenario, PLAYER1);
        {
            let game = test_scenario::take_shared<CheckersGame>(&mut scenario);
            
            make_move(&mut game, 2, 1, 3, 2, test_scenario::ctx(&mut scenario));

            test_scenario::return_shared<CheckersGame>(game);
        };

        test_scenario::next_tx(&mut scenario, PLAYER1);
        {
            let game = test_scenario::take_shared<CheckersGame>(&mut scenario);
            
            make_move(&mut game, 5, 4, 4, 3, test_scenario::ctx(&mut scenario));

            test_scenario::return_shared<CheckersGame>(game);
        };

        test_scenario::end(scenario);
    }

    #[test]
    #[expected_failure(abort_code = 0)]
    fun test_aborts_if_non_player_tries_to_move() {
        use ethos::checkers::{create_game, make_move};

        let scenario = test_scenario::begin(PLAYER1);
        {
            create_game(PLAYER2, test_scenario::ctx(&mut scenario));
        };

        test_scenario::next_tx(&mut scenario, NONPLAYER);
        {
            let game = test_scenario::take_shared<CheckersGame>(&mut scenario);
            
            make_move(&mut game, 2, 1, 3, 2, test_scenario::ctx(&mut scenario));

            test_scenario::return_shared<CheckersGame>(game);
        };

        test_scenario::end(scenario);
    }

    #[test]
    fun test_game_over() {
        let scenario = test_scenario::begin(PLAYER1);

        let moves = vector[
            cm(2, 1, 3, 2)
        ];

        let i=0;
        let move_count = vector::length(&moves);
        while (i < move_count) {
            let m = vector::borrow(&moves, i);
            
            test_scenario::next_tx(&mut scenario, NONPLAYER);
            {
                let game = test_scenario::take_shared<CheckersGame>(&mut scenario);
                test_move(&mut game, m, &mut scenario);
                test_scenario::return_shared<CheckersGame>(game);
            };

            i = i + 1;
        };

        test_scenario::end(scenario);
    }   
}