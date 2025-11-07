# Release Management with Release Please

This project uses [Release Please](https://github.com/googleapis/release-please) by Google for automated release management.

## Quick Start

### For Developers

Just commit with conventional commit messages:

```bash
# Bug fix (patch version bump: 1.0.0 → 1.0.1)
git commit -m "fix: resolve login timeout issue"

# New feature (minor version bump: 1.0.0 → 1.1.0)
git commit -m "feat: add CSV export"

# Breaking change (major version bump: 1.0.0 → 2.0.0)
git commit -m "feat!: redesign authentication"
```

Push to `main` and Release Please handles the rest!

### How It Works

1. **You commit** using [conventional commits](https://www.conventionalcommits.org/)
2. **Release Please** analyzes commits and creates/updates a "Release PR"
3. **You review** the Release PR (shows changelog, version bump)
4. **You merge** the Release PR
5. **Release Please** automatically:
   - Creates GitHub release with changelog
   - Tags the version (e.g., `v1.1.0`)
   - Triggers build workflow
   - Builds executables for Windows, macOS, Linux
   - Uploads binaries to the release

## Conventional Commit Format

```
<type>: <description>

[optional body]

[optional footer]
```

### Types

- `feat:` - New feature (minor version bump)
- `fix:` - Bug fix (patch version bump)
- `feat!:` or `fix!:` - Breaking change (major version bump)
- `docs:` - Documentation only
- `chore:` - Maintenance tasks
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `perf:` - Performance improvements

### Breaking Changes

Either use `!` or add `BREAKING CHANGE:` in the footer:

```bash
# Option 1: Using !
git commit -m "feat!: remove deprecated endpoints"

# Option 2: Using footer
git commit -m "feat: update authentication

BREAKING CHANGE: OAuth2 is now required instead of API keys"
```

## Examples

### Patch Release (1.0.0 → 1.0.1)

```bash
git commit -m "fix: correct validation error message"
git commit -m "fix: handle null values in response"
```

### Minor Release (1.0.0 → 1.1.0)

```bash
git commit -m "feat: add dark mode support"
git commit -m "feat: export results to PDF"
```

### Major Release (1.0.0 → 2.0.0)

```bash
git commit -m "feat!: redesign API authentication flow

BREAKING CHANGE: API now requires OAuth2 tokens instead of API keys.
Users must update their authentication configuration."
```

## Release PR Review

Release Please creates a PR with:
- Changelog of all changes since last release
- New version number
- Updated `CHANGELOG.md`
- Updated version in `pyproject.toml`

**Review checklist before merging Release PR:**
- [ ] Version bump is correct (major/minor/patch)
- [ ] Changelog accurately reflects changes
- [ ] All tests passing
- [ ] No breaking changes without proper documentation

## Manual Release (Emergency)

If you need to manually create a release:

```bash
# 1. Update version in pyproject.toml
# 2. Update CHANGELOG.md
# 3. Commit and push
git add pyproject.toml CHANGELOG.md
git commit -m "chore: release v1.2.3"
git push

# 4. Create and push tag
git tag -a v1.2.3 -m "Release v1.2.3"
git push origin v1.2.3
```

The release workflow will build and publish automatically.

## Troubleshooting

### Release PR Not Created

**Check:**
- Are you using conventional commit format?
- Did you push to `main` branch?
- Check Actions tab for Release Please workflow errors

### Wrong Version Bump

**Fix in Release PR:**
- Edit the version in `pyproject.toml` before merging
- Release Please respects manual edits in the Release PR

### Workflow Permissions

Ensure GitHub Actions has permissions:
1. Go to **Settings → Actions → General**
2. Set **Workflow permissions** to "Read and write permissions"
3. Enable "Allow GitHub Actions to create and approve pull requests"

## Resources

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Release Please Documentation](https://github.com/googleapis/release-please)
- [Semantic Versioning](https://semver.org/)

## FAQ

**Q: Do I need to manually update the version?**  
A: No! Release Please handles this automatically.

**Q: Can I skip a release for certain commits?**  
A: Yes, use types like `chore:`, `docs:`, or `style:` - these don't trigger releases.

**Q: Can I have multiple features in one release?**  
A: Yes! Release Please accumulates all commits since the last release into one Release PR.

**Q: What if I want a specific version number?**  
A: Edit the version in the Release PR before merging it.

**Q: Can I preview what will be released?**  
A: Yes! The Release PR shows exactly what will be released, including the full changelog.
