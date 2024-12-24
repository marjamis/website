---
title: Advent of Code Lessons
---

## Patterns

### Create distributions of data

#### When to use

- If the data can be grouped together, either by the inputs or expected outputs. i.e. don't treat each "object" separately but rather treat the group as a whole
- Simple calculations can be used to perform the work instead of laborious "simulation" via iterating

#### Examples

- [Year 2021 - Day 6 - Part 2](https://github.com/marjamis/advent-of-code/blob/main/internal/pkg/advent2021/day6.go#L58-L82)

### Invert your thinking

#### When to use

- If something looks to complex or you're trying to get specific bits of data, perhaps you can invert the solution and remove the parts you don't want. This may make for a cleaner solution, or just as a simpler one while being the opposite of the way you would normally thing of solving the issue.

#### Examples


- [Year 2024 - Day 3 - Part 2](https://github.com/marjamis/advent-of-code/blob/main/internal/pkg/advent2021/day6.go#L58-L82) - I initially was regex'ing out the specific data I wanted, which also works but was a more completed solution requiring two regexes. Removing the invalid data left it easier to simply process the right data for the solution
