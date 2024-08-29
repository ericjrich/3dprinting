# STP to STL Converter (stp2stl.sh)

This is a simple Bash script that uses FreeCAD to convert STP (STEP) files to STL files on Linux systems. The script provides an interactive file selection dialog using Zenity, allowing users to select multiple STP files and convert them to STL format.

## Features

- Convert multiple STP files to STL format.
- Uses FreeCAD for handling the conversion process.
- Utilizes Zenity for a graphical file selection interface.
- Keeps both the original STP files and the converted STL files in the same directory.

## Requirements

- **Linux**: This script is specifically designed for Linux systems.
- **FreeCAD**: FreeCAD must be installed and accessible via the command line.
- **Python 3**: The script uses Python 3 for running the conversion code.
- **Zenity**: Required for the graphical file selection dialog.
- **Multiprocessing support**: Utilizes all available CPU cores for efficient conversion.

## Installation

1. **Install FreeCAD**: If you don't have FreeCAD installed, you can install it using your package manager:

    ```bash
    sudo apt update
    sudo apt install freecad
    ```

2. **Install Zenity**: If Zenity is not installed, you can install it using:

    ```bash
    sudo apt install zenity
    ```

3. **Install Python 3**: Ensure Python 3 is installed on your system:

    ```bash
    sudo apt install python3
    ```

## Usage

1. **Make the script executable**:

    ```bash
    chmod +x stp2stl.sh
    ```

2. **Run the script**:

    ```bash
    ./stp2stl.sh
    ```

3. **Select STP files**: When prompted, use the Zenity dialog to select one or more STP files you wish to convert. The script will convert each selected STP file to an STL file, saving the STL in the same directory as the original STP file.

## How It Works

1. **File Selection**: The script uses Zenity to open a file selection dialog, allowing users to select multiple STP files.

2. **Conversion**: The script calls a Python script that:
   - Uses FreeCAD's Python API to open each STP file.
   - Converts each STP file to STL format.
   - Saves the STL file in the same directory as the STP file.

3. **Multiprocessing**: The Python script uses the `multiprocessing` module to convert files in parallel, utilizing all available CPU cores for efficient processing.

## Example

1. Run the script:

    ```bash
    ./stp2stl.sh
    ```

2. Select files using Zenity dialog.
3. Wait for the conversion to complete. The script will display the status of each file conversion and the total execution time.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add new feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Create a new Pull Request.

## Issues

If you encounter any issues or have suggestions for improvements, please open an issue on GitHub.

## Acknowledgments

- Inspired by [STP to STL Python Converter](https://github.com/marcofariasmx/STP-STEP-to-STL-Python-Converter/blob/main/STP-to-STL.py) by Marco Farias.
- [FreeCAD](https://www.freecadweb.org/) - The open-source CAD tool used for the conversion process.
- [Zenity](https://help.gnome.org/users/zenity/stable/) - For providing a graphical user interface for file selection.
