# GitHub Copilot Instructions - Sinergia Fisioterapia

- **GitFlow Rule**: Never commit directly to `master` or `develop`. Always branch from `develop`: `git checkout develop && git pull origin develop && git checkout -b <type>/<description>`.
- **Branch Naming**: `feat/*`, `fix/*`, `refactor/*`, `chore/*`, `docs/*`, `hotfix/*`.
- **Commits**: Conventional Commits format (`feat:`, `fix:`, `refactor:`, `test:`, etc.).
- **PRs**: Target branch must always be `develop`. Deploys to Homologation automatically. Production releases require PR to `master`, approval from Tech Lead `WallasAR`, and a SemVer tag (`vX.Y.Z`).
