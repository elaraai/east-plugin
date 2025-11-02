---
name: east-development
description: Write East code - a portable, type-safe functional language. Use when writing East functions, working with East IR, or creating portable computations. Automatically validates code with east_compile tool.
---

# East Development Skill

## What is East?

East is a **statically typed, expression-based functional language** embedded in TypeScript that compiles to portable **IR (Intermediate Representation)**. East enables you to write type-safe, portable computations that can execute in different environments (JavaScript, Julia, Python, etc.) without modification.

**Key Characteristics:**
- **Portable**: Compiles to IR that runs anywhere
- **Type-safe**: Strong static typing with compile-time guarantees
- **Functional**: Expression-based with immutable data structures
- **Sandboxed**: Controlled execution environment with explicit platform functions

## When to Use This Skill

Use the `east-development` skill when:
- User asks to write East functions or East code
- User wants to create portable computations or IR
- User mentions East types, expressions, or the East language
- User needs type-safe functional programming with portability
- User wants to validate East code syntax

## Quick Example

Here's a simple East function that adds two integers:

```typescript
return East.function(
  [East.IntegerType, East.IntegerType],
  East.IntegerType,
  ($, x, y) => {
    return $.return(x.add(y));
  }
);
```

This can be validated using the `east_compile` tool (provided by this plugin's MCP server).

## Documentation

This skill provides comprehensive East documentation:

- **[USAGE.md](./USAGE.md)** - Complete East developer guide covering:
  - All types (Null, Boolean, Integer, Float, String, DateTime, Blob, Array, Set, Dict, Struct, Variant)
  - Functions and expressions
  - Control flow and operations
  - JSON serialization format
  - Platform functions

- **[STDLIB.md](./STDLIB.md)** - Standard library reference covering:
  - Formatting utilities (e.g., `Integer.printCommaSeparated()`)
  - Conversion functions (e.g., `DateTime.fromEpochMilliseconds()`)
  - Generation utilities for each type

## Validation Workflow

When writing East code for users, follow this workflow:

1. **Write the function** using the East TypeScript API (see USAGE.md for syntax)
2. **Validate with `east_compile`** - call the tool to check syntax and generate IR
3. **Fix any errors** - use compilation error messages to correct issues
4. **Return validated code** - provide the working East function to the user

Example validation:
```json
{
  "typescript_code": "return East.function([East.IntegerType], East.IntegerType, ($, x) => $.return(x.add(1n)))"
}
```

## Important: No Imports Required

When calling `east_compile`, the `East` object is already injected into scope. Your code should:

- **NOT** include import statements
- **Use** `East.function()`, `East.IntegerType`, etc. directly
- **Return** an East function expression
- **Use** bigint literals for integers (e.g., `1n`, `42n`)

**Correct:**
```typescript
return East.function([East.IntegerType], East.IntegerType, ($, x) => {
  return $.return(x.add(1n));
});
```

**Incorrect:**
```typescript
import { East } from '@elaraai/east';  // ❌ Don't import
const fn = East.function(...);         // ❌ Don't assign, must return
```

## Common Patterns

### Basic Arithmetic
See USAGE.md § Integer and Float sections for arithmetic operations.

### Working with Collections
See USAGE.md § Array, Set, and Dict sections for collection operations.

### Structured Data
See USAGE.md § Struct section for working with structured types.

### Pattern Matching
See USAGE.md § Variant section for sum types and pattern matching.

### Platform Functions
See USAGE.md § Platform Functions section for declaring external functions.

## Type System Quick Reference

**Primitive Types:**
- `East.NullType` - Null value
- `East.BooleanType` - true/false
- `East.IntegerType` - Arbitrary precision integers (use bigint literals: `42n`)
- `East.FloatType` - IEEE 754 double precision floats
- `East.StringType` - Unicode strings
- `East.DateTimeType` - ISO 8601 date-times with timezone
- `East.BlobType` - Binary data

**Compound Types:**
- `East.ArrayType(T)` - Ordered list of elements
- `East.SetType(T)` - Unordered unique elements
- `East.DictType(K, V)` - Key-value mappings
- `East.StructType({field: Type, ...})` - Product types with named fields
- `East.VariantType({Tag: Type, ...})` - Sum types (tagged unions)

## Examples

For worked examples, see:
- USAGE.md - Contains comprehensive examples for each type and operation
- `examples/` directory - Additional practical examples (if present)

## Tips for Success

1. **Always validate** - Use `east_compile` to catch errors early
2. **Use bigint literals** - Integers must be `1n`, not `1`
3. **Return the function** - Code must return an `East.function()` call
4. **Check types carefully** - East is strongly typed; mismatches cause compilation errors
5. **Read error messages** - Compilation errors provide specific guidance
6. **Reference docs** - USAGE.md and STDLIB.md contain all the details

## Common Errors and Solutions

**"Code must evaluate to an East function"**
- Ensure your code returns `East.function(...)`
- Don't assign to a variable; return directly

**Type mismatch errors**
- Check that expression types match function signatures
- Verify bigint literals are used for integers
- Ensure operations are called on correct types

**"Expected bigint" errors**
- Use `42n` not `42` for integer values
- Integer literals must have the `n` suffix

## Getting Help

- Review USAGE.md for comprehensive type and operation documentation
- Check STDLIB.md for standard library utilities
- Examine compilation errors for specific guidance
- Test incrementally with `east_compile`
