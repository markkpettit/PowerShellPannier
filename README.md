# PowerShellPannier

PowerShellPannier: Hack your way through tasks with this go-to toolkit of essential, ready-to-use PowerShell scripts and tools. Always at your disposal for any task."

## Table of Contents

1. [Installation](#installation)
2. [Usage](#usage)
3. [Contribution](#contribution)
4. [License](#license)

## Installation

To use the scripts in PowerShellPannier, follow these steps:

1. Clone the repository to your local machine.
```shell
git clone https://github.com/markkpettit/PowerShellPannier.git
```

2. Navigate to the repository folder:
```shell
cd PowerShellPannier
```

3. Copy the scripts into one of your PowerShell module paths, for example:
```shell
Copy-Item .\GetVolumeInfo.psm1 -Destination $env:USERPROFILE\Documents\WindowsPowerShell\Modules\GetVolumeInfo\GetVolumeInfo.psm1
```

## Usage

After the scripts are copied to your PowerShell module path, you can import and use them as follows:

1. Start PowerShell.

2. Import the desired module:
```shell
Import-Module GetVolumeInfo
```

3. After importing, you can now use any cmdlets or functions defined in the script.

## Contribution

Contributions are welcome! To contribute:

1. Fork this repository.
2. Create a new branch on your forked repository.
3. Add or modify the scripts in your branch.
4. Push your changes to your branch.
5. Submit a pull request to merge your branch into the master branch of the original PowerShellPannier repository.

Please include a description of your changes when you submit your pull request.

## License

This project is licensed under the GPL v3.0 License. See the [LICENSE](LICENSE) file for details.
