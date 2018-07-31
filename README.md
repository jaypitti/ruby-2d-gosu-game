# SIMPLE 2D GAME

Hello!

This is my simple 2D game, it is just a side project I have been working on and
I am open to any feedback!

## Prerequisites

There are a couple things you need to run it.

You will need to have the [Gosu gem installed](https://rubygems.org/gems/gosu/versions/0.10.8).

### Multiplayer Option

If you are wanting to test the online multiplayer you will need to install
the [Celluloid gem](https://rubygems.org/gems/celluloid/versions/0.17.3).

## Getting Started

### Download or clone the repo

Type the following into your terminal to create a copy of the repository, then navigate into the repository and install dependencies: 

```bash
git clone https://github.com/jaypitti/ruby-2d-gosu-game.git
cd ruby-2d-guso-game
bundle
```

### Start the game
From the project's root directory run the following to start the game:

```bash
ruby Game.rb
```

### Start the server
To start the server and game, you will need to have two terminal windows open, both in the root of the project directory. 

In the first, run the following to start the server:

```bash
ruby GameServer.rb
```

Then, run the following in the second tab to start the game.

```bash
ruby Game.rb
```

## Built With

RUBY  
GOSU  
CELLULOID  


## Version

0.1.7

## Author

Jandrei Pitti

