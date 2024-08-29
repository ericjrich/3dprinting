#!/bin/bash

# Function to run Python code for converting STP to STL using FreeCAD
convert_stp_to_stl() {
    local stp_files_string="$1"  # Capture all selected files as a single string
    python3 - <<END
import time
import multiprocessing
from functools import partial
import os
from os.path import isfile, join
import sys

# Set the FreeCAD library path for Linux
FREECADPATH = '/usr/lib/freecad/lib/'  # Adjust this to match your FreeCAD path if different

# Append FreeCAD path to sys.path
sys.path.append(FREECADPATH)

# Import FreeCAD modules
import FreeCAD as App
import Part
import Mesh

def converter(filesPath, totalFiles, file):
    """
    Convert a single STP file to STL using FreeCAD.

    Args:
        filesPath (str): Path to the directory containing STP files.
        totalFiles (int): Total number of files (unused, for potential future use).
        file (str): Name of the STP file to convert.
    """
    print(f"Converting File: {file}")

    # Load and convert the STP file
    shape = Part.Shape()
    shape.read(join(filesPath, file))
    doc = App.newDocument('Doc')
    pf = doc.addObject("Part::Feature", "MyShape")
    pf.Shape = shape

    # Export the shape to STL format in the same directory
    stl_file = join(filesPath, f"{os.path.splitext(file)[0]}.stl")
    Mesh.export([pf], stl_file)

def main(stp_files_string):
    """
    Main function to handle the conversion of selected STP files to STL using multiprocessing.
    """
    stp_files = stp_files_string.split("|")  # Split the input string back into a list of file paths
    filesPath = os.path.dirname(stp_files[0])  # Use the directory of the first file as the filesPath
    onlyfiles = [os.path.basename(f) for f in stp_files]  # Use only the selected files
    totalFiles = len(onlyfiles)

    start_time = time.time()

    # Set up multiprocessing pool and perform conversions
    pool = multiprocessing.Pool(multiprocessing.cpu_count())
    temp = partial(converter, filesPath, totalFiles)
    print(f"Using {multiprocessing.cpu_count()} CPU cores for conversion...")
    pool.map(func=temp, iterable=onlyfiles)
    pool.close()
    pool.join()

    end_time = time.time()
    print(f'\nExecution time: {end_time - start_time:.2f} seconds\n')

if __name__ == "__main__":
    main("$stp_files_string")
END
}

# Check if FreeCAD is installed
if ! command -v freecad &> /dev/null
then
    echo "Error: FreeCAD could not be found. Make sure FreeCAD is installed and in your PATH."
    exit 1
fi

# Use Zenity to select STP files
stp_files=$(zenity --file-selection --multiple --title="Select STP files to convert" --file-filter="STP files | *.stp" --separator="|")

# Check if files were selected
if [ -z "$stp_files" ]; then
    echo "No files selected. Exiting."
    exit 1
fi

# Run the Python conversion function with the selected files
echo "Starting the STP to STL conversion process..."
convert_stp_to_stl "$stp_files"

echo "Conversion process completed."
