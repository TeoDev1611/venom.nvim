import json
import subprocess
from sys import exit
import logging
from optparse import OptionParser
import os


def main():
    # Create the parser from optparse
    parser = OptionParser()

    # Define the program options and description
    parser.version = "1.0"
    parser.description = "Venom utilitie for create a pipenv config for pyright"
    parser.prog = "venom"

    # Add the options for the parser

    parser.add_option("-p", "--pipenv", action="store_true", dest="pipenv")

    # Parse the args
    (options, args) = parser.parse_args()

    if options.pipenv:
        pipenv_info()


def pipenv_info():
    file_exists = os.path.exists("./Pipfile")
    if not file_exists:
        logging.error("Pipfile not exists")
        exit(2)
    cmd = subprocess.run(["pipenv", "--venv"], stdout=subprocess.PIPE)
    cmd_data = cmd.stdout.decode("utf-8")
    data = {
        "venvPath": cmd_data[:-3],
    }
    file = open("./pyrightconfig.json", "w")
    json.dump(data, file)
    file.close()
    print("Work created succesfully")


if __name__ == "__main__":
    main()
