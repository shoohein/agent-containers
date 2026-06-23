# Agent Instructions

## Verification Workflow

You run inside a container and cannot execute verification commands directly.
Instead:
1. Present the verification command(s) to run in copy-pasteable markdown code blocks
2. Ask the user to execute them and paste the output
3. Evaluate the output and report the result

### Error Handling
- **Command failure**: Analyze the error output, suggest a fix or alternative, and ask the user to re-run
- **Truncated/Incomplete output**: Ask the user to re-run with specific flags (e.g., `--verbose`) to capture full details
- **User unable to run**: Suggest an alternative approach or a simpler command
