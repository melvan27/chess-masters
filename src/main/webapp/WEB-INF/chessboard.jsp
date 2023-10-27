<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.melchizedek.chessmasters.stockfish.StockfishWrapper" %>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
  <link rel="stylesheet"
  href="https://unpkg.com/@chrisoakman/chessboard2@0.5.0/dist/chessboard2.min.css"
  integrity="sha384-47VeTDpmy4yT21gKPXQcLQYQZwlmz27gEH5NTrOmTk3G/SGvMyltclOW/Q8uE+sL"
  crossorigin="anonymous">
  <script src="https://unpkg.com/@chrisoakman/chessboard2@0.5.0/dist/chessboard2.min.js"
  integrity="sha384-/KwQCjA1GWovZNV3QDVtvSMDzO4reGgarF/RqHipr7hIUElH3r5zNl9WEPPOBRIF"
  crossorigin="anonymous"></script>
  <script src="https://unpkg.com/chess.js@0.12.1/chess.js"></script>
<title>Chessboard</title>
<style>
  .bd-placeholder-img {
    font-size: 1.125rem;
    text-anchor: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    user-select: none;
  }

  @media (min-width: 768px) {
    .bd-placeholder-img-lg {
      font-size: 3.5rem;
    }
  }

  .b-divider {
    width: 100%;
    height: 3rem;
    background-color: rgba(0, 0, 0, .1);
    border: solid rgba(0, 0, 0, .15);
    border-width: 1px 0;
    box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
  }

  .b-vr {
    flex-shrink: 0;
    width: 1.5rem;
    height: 100vh;
  }

  .bi {
    vertical-align: -.125em;
    fill: currentColor;
  }

  .nav-scroller {
    position: relative;
    z-index: 2;
    height: 2.75rem;
    overflow-y: hidden;
  }

  .nav-scroller .nav {
    display: flex;
    flex-wrap: nowrap;
    padding-bottom: 1rem;
    margin-top: -1px;
    overflow-x: auto;
    text-align: center;
    white-space: nowrap;
    -webkit-overflow-scrolling: touch;
  }

  .btn-bd-primary {
    --bd-violet-bg: #712cf9;
    --bd-violet-rgb: 112.520718, 44.062154, 249.437846;

    --bs-btn-font-weight: 600;
    --bs-btn-color: var(--bs-white);
    --bs-btn-bg: var(--bd-violet-bg);
    --bs-btn-border-color: var(--bd-violet-bg);
    --bs-btn-hover-color: var(--bs-white);
    --bs-btn-hover-bg: #6528e0;
    --bs-btn-hover-border-color: #6528e0;
    --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
    --bs-btn-active-color: var(--bs-btn-hover-color);
    --bs-btn-active-bg: #5a23c8;
    --bs-btn-active-border-color: #5a23c8;
  }

  .bd-mode-toggle {
    z-index: 1500;
  }

  .bd-mode-toggle .dropdown-menu .active .bi {
    display: block !important;
  }
</style>
</head>
<body>

  <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
    <symbol id="bootstrap" viewBox="0 0 118 94">
      <path fill-rule="evenodd" clip-rule="evenodd" d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z"></path>
    </symbol>
    <symbol id="logo" viewBox="0 0 300 300">
      <g transform="translate(0,300) scale(0.1,-0.1)" fill="#000000" stroke="none">
        <path d="M2183 2159 c-116 -22 -210 -97 -261 -207 -22 -48 -26 -70 -25 -137 1
        -44 3 -91 5 -105 3 -23 0 -25 -90 -38 -92 -14 -93 -15 -107 -49 -8 -20 -15
        -61 -15 -93 l0 -58 65 -31 c36 -16 65 -34 65 -39 0 -22 -130 -140 -190 -172
        -55 -29 -75 -35 -130 -34 -54 0 -76 6 -130 33 -65 34 -190 147 -190 173 0 7
        28 27 63 43 l62 30 0 60 c-1 88 -19 118 -78 127 -147 24 -142 23 -137 43 3 11
        5 61 5 110 0 76 -4 99 -26 145 -32 69 -95 132 -168 168 -49 24 -67 27 -151 27
        -84 0 -102 -4 -152 -29 -70 -34 -131 -98 -166 -174 -23 -48 -27 -71 -27 -142
        0 -71 4 -94 26 -140 34 -74 81 -125 146 -162 29 -16 53 -32 53 -36 0 -3 -21
        -39 -46 -79 -34 -54 -44 -80 -40 -98 7 -28 47 -77 86 -105 l28 -20 63 30 c59
        27 64 28 74 12 5 -9 10 -71 10 -137 -1 -108 -3 -126 -28 -185 -15 -36 -44 -92
        -63 -124 -74 -125 -82 -255 -23 -406 17 -44 35 -80 40 -80 5 0 178 79 385 175
        206 96 378 175 380 175 3 0 176 -79 383 -175 208 -96 383 -175 388 -175 13 0
        58 100 74 163 6 27 10 84 7 132 -4 80 -7 90 -70 213 -37 72 -71 155 -78 188
        -13 61 -8 230 7 245 4 4 37 -6 72 -22 l64 -29 33 25 c44 34 84 87 84 112 0 11
        -10 35 -23 54 -27 40 -67 109 -67 114 0 2 17 12 38 22 20 9 59 39 85 65 177
        176 122 471 -107 573 -58 26 -141 36 -203 24z m-1308 -79 c144 -69 207 -217
        156 -369 -12 -35 -21 -65 -19 -66 2 -1 55 -11 118 -21 l115 -19 3 -51 3 -51
        -76 -33 c-41 -18 -75 -36 -75 -40 0 -18 75 -118 118 -159 85 -79 173 -119 333
        -151 115 -23 169 -50 232 -115 43 -44 95 -130 86 -140 -17 -17 -1103 -515
        -1114 -511 -15 5 -44 97 -52 165 -7 62 19 161 61 232 74 124 114 273 101 374
        -10 76 -36 175 -47 175 -5 0 -31 -11 -59 -25 -91 -46 -95 -47 -129 -19 -16 14
        -30 34 -30 45 0 10 25 60 56 110 30 50 52 95 47 99 -4 4 -26 12 -49 18 -88 25
        -166 108 -191 204 -17 67 -17 103 2 165 52 175 246 261 410 183z"/>
      </g>
    </symbol>
    <symbol id="home" viewBox="0 0 16 16">
      <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"></path>
    </symbol>
    <symbol id="cpu" viewBox="0 0 16 16">
      <path d="M5 0a.5.5 0 0 1 .5.5V2h1V.5a.5.5 0 0 1 1 0V2h1V.5a.5.5 0 0 1 1 0V2h1V.5a.5.5 0 0 1 1 0V2A2.5 2.5 0 0 1 14 4.5h1.5a.5.5 0 0 1 0 1H14v1h1.5a.5.5 0 0 1 0 1H14v1h1.5a.5.5 0 0 1 0 1H14v1h1.5a.5.5 0 0 1 0 1H14a2.5 2.5 0 0 1-2.5 2.5v1.5a.5.5 0 0 1-1 0V14h-1v1.5a.5.5 0 0 1-1 0V14h-1v1.5a.5.5 0 0 1-1 0V14h-1v1.5a.5.5 0 0 1-1 0V14A2.5 2.5 0 0 1 2 11.5H.5a.5.5 0 0 1 0-1H2v-1H.5a.5.5 0 0 1 0-1H2v-1H.5a.5.5 0 0 1 0-1H2v-1H.5a.5.5 0 0 1 0-1H2A2.5 2.5 0 0 1 4.5 2V.5A.5.5 0 0 1 5 0zm-.5 3A1.5 1.5 0 0 0 3 4.5v7A1.5 1.5 0 0 0 4.5 13h7a1.5 1.5 0 0 0 1.5-1.5v-7A1.5 1.5 0 0 0 11.5 3h-7zM5 6.5A1.5 1.5 0 0 1 6.5 5h3A1.5 1.5 0 0 1 11 6.5v3A1.5 1.5 0 0 1 9.5 11h-3A1.5 1.5 0 0 1 5 9.5v-3zM6.5 6a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z"/>
    </symbol>
    <symbol id="globe" viewBox="0 0 16 16">
      <path d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm7.5-6.923c-.67.204-1.335.82-1.887 1.855A7.97 7.97 0 0 0 5.145 4H7.5V1.077zM4.09 4a9.267 9.267 0 0 1 .64-1.539 6.7 6.7 0 0 1 .597-.933A7.025 7.025 0 0 0 2.255 4H4.09zm-.582 3.5c.03-.877.138-1.718.312-2.5H1.674a6.958 6.958 0 0 0-.656 2.5h2.49zM4.847 5a12.5 12.5 0 0 0-.338 2.5H7.5V5H4.847zM8.5 5v2.5h2.99a12.495 12.495 0 0 0-.337-2.5H8.5zM4.51 8.5a12.5 12.5 0 0 0 .337 2.5H7.5V8.5H4.51zm3.99 0V11h2.653c.187-.765.306-1.608.338-2.5H8.5zM5.145 12c.138.386.295.744.468 1.068.552 1.035 1.218 1.65 1.887 1.855V12H5.145zm.182 2.472a6.696 6.696 0 0 1-.597-.933A9.268 9.268 0 0 1 4.09 12H2.255a7.024 7.024 0 0 0 3.072 2.472zM3.82 11a13.652 13.652 0 0 1-.312-2.5h-2.49c.062.89.291 1.733.656 2.5H3.82zm6.853 3.472A7.024 7.024 0 0 0 13.745 12H11.91a9.27 9.27 0 0 1-.64 1.539 6.688 6.688 0 0 1-.597.933zM8.5 12v2.923c.67-.204 1.335-.82 1.887-1.855.173-.324.33-.682.468-1.068H8.5zm3.68-1h2.146c.365-.767.594-1.61.656-2.5h-2.49a13.65 13.65 0 0 1-.312 2.5zm2.802-3.5a6.959 6.959 0 0 0-.656-2.5H12.18c.174.782.282 1.623.312 2.5h2.49zM11.27 2.461c.247.464.462.98.64 1.539h1.835a7.024 7.024 0 0 0-3.072-2.472c.218.284.418.598.597.933zM10.855 4a7.966 7.966 0 0 0-.468-1.068C9.835 1.897 9.17 1.282 8.5 1.077V4h2.355z"/>
    </symbol>
    <symbol id="people-fill" viewBox="0 0 16 16">
      <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7Zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216ZM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"/>
    </symbol>
  </svg>

<main class="d-flex flex-nowrap">

  <div class="d-flex flex-column flex-shrink-0 bg-body-tertiary" style="width: 4.5rem;">
    <a href="/" class="d-block p-3 link-body-emphasis text-decoration-none" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-original-title="Icon-only">
      <svg class="bi pe-none" width="40" height="40"><use xlink:href="#logo"></use></svg>
      <span class="visually-hidden">Icon-only</span>
    </a>
    <ul class="nav nav-pills nav-flush flex-column mb-auto text-center">
      <li>
        <a href="/home" class="nav-link py-3 border-bottom rounded-0" data-bs-toggle="tooltip" data-bs-placement="right" aria-label="Home" data-bs-original-title="Home">
          <svg class="bi pe-none" width="24" height="24" role="img" aria-label="Home"><use xlink:href="#home"></use></svg>
        </a>
      </li>
      <li class="nav-item">
        <a href="/play/computer" class="nav-link active py-3 border-bottom rounded-0" aria-current="page" data-bs-toggle="tooltip" data-bs-placement="right" aria-label="Play vs Computer" data-bs-original-title="Play vs Computer">
          <svg class="bi pe-none" width="24" height="24" role="img" aria-label="Play vs Computer"><use xlink:href="#cpu"></use></svg>
        </a>
      </li>
      <li>
        <a href="/play/online" class="nav-link py-3 border-bottom rounded-0" data-bs-toggle="tooltip" data-bs-placement="right" aria-label="Play Online" data-bs-original-title="Play Online">
          <svg class="bi pe-none" width="24" height="24" role="img" aria-label="Play Online"><use xlink:href="#globe"></use></svg>
        </a>
      </li>
      <li>
        <a href="/friends" class="nav-link py-3 border-bottom rounded-0" data-bs-toggle="tooltip" data-bs-placement="right" aria-label="Friends" data-bs-original-title="Friends">
          <svg class="bi pe-none" width="24" height="24" role="img" aria-label="Friends"><use xlink:href="#people-fill"></use></svg>
        </a>
      </li>
    </ul>
    <div class="dropdown border-top">
      <a href="#" class="d-flex align-items-center justify-content-center p-3 link-body-emphasis text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
        <img src="data:image/*;base64,${base64ProfilePicture}" alt="${user.username}" width="24" height="24" class="rounded-circle">
      </a>
      <ul class="dropdown-menu text-small shadow">
        <li><a class="dropdown-item" href="/settings">Settings</a></li>
        <li><a class="dropdown-item" href="/profile">Profile</a></li>
        <li><hr class="dropdown-divider"></li>
        <li>
          <form id="logoutForm" method="POST" action="/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input class="dropdown-item" type="submit" value="Logout!" />
          </form>
        </li>
      </ul>
    </div>
  </div>

  <div class="b-divider b-vr"></div>

  <div class="container mt-4">
    <div class="row">
      <div class="col-9">
        <div id="myBoard" style="width: 580px"></div>
        <p>${user.username}</p>
        <p id="gameStatus"></p>
      </div>
      <div class="col-3">
        <h4>Game PGN:</h4>
        <div id="gamePGN" style="font-family: monospace"></div>
      </div>
    </div>
  </div>


</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

<script>
// This example uses the chess.js library:
// https://github.com/jhlywa/chess.js

// NOTE: the game object is separate from the board object
// the game object:
// - controls the state of the game
// - understands how pieces move and what moves are legal
// - knows who's turn it is
// - en passant, castling, draw logic, etc
const game = new Chess()

// the board object is "dumb":
// - shows the current position from the game
// - handles input events from users
const boardConfig = {
  draggable: true,
  onDragStart,
  onTouchSquare,
  onDrop,
  onSnapEnd,
  position: game.fen(),
  touchMove: true
}
const board = Chessboard2('myBoard', boardConfig)

updateStatus()

let pendingMove = null

// There are 5 outcomes from this action:
// - start a pending move
// - clear a pending move
// - clear a pending move AND start a different pending move
// - make a move (ie: complete their pending move)
// - do nothing
function onTouchSquare (square, piece, boardInfo) {
  // ask chess.js what legal moves are available from this square
  const legalMoves = game.moves({ square, verbose: true })

  // Option 1: start a pending move
  if (!pendingMove && legalMoves.length > 0) {
    pendingMove = square

    // add circles showing where the legal moves are for this piece
    legalMoves.forEach(move => {
      board.addCircle(move.to)
    })

  // Option 2: clear a pending move if the user selects the same square twice
  } else if (pendingMove && pendingMove === square) {
    pendingMove = null
    board.clearCircles()

  // Option 3: clear a pending move and start a new pending move
  } else if (pendingMove) {
    // ask chess.js to make a move
    const moveResult = game.move({
      from: pendingMove,
      to: square,
      promotion: 'q' // always promote to a Queen for example simplicity
    })

    // was this a legal move?
    if (moveResult) {
      // clear circles on the board
      board.clearCircles()

      // update to the new position
      board.position(game.fen()).then(() => {
        updatePGN()
        updateStatus()

        // wait a smidge, then make a random move for Black
        window.setTimeout(makeStockfishMove, 1000)
      })

    // if the move was not legal, then start a new pendingMove from this square
    } else if (piece) {
      pendingMove = square

      // remove any previous circles
      board.clearCircles()

      // add circles showing where the legal moves are for this piece
      legalMoves.forEach(m => {
        board.addCircle(m.to)
      })

    // else clear pendingMove
    } else {
      pendingMove = null
      board.clearCircles()
    }
  }
}

function updateStatus () {
  let statusHTML = ''
  const whosTurn = game.turn() === 'w' ? 'White' : 'Black'

  if (!game.game_over()) {
    if (game.in_check()) statusHTML = whosTurn + ' is in check! '
    statusHTML = statusHTML + whosTurn + ' to move.'
  } else if (game.in_checkmate() && game.turn() === 'w') {
    statusHTML = 'Game over: white is in checkmate. Black wins!'
  } else if (game.in_checkmate() && game.turn() === 'b') {
    statusHTML = 'Game over: black is in checkmate. White wins!'
  } else if (game.in_stalemate() && game.turn() === 'w') {
    statusHTML = 'Game is drawn. White is stalemated.'
  } else if (game.in_stalemate() && game.turn() === 'b') {
    statusHTML = 'Game is drawn. Black is stalemated.'
  } else if (game.in_threefold_repetition()) {
    statusHTML = 'Game is drawn by threefold repetition rule.'
  } else if (game.insufficient_material()) {
    statusHTML = 'Game is drawn by insufficient material.'
  } else if (game.in_draw()) {
    statusHTML = 'Game is drawn by fifty-move rule.'
  }

  document.getElementById('gameStatus').innerHTML = statusHTML
}

function updatePGN () {
  const pgnEl = document.getElementById('gamePGN')
  pgnEl.innerHTML = game.pgn({ max_width: 5, newline_char: '<br />' })
}

function onDragStart (dragStartEvt) {
  // do not pick up pieces if the game is over
  if (game.game_over()) return false

  // only pick up pieces for White
  if (!isWhitePiece(dragStartEvt.piece)) return false

  // what moves are available to White from this square?
  const legalMoves = game.moves({
    square: dragStartEvt.square,
    verbose: true
  })

  // do nothing if there are no legal moves
  if (legalMoves.length === 0) return false

  // place Circles on the possible target squares
  legalMoves.forEach((move) => {
    board.addCircle(move.to)
  })
}

function isWhitePiece (piece) { return /^w/.test(piece) }

async function getStockfishMove() {
  // Get the current board position as FEN
  const fen = game.fen();
  console.log(board.position('fen'))
  // Construct the URL with query parameters
  const url = new URL('/play/getBestMove', window.location.href);
  url.searchParams.append('fenPosition', fen);
  url.searchParams.append('searchDepth', 15);

  try {
    // Make a GET request to the controller's endpoint
    const response = await fetch(url);
    const result = await response.json();
    const bestMove = result.bestMove;
    console.log("The GET request comes back with:", bestMove);
    return bestMove;
  } catch (error) {
    // Handle errors if needed
  }
}

async function makeStockfishMove() {
  const bestMove = await getStockfishMove();
  console.log("The move we want to make is:", bestMove);
  const move = game.move(bestMove, { sloppy: true });
  console.log("Move object:", move);
  board.position(game.fen(), (_positionInfo) => {
    updateStatus();
    updatePGN();
  });
}



function onDrop (dropEvt) {
  // see if the move is legal
  const move = game.move({
    from: dropEvt.source,
    to: dropEvt.target,
    promotion: 'q' // NOTE: always promote to a queen for example simplicity
  })
  console.log(move);

  // remove all Circles from the board
  board.clearCircles()

  // the move was legal
  if (move) {
    // reset the pending move
    pendingMove = null

    // update the board position
    board.fen(game.fen(), () => {
      updateStatus()
      updatePGN()

      // make stockfish move
      window.setTimeout(makeStockfishMove, 1000)
    })
  } else {
    // reset the pending move
    pendingMove = null

    // return the piece to the source square if the move was illegal
    return 'snapback'
  }
}

// update the board position after the piece snap
// for castling, en passant, pawn promotion
function onSnapEnd () {
  board.position(game.fen())
}
</script>

</body>
</html>