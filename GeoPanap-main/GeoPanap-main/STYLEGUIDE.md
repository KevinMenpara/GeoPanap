### Style Guide

1. Before running query to the tooljet, Run the query in dbeaver.
2. We are following the `camelCase` pattern.
3. Component name should be in `Desktop` or `Mobile` prefix.
4. Make sure you wrapper error prune code with `try...catch`.
5. To display error we are using "error" type toast.
6. To display success we are using "success" type toast.

### Message format

- Success message format should be `subject action successfully!`.
- Error message display directly with `err.toString()`.
