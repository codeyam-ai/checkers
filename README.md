# Ethos Checkers

A fully on-chain checkers game. Built on [Sui](https://sui.io) by [Ethos](https://ethoswallet.xyz).

Ethos Checkers consists of a smart contract that allows the player to mint a game that is playable on chain.

You can't yet play Ethos Checkers, but you can play [Ethos Chess](https://ethoswallet.github.io/chess) and [Sui 8192](https://ethoswallet.github.io/Sui8192). We are working on a front-end that will allow you to play Ethos Checkers soon.

## Sui

This project is built on the [Sui blockchain](https://sui.io), which provides the performance necessary for a great game experience. Every move is a transaction that is recorded on-chain, making the gameplay verifiable, shareable, and transferable. Each game is an NFT that can be sent to anyone and will display in a web3 wallet (such as the [Ethos Wallet](https://chrome.google.com/webstore/detail/ethos-wallet/mcbigmjiafegjnnogedioegffbooigli)).

## Ethos

This project uses the [Ethos APIs](https://ethoswallet.xyz/developers) to make the Ethos Checkers game accessible to people who do not yet have a web3 wallet. It allows them to start playing the game right away without having to figure out a wallet first.

As far as the game is concerned every player has a wallet because the [Ethos APIs](https://ethoswallet.xyz/developers) provide a unified interface for both players with and without wallets.

The primary methods that this game uses to do this are:

`<EthosWrapper>`, `SignInButton`, and `ethos.transact()`

Each of these can be found by searching in `js/game.js`

- The Ethos APIs currently require `react` and `react-dom` which is why they are included.

## The Smart Contract

The Ethos Checkers smart contract is written Sui Move for deployment on the Sui blockchain. It consists of three parts:

1. **Game:** Primarily entry functions for making moves and recording the overall game state.

2. **Game Board:** Most of the game logic.

The code for the smart contract is in the "move" folder.

### Working With The Smart Contract

From the `move` folder:

#### Build

`sui move build`

#### Test

`sui move test`

or

`sui move test --filter SUBSTRING`

#### Deploy

`sui client publish --gas-budget 3000`
