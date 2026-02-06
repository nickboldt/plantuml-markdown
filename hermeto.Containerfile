FROM registry.access.redhat.com/ubi9/python-311

COPY . /src/plantuml_markdown
WORKDIR /src/plantuml_markdown

# Need to source the hermeto.env file to set the environment variables
# (in the same RUN instruction as the pip commands)
RUN source /tmp/hermeto.env && \
  python3.11 -V; pip3.11 -V; \
  pip install --no-cache-dir --upgrade pip; \
  pip install --no-cache-dir -r requirements.txt -r requirements-build.txt -r test-requirements.txt
RUN plantuml-markdown --version
