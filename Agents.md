agents.md
🤖 Purpose
This document sets expectations, coding standards, and workflow best practices for all AI coding agents (like OpenAI Codex, GPT, Copilot, etc.) contributing to the Kingdoms & Caravans RTS codebase. It ensures AI-generated contributions are clean, modular, and match our game’s design philosophy.

🧠 Core Behaviors
Respect project conventions:
Follow folder structures, naming conventions, and modular design as described in /README.md and project documentation.

Be data-driven:
Favor pulling game logic and configuration from JSON and external data files, not hardcoding.

Single-responsibility:
Each script/class should do one thing well. Refactor large files into smaller, focused modules where possible.

Document everything:
Add clear, concise docstrings and inline comments, especially for new systems or changes to existing architecture.

🛠️ Coding Standards
Language: Godot GDScript (4.x). Use idiomatic syntax and type hints.

File organization:

Scripts in /Scripts/ (one per system or unit).

Scenes in /Scenes/.

Data in /Data/ as JSON.

UI, Audio, and Assets in their respective folders.

Node access:
Use @onready or @export variables for node references—no hardcoded paths.

Signals:
Use Godot’s signals for communication between systems. Avoid tight coupling.

🚦 Task Guidance for AI Agents
When taking a task, always:

Check for existing systems before adding new ones. Prefer integration over duplication.

Update all relevant files:

For new units/buildings: Add to JSON, create scene, add script, hook into managers.

For new features: Update any related managers, UI, and documentation.

Write and update tests where relevant, using Godot’s test tools.

Update this file if project conventions or agent practices evolve.

📝 Pull Request & Commit Rules
Commit messages:
Use present-tense, clear summaries (e.g., Add basic Archer unit logic and data schema).

PRs:

Include a “Testing Done” section—describe how code was tested in the Godot editor or with test scenes.

Reference all related files and systems.

Briefly describe why architectural choices were made, especially if something deviates from the norm.

🧩 Example Agent Workflow
Adding a new building:

Add placeholder .tscn in /Scenes/

Create script in /Scripts/

Update /Data/buildings.json

Integrate with BuildingManager.gd and ResourceManager.gd

Update docs

Refactoring an old system:

Break large scripts into smaller modules

Write migration or adapter code if needed

Leave TODO/FIXME comments for any incomplete sections

🗣️ Collaboration & Handoff
Leave context comments on unfinished work, assumptions, or caveats.

Tag files or lines with # AI_AGENT_NOTE: for important context for other agents/humans.

Use clear, human-readable variable and function names.

🔒 Safety & Quality
Never commit secrets, credentials, or user data.

Do not add analytics, tracking, or network code unless the task explicitly requires it.

Review and test code locally before merging or opening PRs.

🚀 Prompt Examples for Codex
“Add a barracks.gd that follows the pattern in agents.md and hooks into BuildingManager.gd.”

“Refactor the worker assignment logic to be more modular. Document the new methods.”

“Generate a test scene for formation movement, using the selection and command conventions from the docs.”

📚 See Also
/README.md (for project vision)

gameplan.md (gameplay loop & feature roadmap)

resource_flow.md, Pathing.md, etc. (system details)

If in doubt: prefer clarity, simplicity, and integration over cleverness or overengineering.
Leave the codebase better than you found it!
