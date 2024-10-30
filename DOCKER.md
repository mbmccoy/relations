# Docker Usage Guide

This document provides step-by-step instructions on how to use Docker to set up and run a Jupyter Lab environment for the project.

## 1. Create a `.env` File

First, create a `.env` file that will store necessary environment variables. You can use the provided `.env.template` as a starting point:

```
# Copy to .env and edit fields

# echo $(id -u)
UID=999

# echo $(id -g)
GID=999

# echo $(whoami)
USER=fakeuser

# echo $(( $(id -u) + 10000 ))
JUPYTER_PORT=10999

# https://huggingface.co/settings/tokens
HF_TOKEN=hf_XXX
```

- **UID**: The user ID of your local machine. Run `echo $(id -u)` to find it.
- **GID**: The group ID of your local machine. Run `echo $(id -g)` to find it.
- **USER**: Your username. Run `echo $(whoami)` to find it.
- **JUPYTER_PORT**: A custom port for Jupyter Lab. You can calculate it with `echo $(( $(id -u) + 10000 ))`.
- **HF_TOKEN**: (Optional) Your Hugging Face token, if required for the project.

Copy `.env.template` to `.env` and edit the fields as needed.

## 2. Build the Docker Container

Once you have your `.env` file set up, build the Docker container using:

```
docker compose build
```

This will create the Docker image required to run the Jupyter Lab environment.

## 3. Run Jupyter Lab

To start the Jupyter Lab server, run:

```
docker compose up jupyter
```

You should see something like this:

```console
[+] Running 1/0
 ✔ Container hernandez-relations-fork-jupyter-1  Created                                                                      0.0s 
Attaching to jupyter-1
jupyter-1  | [I 20:20:33.078 LabApp] Writing notebook server cookie secret to /workspace/.jupyter/runtime/notebook_cookie_secret
jupyter-1  | [I 20:20:33.444 LabApp] jupyter_tensorboard extension loaded.
jupyter-1  | [I 20:20:33.562 LabApp] JupyterLab extension loaded from /usr/local/lib/python3.10/dist-packages/jupyterlab
jupyter-1  | [I 20:20:33.562 LabApp] JupyterLab application directory is /usr/local/share/jupyter/lab
jupyter-1  | [I 20:20:33.563 LabApp] [Jupytext Server Extension] NotebookApp.contents_manager_class is (a subclass of) jupytext.TextFileContentsManager already - OK
jupyter-1  | [I 20:20:33.565 LabApp] Serving notebooks from local directory: /workspace/notebooks
jupyter-1  | [I 20:20:33.565 LabApp] Jupyter Notebook 6.4.10 is running at:
jupyter-1  | [I 20:20:33.565 LabApp] http://localhost:11003/?token=e2b0e47a83dcbc595b8f8eea7710f68c58790a8936de248c
jupyter-1  | [I 20:20:33.565 LabApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
jupyter-1  | [C 20:20:33.567 LabApp] 
jupyter-1  |     
jupyter-1  |     To access the notebook, open this file in a browser:
jupyter-1  |         file:///workspace/.jupyter/runtime/nbserver-25-open.html
jupyter-1  |     Or copy and paste this URL:
jupyter-1  |         http://localhost:11003/?token=e2b0e47a83dcbc595b8f8eea7710f68c58790a8936de248c
```

After the container starts, Visual Studio Code (VSCode) should automatically port-forward the Jupyter port specified in your `.env` file. You can then right-click the link to open Jupyter Lab in your browser.

## 4. Rebuilding the Docker Image

If you make changes to the `Dockerfile` or `requirements.txt`, you need to rebuild the Docker image to apply the changes. To rebuild and start Jupyter, use the following command:

```
docker compose build && docker compose up jupyter
```

## Tips

- Ensure that the `.env` file is properly configured before running any Docker commands.
- If the container fails to start, double-check your environment variables, as they need to match your system's settings.
- You can stop the running container with `Ctrl+C` in the terminal where it is running, or by using `docker compose down`.

Feel free to reach out if you encounter any issues or need further guidance!
