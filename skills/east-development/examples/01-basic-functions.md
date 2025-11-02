# Basic East Functions - Examples

This file contains simple examples to get started with East functions.

## Example 1: Increment Function

Adds 1 to an integer:

```typescript
return East.function([East.IntegerType], East.IntegerType, ($, x) => {
  return $.return(x.add(1n));
});
```

## Example 2: Add Two Integers

Adds two integers together:

```typescript
return East.function(
  [East.IntegerType, East.IntegerType],
  East.IntegerType,
  ($, x, y) => {
    return $.return(x.add(y));
  }
);
```

## Example 3: String Concatenation

Appends "!" to a string:

```typescript
return East.function([East.StringType], East.StringType, ($, s) => {
  return $.return(s.concat("!"));
});
```

## Example 4: Boolean Comparison

Checks if an integer is greater than zero:

```typescript
return East.function([East.IntegerType], East.BooleanType, ($, x) => {
  return $.return(East.greater(x, East.value(0n)));
});
```

## Example 5: Float Multiplication

Doubles a float value:

```typescript
return East.function([East.FloatType], East.FloatType, ($, x) => {
  return $.return(x.multiply(2.0));
});
```

## Testing These Examples

Each example can be validated using the `east_compile` tool:

```json
{
  "typescript_code": "<paste example code here>"
}
```

If compilation succeeds, you'll receive the serialized IR. If it fails, you'll get a clear error message explaining what needs to be fixed.
