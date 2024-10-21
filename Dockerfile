FROM nvcr.io/nvidia/pytorch:24.05-py3
#FROM pytorch/pytorch:2.1.2-cuda12.1-cudnn8-runtime


RUN mkdir -p /workspace
WORKDIR /workspace
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Copy the entrypoint script and ensure it's executable for all users

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]
