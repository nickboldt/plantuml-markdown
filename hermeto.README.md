# Using hermeto to validate requirements for offline builds:

Make changes to the pyproject.toml file, then:

```
rm -fr ./hermeto-output/ test-requirements.txt requirements.txt && \
uv sync; \
uv pip compile --group test    --universal --output-file test-requirements.txt -U; \
uv pip compile --group build   --universal --output-file requirements-build.txt -U; \
uv pip compile --group runtime --universal --output-file requirements.txt -U && \
\
alias hermeto='podman run --rm -ti -v "$PWD:$PWD:z" -w "$PWD" ghcr.io/hermetoproject/hermeto:latest'; \
hermeto fetch-deps --output ./hermeto-output/ --source . pip; \
hermeto generate-env ./hermeto-output -o ./hermeto.env --for-output-dir /tmp/hermeto-output; \
podman build . -f hermeto.Containerfile \
    --network none \
    --volume "$(realpath ./hermeto-output)":/tmp/hermeto-output:Z \
    --volume "$(realpath ./hermeto.env)":/tmp/hermeto.env:Z  \
    --tag plantuml_markdown 
```

