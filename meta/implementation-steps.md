Implementation Checklist — Everforest Resources

Ordered steps to bring the repository from empty → working, following the Full Consolidated Spec. All steps MUST be executed in this order unless noted. LLM AGENTS SHALL NOT DEVIATE FROM THE THEME SPEC.

⸻

0) Initialize repository

git init
git remote add origin git@github.com:ivuorinen/everforest-resources.git

1) Scaffold files & structure

- Create file tree exactly as specified in “Everforest Resources — File Tree”.
- Add empty placeholder files where content will be generated (e.g., terminals/*, editors/*, cli/*, web/css/everforest.css).
- Create template.txt files in each CLI tool directory with color placeholders (e.g., {{bg}}, {{fg}}, {{red}}).

2) package.json & tooling

- Add npm scripts: generate, validate, ci, snapshots, prepare.
- Add devDependencies: husky, @commitlint/config-conventional, @playwright/test.
- Add commitlint.config.js.
- Run: npm i && npm run prepare (installs Husky).

3) GitHub setup

- Add .github/workflows: build.yml, snapshots.yml, commitlint.yml, cli-verify.yml.
- Add .github/CODEOWNERS with @ivuorinen.
- In repo settings: enable branch protection → require all four checks.

4) Generator core (scripts/generate-themes.mjs)

- Implement palette loader (JSON/YAML).
- Implement template system: read template.txt files and replace color placeholders with palette values.
- Implement writers for terminals: WezTerm, Alacritty, Kitty, Windows Terminal, Ghostty.
- Implement web CSS writer (media queries + forced themes + contrast attributes).
- Implement CLI template processors for: ls_colors, dircolors, eza/exa, ripgrep, fzf, delta, bat, htop, starship, zsh (pure/p10k), fish (colors + prompts), tmux, btop, bottom, glances, neofetch, ranger, lf, mc, lazygit, gitui, tig, fd, jq, less, zoxide, atuin.
- Implement editors: Neovim minimal with options, VS Code 6 variants + package.json, Zed, Sublime Text.
- Implement JetBrains .icls generator (save for last due to complexity).
- Ensure all writers are called in main() and produce all six variants where applicable.

5) No-raw-hex guard & pre-commit

- Add scripts/no-raw-hex.mjs (block hex outside palettes, terminals, web/css).
- Add .husky/pre-commit to run: no-raw-hex → generate → validate.
- Add .husky/commit-msg to run commitlint.

6) Web demo & snapshots

- Create web/demo with index.html (variant/contrast switcher), style.css, demo.js.
- Add Playwright test web/demo/snapshot.spec.js.
- Verify: npm run snapshots → artifacts.

7) Installer & verifier

- Add cli/install.sh (symlink/copy all configs; load dircolors).
- Add verify/verify.sh (build Debian container; check tools; fish sourcing).
- Integrate cli-verify job in CI (temp HOME, installer, then verifier).

8) Documentation

- README.md: TL;DR, Required checks (merge gating), terminal/web/CLI/editor usage summaries.
- CONTRIBUTING.md: rules, workflow, PR checklist, Conventional Commits.
- docs/CLI.md: one‑pager; ensure all examples use **indented code blocks**.
- Enforce documentation rule: no triple backticks; only indented code blocks.

9) Palette population

- Add palettes/everforest.json (and/or .yaml) with canonical values.
- Validate: npm run generate produces deterministic outputs.

10) Local validation

- Run: npm run generate
- Run: npm run validate
- Run: make snapshots (or npm run snapshots)
- Run: ./cli/install.sh then ENGINE=docker ./verify/verify.sh

11) First commit & PR

git add -A
git commit -m "feat: initial scaffold and generator"
git push -u origin main
- Open PR (if using a dev branch) → ensure all checks pass.

12) Post-merge tasks

- Tag v0.1.0
- (Optional) Build VS Code VSIX (vsce) and attach to release.
- Announce repository as the canonical Everforest resource hub.


⸻

Ongoing maintenance

- Palette-only changes → regenerate → validate → commit.
- Add new targets by extending the generator (never hand-edit outputs).
- Keep docs and CI in lockstep with generator capabilities.

Non-negotiable rules

- Indented code blocks only in docs (no triple backticks).
- No raw hex in CLI configs; GUI hex only from generator.
- LLM AGENTS SHALL NOT DEVIATE FROM THE THEME SPEC.
