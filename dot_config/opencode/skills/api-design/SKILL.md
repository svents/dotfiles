---
name: api-design
description: Design well-structured APIs with a well defined workflow.
---

# API Design

## Overview

Design APIs by working from the consumer's perspective outward. Define the contract first, then implement against it. This skill enforces a three-phase workflow:

1. **Interface** — Define the API purely as types/interfaces (no implementation).
2. **Documentation** — Add doc comments to every exported item.
3. **Tests** — Write tests that exercise the interface from the consumer's perspective.

## When to Use This Skill

Use this skill when:

- Designing a new module, service, or library with a public API
- Refactoring an existing API to improve clarity or ergonomics
- Adding a new feature that requires a public interface
- Reviewing an API design for consistency and usability

## Three-Phase Workflow

### Phase 1: Design the Interface

Define the API purely as an interface. No implementation.

**Principles:**

- Start from the consumer's point of view. Write the code you wish you had.
- Prefer explicit over implicit. Every parameter should have a clear purpose.
- Keep interfaces small and focused. A single interface should do one thing well.
- Use generics where the abstraction is genuine, not where it adds complexity.
- Return `Result`/`Promise` types to surface errors explicitly. Don't hide failure paths.
- Name methods after the action they perform, not the mechanism they use.

**Steps:**

1. Identify the core responsibility of the API.
2. Define the primary interface/type that exposes that responsibility.
3. Define any supporting types (errors, configs, responses) the interface depends on.
4. Review: can a consumer use this interface without reading anything but the type signatures?

### Phase 2: Document with Doc Comments

Add documentation to every exported item using doc comments.

**Requirements:**

- Every exported interface, type, function, and method must have a doc comment.
- The first sentence is a brief summary (one line, imperative mood).
- If the item has non-obvious behavior, add a second paragraph explaining it.
- Document all parameters, return values, and error/throw types.
- Use `@example` when the API is not self-evident from the signature.
- Avoid restating the type signature in prose — document *why*, not *what*.

**Doc comment format:**

```
/// Brief one-line summary describing what the item does.
///
/// If needed, a second paragraph elaborates on behavior,
/// constraints, or usage notes that aren't obvious from
/// the type signature.
///
/// @param name - Description of the parameter.
/// @returns Description of the return value.
/// @throws/@returns When error occurs - Description of the error.
```

### Phase 3: Create Tests

Write tests that exercise the interface from a consumer's perspective.

**Requirements:**

- Test every public method on the interface.
- Test the happy path first, then edge cases, then error paths.
- Each test should exercise one behavior. Name the test after the behavior.
- Use the interface as a consumer would — never bypass it with internal calls.
- Test error conditions: invalid input, empty input, boundary values, concurrent access.
- Aim for failure cases to be at least 50% of the test suite.

**Steps:**

1. Write the happy path test first to confirm the interface works.
2. Add edge case tests (empty, null, boundary values).
3. Add error path tests (invalid input, failure modes).
4. Review: do the tests read as a specification of the API's behavior?

## API Design Checklist

Before finalizing an API design, verify:

- [ ] The interface can be used correctly by inspection of its type signature alone.
- [ ] Every exported item has a doc comment.
- [ ] Error types are explicit and distinguishable.
- [ ] The interface follows a consistent naming convention.
- [ ] Tests cover happy path, edge cases, and error paths.
- [ ] The interface has no unnecessary public members (minimize the surface area).
- [ ] Consumers cannot put the API into an invalid state (enforced by types).

## Bottom Line

Interface first. Document everything. Test the contract. The implementation can always change — the contract is what consumers depend on.
