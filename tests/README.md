# Testing Directory

**⚠️ FOR TESTING PURPOSES ONLY - NOT PART OF MAIN DOTFILES DEPLOYMENT**

This directory contains test scripts and configurations for validating the dotfiles setup process. Files in this directory are automatically excluded from chezmoi deployment via `.chezmoiignore`.

## Purpose

These test files allow you to verify that `setup.sh` works correctly in a clean environment without affecting your actual system.

## Contents

- **`Containerfile`**: Podman/Docker container definition for test environment (Fedora 43 based)
- **`test-chezmoi.sh`**: Main test script that builds and runs the test container
- **`README.md`**: This file

## Requirements

- [Podman](https://podman.io/) (optimized for Podman, but Docker should work too)
- The test script is designed to run from the dotfiles repository root

## Usage

### Basic Test Run

```bash
# From the dotfiles repository root directory
cd ~/.local/share/chezmoi
./tests/test-chezmoi.sh
```

### What the Test Does

1. **Builds test image**: Creates a clean Fedora 43 container with minimal dependencies
2. **Mounts setup.sh**: Makes your setup script available in the container (read-only)
3. **Runs setup**: Executes setup.sh in CI mode (auto-confirms prompts)
4. **Interactive shell**: Drops you into a bash shell to manually verify the installation
5. **Auto-cleanup**: Container is automatically removed when you exit

### Test Environment Details

The test container:
- Based on Fedora 43 (matching target OS)
- Includes a test user with sudo privileges
- Runs in privileged mode for systemd support
- Uses host networking
- Environment variable `CI=true` is set to skip interactive prompts

### Manual Verification

After the setup script completes, you'll be in an interactive shell. You can verify:

```bash
# Check if mise is installed
command -v mise

# Check if chezmoi is installed
command -v chezmoi

# Check mise configuration
cat ~/.bashrc | grep mise

# Check chezmoi initialization
ls -la ~/.local/share/chezmoi

# Exit when done
exit
```

## Development Workflow

When modifying `setup.sh`:

1. Make your changes to `setup.sh`
2. Run `./tests/test-chezmoi.sh` to test in a clean environment
3. Verify the changes work as expected
4. If needed, rebuild the image: `podman rmi dotfiles-test` then re-run the test

## Notes

- The container is ephemeral (automatically removed after use)
- Each test run creates a fresh environment
- The test image is cached locally for faster subsequent runs
- setup.sh is mounted read-only to prevent accidental modifications during testing

## Troubleshooting

### Podman not found

```bash
# Install podman on Fedora
sudo dnf install podman
```

### Permission denied

```bash
# Make sure the script is executable
chmod +x tests/test-chezmoi.sh
```

### Image build fails

```bash
# Remove cached image and rebuild
podman rmi dotfiles-test
./tests/test-chezmoi.sh
```

## Exclusion from Deployment

This entire `tests/` directory is excluded from chezmoi deployment. See `.chezmoiignore` for details.
