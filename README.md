# Firesands Auth Matrix

A comprehensive tool for testing API authorization matrices across different user roles and endpoints. This application helps developers verify that their APIs properly restrict access based on user authentication levels.

## Features

- **Multi-format Support**: Import from Postman collections or AuthMatrix format
- **Graphical Interface**: User-friendly PySide6-based GUI
- **Role-based Testing**: Configure multiple user roles with different authentication levels
- **Batch Testing**: Test all endpoints across all roles simultaneously
- **Visual Results**: Clear matrix view of test results with pass/fail indicators
- **Export Capabilities**: Export configurations in multiple formats

## Installation

### Prerequisites

- Python 3.8 or higher
- pip package manager

### Install Dependencies

```bash
pip install -r requirements.txt
```

## Usage

### GUI Mode (Recommended)

Launch the graphical interface:

```bash
python Firesand_Auth_Matrix.py
```

### Command Line Mode

Run tests directly from command line:

```bash
python Firesand_Auth_Matrix.py your_spec_file.json
```

## Configuration

### AuthMatrix Format

AuthMatrix files use a specific JSON format with the `#!AUTHMATRIX` shebang:

```json
#!AUTHMATRIX
{
  "base_url": "https://api.example.com",
  "default_headers": {
    "Accept": "application/json",
    "Content-Type": "application/json"
  },
  "roles": {
    "guest": {
      "auth": {"type": "none"}
    },
    "user": {
      "auth": {"type": "bearer", "token": "user_token_here"}
    },
    "admin": {
      "auth": {"type": "bearer", "token": "admin_token_here"}
    }
  },
  "endpoints": [
    {
      "name": "Public Endpoint",
      "method": "GET",
      "path": "/public",
      "expect": {
        "guest": {"status": 200},
        "user": {"status": 200},
        "admin": {"status": 200}
      }
    },
    {
      "name": "User Profile",
      "method": "GET",
      "path": "/user/profile",
      "expect": {
        "guest": {"status": 403},
        "user": {"status": 200},
        "admin": {"status": 200}
      }
    },
    {
      "name": "Admin Dashboard",
      "method": "GET",
      "path": "/admin/dashboard",
      "expect": {
        "guest": {"status": 403},
        "user": {"status": 403},
        "admin": {"status": 200}
      }
    }
  ]
}
```

### Postman Collections

You can also import Postman collections. The tool will:

1. Extract endpoints from the collection
2. Convert authentication settings
3. Allow you to configure expected behaviors for different roles

#### Single Collection Import

Import one Postman collection and manually configure authorization expectations.

#### Multiple Collection Import

Import multiple collections representing different access levels:
- `Admin.postman_collection.json` - Endpoints accessible to admins
- `User.postman_collection.json` - Endpoints accessible to users  
- `Public.postman_collection.json` - Public endpoints

The tool will automatically infer authorization patterns based on which collections contain each endpoint.

## GUI Overview

### Main Interface

1. **Base URL**: Set the base URL for your API
2. **Headers Tab**: Configure default headers for all requests
3. **Endpoints Tab**: Define and configure API endpoints
4. **Tokens Tab**: Manage authentication tokens for different roles
5. **Results Section**: View test results in a matrix format

### Import/Export

- **Import**: Load specifications from AuthMatrix files or Postman collections
- **Export**: Save configurations in AuthMatrix or Postman format
- **Run**: Execute all tests and view results

### Test Results

Results are displayed in a matrix showing:
- ✅ **PASS**: Expected status code received
- ❌ **FAIL**: Unexpected status code received  
- ⏭️ **SKIP**: No expectation configured
- **HTTP codes**: Actual response codes
- **Latency**: Response time in milliseconds

## Project Structure

```
FiresandsAuthMatrix/
├── Firesand_Auth_Matrix.py      # Main application entry point
├── split_collections.py         # Utility for splitting collections
├── demo_auth_matrix.json       # Example AuthMatrix specification
├── demoapi.json                # Example API configuration
├── UI/                         # GUI components
│   ├── __init__.py
│   ├── UI.py                   # Main UI logic
│   ├── components/             # Reusable UI components
│   │   ├── DialogUtils.py
│   │   ├── LogoHeader.py
│   │   └── TabsComponent.py
│   └── views/                  # Main application views
│       ├── Endpoints.py
│       ├── Headers.py
│       ├── Results.py
│       ├── SpecStore.py
│       ├── Theme.py
│       └── Tokens.py
```

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes and add tests
4. Commit your changes: `git commit -am 'Add feature'`
5. Push to the branch: `git push origin feature-name`
6. Submit a pull request

For more details, see [CONTRIBUTING.md](CONTRIBUTING.md).

## Releases and Versioning

This project uses **[Release Please](https://github.com/googleapis/release-please)** for automated release management.

### How It Works

1. **Commit with conventional commits**: Use `feat:`, `fix:`, `feat!:` in your commit messages
2. **Push to main**: Release Please automatically creates/updates a "Release PR"
3. **Review the Release PR**: See what will be in the release (changelog, version bump)
4. **Merge the Release PR**: Release Please automatically:
   - Creates a GitHub release
   - Tags the version
   - Builds executables for Windows, macOS, and Linux
   - Uploads binaries to the release

### Conventional Commit Examples

```bash
# Patch release (1.0.0 → 1.0.1)
git commit -m "fix: resolve authentication timeout"

# Minor release (1.0.0 → 1.1.0)
git commit -m "feat: add CSV export functionality"

# Major release (1.0.0 → 2.0.0)
git commit -m "feat!: redesign authentication API"
# or
git commit -m "feat: change auth flow

BREAKING CHANGE: authentication now requires OAuth2"
```

See [Conventional Commits](https://www.conventionalcommits.org/) for more details.

### Viewing Release History

Check [CHANGELOG.md](CHANGELOG.md) (auto-generated) or the [Releases page](../../releases).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions:

1. Check the [Issues](../../issues) page for existing problems
2. Create a new issue with detailed information about your problem
3. Include sample configurations and error messages when applicable

## Examples

See the `demo_auth_matrix.json` file for a complete example configuration.

## Roadmap

- [ ] Support for additional authentication methods (API keys, OAuth)
- [ ] Custom assertion scripting
- [ ] Integration with CI/CD pipelines
- [ ] Performance benchmarking features
- [ ] Advanced reporting and analytics