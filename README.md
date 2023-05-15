# Tag Validation Action

This action validates the tag on each push event. The validation checks if the branch is the main, the release version starts with a release prefix, and it's not a pre-release. In the case of a pre-release, the validation will still be successful.

## Usage

To use this action in your workflow, you can add the following step:

```yaml
- name: Tag Validation
  uses: ./   # Uses an action in the root directory
  with:
    preRelease: false  # Optional, default is false
```

## Parameters

- `preRelease`: (optional) a boolean that determines if the tag should be treated as a pre-release. Default is `false`.

## Example Workflow

Here is a simple example of a workflow that uses the tag validation action:

```yaml
name: Build and Deploy

on: 
  push:
    tags:
      - '*'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Validate tag
      uses: ./
      with:
        preRelease: false

    # Continue with the rest of your job steps...
```

## Contributing

Contributions are always welcome! Please feel free to submit a pull request.

## License

See the LICENSE file for more information.