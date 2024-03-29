# Simulate Conway's Game of Life
This script simulates variations of Conway's Game of Life, a cellular automaton devised by mathematician John Conway. The Game of Life is a zero-player game where the evolution of the grid is determined by the initial state and a set of rules that govern the birth, survival, and death of cells.

## Features
- Customizable grid size to adjust the dimensions of the cellular automaton
- Adjustable number of iterations to control the simulation duration
- Configurable initial probability of a cell being alive at the start
- Support for different birth and survival rules, including:
  - Conway's original rules (B3/S23)
  - B2/S: Born if 2 live neighbors, survives if any live neighbors
  - B36/S23: Born if 3 or 6 live neighbors, survives if 2 or 3 live neighbors
- Real-time visualization of the grid evolution, enabling users to observe emerging patterns

## License
This code is licensed under the MIT license found in the LICENSE file in the root directory of this source tree.

## Usage
To run the simulation, you will need R installed on your computer. You can then execute the script in an R environment. The main function `game_of_life()` takes four optional arguments:

### Parameters
- `size`: Edge length of the square grid (total cells: size^2; default: 20)
- `tlength`: Number of iterations to run (default: 50)
- `prob`: Initial probability of a cell being alive (between 0 and 1; default: 0.5)
- `rule`: Birth and survival rules (one of: "B3/S23", "B2/S", "B36/S23"; default: "B3/S23")

### Examples
Run the simulation with default parameters:
```r
game_of_life()
```
Run the simulation with a 50x50 grid, 100 iterations, initial probability of 0.25, and "B36/S23" rules:
```r
game_of_life(size = 50, tlength = 100, prob = 0.25, rule = "B36/S23")
```

## Installation
No installation is required beyond having R and the necessary libraries. To run the script, simply clone this repository or download the script file and execute it within your R environment.
