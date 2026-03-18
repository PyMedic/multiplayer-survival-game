# multiplayer-survival-game

A real-time multiplayer 2D survival game, built to demonstrate game architecture, system design, and real-time networking.

## Game
Players must gather resources, craft tools, survive freezing temperatures, and choose between cooperation or conflict.

## Project Highlights
- Real-time multiplayer gameplay
- Survival mechanics (temperature, crafting, resource gathering)

## Tech Stack
### Client
- Godot (GDScript)
- 2D TileMap-based World

### Server
- TBD

## Core Gameplay Features
### 1. Multiplayer System
- Supports up to 4 concurrent players
- Real-time posistion synchronization

### 2. Survival Mechanics
- Players gradually lose health if they remain outside for too long due to the cold.
- Campfires restore health.
- Resource management is required for survival.

### 3. Resource Gathering
- Chop trees to collect wood.
- Use resources to craft survival tools.

### 4. Crafting System
- Convert wood into campfires.
- Craft tools to chop trees.

### 5. Combat System
- TBD

### 6. AI system
#### Wild Animals
- Wolves:
  - Detect nearby players.
  - Will chase and atack.