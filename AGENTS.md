# AGENTS.md

## Purpose

This repo is a small personal dotfiles repo, not an app or library.
Optimize for safe, minimal edits. Most changes here are shell ergonomics, config tweaks, or setup docs.

## Repository Shape
- `.zshenv` runs for every zsh process; keep it tiny and side-effect light.
- `.zprofile` is for login-shell setup.
- `.zshrc` is for interactive aliases, prompt config, completions, and integrations.
- `.gitconfig` is plain INI-style Git config.
- `dev environment setup.md` is beginner-facing documentation.

There is no package manifest, Makefile, CI config, formatter config, or dedicated test suite.

### Primary checks

Syntax-check all tracked zsh files:
```sh
zsh -n .zshrc .zprofile .zshenv
```

Syntax-check a single file:

```sh
zsh -n .zshrc
zsh -n .zprofile
zsh -n .zshenv
```

Load all startup files in a clean subprocess:

```sh
zsh -fc 'source ./.zshenv && source ./.zprofile && source ./.zshrc'
```

Probe one alias, function, or variable after sourcing:

```sh
zsh -fc 'source ./.zshrc && alias gs'
zsh -fc 'source ./.zshrc && whence -w br'
zsh -fc 'source ./.zshrc && print -r -- "$EDITOR|$VISUAL|$CLICOLOR"'
```

### What counts as a "single test"

Because there is no test runner, a single test usually means one focused command such as:
- `zsh -n .zshrc`
- `zsh -fc 'source ./.zshrc && alias oc'`
- `zsh -fc 'source ./.zshrc && whence -w precmd_vcs_info'`

### Notes

- `shellcheck` and `shfmt` are not configured in this repo and were not installed during analysis.
- If you add either tool, document the exact command here and keep the change small.
- These baseline smoke tests succeeded while creating this file:
```sh
zsh -n .zshrc .zprofile .zshenv
zsh -fc 'source ./.zshenv && source ./.zprofile && source ./.zshrc && alias gs && whence -w br'
```

## Editing Principles

- Prefer minimal diffs.
- Preserve the current repo shape; do not add tooling casually.
- Do not replace shell code with another language.
- Avoid broad refactors unless the user explicitly asks for them.
- Keep personal environment choices intact unless the user asks to change them.

## Code Style

### Startup file boundaries

- Put interactive behavior in `.zshrc`, not `.zshenv`.
- Keep `.zshenv` fast, portable, and safe for every zsh invocation.
- Keep login-only setup in `.zprofile`.
- Do not move code across startup files without a clear shell-startup reason.

### Imports / sourcing

For shell config, "imports" means `source` or `.`.

- Keep sourcing near the feature it enables.
- Quote variable-based paths: `"$HOME/.cargo/env"`.
- Prefer `$HOME/...` over hard-coded absolute paths outside the home directory.
- Do not add expensive `source` calls to `.zshenv`.

### Formatting
- Follow the surrounding style before imposing a new one.
- Prefer one logical statement per line.
- Preserve blank lines between sections.
- Prefer short, readable lines.
- Use two-space indentation for new shell blocks and arrays.
- If an existing block uses tabs, preserve the local style instead of reindenting unrelated lines.

### Types and scope
Shell has no static types here, so scope carefully.
- Prefer `local` or `typeset` inside functions instead of leaking globals.
- Use arrays for path-like collections.
- Use uppercase names for exported environment variables.
- Use short lowercase temporary locals when the scope is tiny.

### Naming conventions
- Aliases are short and lowercase: `gs`, `gd`, `pn`, `oc`.
- Functions are lowercase and concise: `br`, `precmd_vcs_info`.
- Exported env vars are uppercase: `EDITOR`, `VISUAL`, `CLICOLOR`.
- Match the existing short Git alias style in `.gitconfig`.

### Quoting and expansion
- Use single quotes for literal alias bodies when interpolation is unnecessary.
- Use double quotes when expansion is required.
- Prefer `${var}` or zsh parameter expansion only when it improves clarity or is required.
- Do not remove necessary zsh-specific syntax such as `${func:t}`.

### Error handling
- Check exit codes explicitly when failure matters.
- Clean up temporary files on both success and failure paths.
- Return the original non-zero status when possible.
- Keep best-effort fallbacks narrow and intentional, for example `2>/dev/null || :`.
- Avoid silent behavior changes in login/startup flows.

### Comments
- Keep comments short and practical.
- Preserve provenance comments from installed/generated shell blocks.
- Do not add comments for obvious aliases or assignments.
- Add comments only when placement or shell behavior is non-obvious.

## File-Specific Guidance
- `.zshrc`: main place for aliases, prompt config, `fpath`, autoloading, and interactive integrations. Preserve section ordering unless regrouping clearly helps. The `br` function comes from the broot post-install script; avoid rewriting it unless necessary. Prompt code already uses `vcs_info`; prefer built-ins over heavier prompt frameworks.
- `.zprofile`: keep the OrbStack initialization intact unless the user asks otherwise. Preserve the quiet optional-integration pattern `2>/dev/null || :`.
- `.zshenv`: keep it minimal. Only put environment setup here that must exist for every zsh process.
- `.gitconfig`: preserve INI formatting, keep aliases short and consistent with current single-letter patterns, and do not change Git identity unless explicitly asked.
- `dev environment setup.md`: keep docs task-oriented and beginner-readable, use fenced shell blocks for commands, and prefer step-by-step instructions over dense prose.

## What To Avoid
- Do not add plugin managers, frameworks, or large dependency systems without a request.
- Do not add machine-specific absolute paths outside `$HOME` unless clearly required.
- Do not add secrets, tokens, or private hostnames.
- Do not silently normalize generated blocks if that risks changing behavior.
- Do not assume Bash compatibility; this repo is zsh-first.

## Suggested Agent Workflow
1. Read the target dotfile and adjacent startup files.
2. Make the smallest safe change.
3. Run `zsh -n` on the affected file, or on all zsh files for shared changes.
4. If behavior changed, run one focused `zsh -fc` probe for that alias, function, or variable.
5. Summarize the user-visible shell impact clearly.

## When To Update This File
Update `AGENTS.md` whenever the repo gains a formatter or linter config, a Makefile or task runner, automated tests, Cursor rules, Copilot instructions, or additional shell scripts or non-shell source files.
Keep the guidance concrete and repo-specific.
