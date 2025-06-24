# 🧭 Pathfinding System Overview

## 🎯 Goal

Implement a basic yet scalable pathfinding system for our RTS units using Godot's Navigation2D. Start with core functionality — selecting a unit and sending it to a clicked location — and gradually expand to support formations, hazards, and dynamic AI behavior.

---

## ✅ Phase 1 — MVP Pathfinding (Chill Mode)

### Scope:
- Select a single unit by left-clicking it.
- Right-click on terrain to set a destination.
- Unit uses Godot's `Navigation2D` to move to that position.
- No animations, formations, or collision avoidance.
- Unit stops when it reaches its target (with tolerance).

### Features:
- Basic unit scene (`Unit.tscn`)
- Movement controller (`Unit.gd`)
- Navigation polygon (`NavigationRegion2D`)
- Click-detection for unit selection
- Basic movement vector logic

### Out of Scope (For Now):
- Group selection
- Path recalculation on dynamic changes
- Obstacles and traps
- Behavior states (coward, brave, berserk)
- Terrain cost (mud, fire, water, elevation)

---

## 🔁 Phase 2 — Scaled Pathing (Post-MVP)

### Additions:
- Full path queuing (follow entire path, not just destination)
- Visual indicator for selected unit
- Cancel path or retarget mid-way
- Basic terrain modifiers (slow in mud, no-pass in traps)
- Re-pathing when destination becomes invalid

---

## 🧠 Phase 3 — Tactical Logic Layer

### Advanced Systems:
- **Formation Pathing**  
  Units path while maintaining a square or triangle formation.
  
- **Group Move with Staggered Paths**  
  Units stagger or delay slightly to avoid clumping.

- **Traps & Terrain Awareness**  
  Avoid zones marked with hazards. Cost-aware A*.

- **Behavioral State Machines**  
  Units dynamically evaluate danger and choose actions:
    - Cowardly: avoid enemies and flee
    - Brave: hold ground and alert player
    - Berserk: charge target with no retreat logic

- **Alert Propagation**  
  Unit sees enemy → alerts others → sends ping to player

---

## 🔒 Edge Cases to Handle Later

- What if a unit gets stuck?
- What if terrain changes mid-path? (e.g., wall built)
- What if unit is hit mid-path? (cancel path, interrupt?)
- Building blocking re-path logic
- Multiple units heading to the same spot

---

## 🧱 Dependencies
- Godot’s `Navigation2D`
- Custom `Unit.gd` movement script
- Global input handler for click commands
- Optional: grid overlay / debug path visuals

---

## ✅ MVP Completion Checklist

- [ ] Unit can be selected
- [ ] Destination can be assigned via right-click
- [ ] Unit moves using `Navigation2D`
- [ ] Unit stops close to target
- [ ] NavMesh is functional and covers terrain

---

## 📌 Notes
- All advanced behavior will be modular and optional
- Keep pathfinding data lightweight (use path segments, not per-frame recalcs)
- Use Godot signals/events for path complete / alert triggers later
