const { piece } = require("./constants");
const { eByClass, removeClass } = require("./utils");

let active;

module.exports = {
  active: () => active,

  display: (board, player1) => {
    const spaces = board.spaces
    const spaceElements = eByClass('tile-wrapper');
    
    for (let i=0; i<spaces.length; ++i) {
      const playerI = player1 ? spaces.length - i - 1 : i;
      const row = spaces[i];

      for (let j=0; j<row.length; ++j) {
        const column = row[j];
        const spaceElement = spaceElements[(playerI * spaces.length) + j];

        spaceElement.dataset.row = i;
        spaceElement.dataset.column = j;
        
        removeClass(spaceElement, ['selected', 'destination']);
        if (column?.fields?.player_number) {
          const { player_number, king } = column.fields
          spaceElement.innerHTML = piece(player_number === 1 ? "white" : "black", king)
          spaceElement.dataset.player = column;
        } else {
          spaceElement.innerHTML = '';
          spaceElement.dataset.player = null;
        }
        
      }
    }

    active = board;
  },
  
  clear: () => {
    const spaceElements = eByClass('tile-wrapper');
    for (const spaceElement of spaceElements) {
      spaceElement.innerHTML = "";
      spaceElement.dataset.player = null;
      spaceElement.dataset.type = null;
    }
  },

  convertInfo: (board) => {
    const { 
      spaces: rawSpaces, 
      board_spaces: rawBoardSpaces,
      player: previousPlayer, 
      winner: winner,
      game_over: gameOver
    } = board.fields || board;
    const spaces = (rawSpaces || rawBoardSpaces).map(
      (rawRow) => rawRow.map(
        (rawSpace) => {
          return rawSpace
        }
      )
    )
    return { spaces, previousPlayer, winner, gameOver }
  }
}