# Datalabs Recipe — JupyterLab

Your Datalabs recipe project — a self-contained Docker image definition for [ESA Datalabs](https://datalabs.esa.int).

## Getting started checklist

Before requesting submission to the Datalabs public catalogue, make sure:

- [ ] `meta.toml` — set `title` to match your project name (e.g. `my-app`)
- [ ] `meta.toml` — write an `abstract` (20-250 characters describing your app)
- [ ] `meta.toml` — set `maintainer` and `email` to your name and ESA email
- [ ] `meta.toml` — set `cores` and `ram` to what your app actually needs
- [ ] `Dockerfile` — add your build steps (packages, dependencies, config)
- [ ] `icon.svg` — replace the placeholder with your app's icon
- [ ] `jupyter_notebook_config.py` — review Jupyter settings (defaults usually work)
- [ ] CI pipeline passes (green checkmark on your latest commit)

## What to edit

### `meta.toml` — your app's metadata

This file describes your app. Open it and fill in:

| Field | What to put |
|---|---|
| `title` | Your project name — must match the GitLab project name, lowercase, max 15 chars |
| `abstract` | A short description of your app (20-250 characters) |
| `maintainer` | Your name |
| `email` | Your email address |
| `cores` | CPU cores your app needs (1-32) |
| `ram` | RAM in GB your app needs (1-96) |
| `license` | Your software license ([SPDX identifier](https://spdx.org/licenses/)) |

Leave the fields under "do not change" as they are — CI fills those in.

### `Dockerfile` — how your image is built

Add your build steps below the first two lines (do not change those). For example:

```dockerfile
# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    libfftw3-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir astropy numpy
```

### `jupyter_notebook_config.py` — Jupyter settings

The default configuration works for most use cases. Only edit this if you need to customise Jupyter's behaviour (e.g. content security policy, kernel settings).

### `user-01.sh` — startup commands (optional)

This script runs every time the container starts. Use it to activate conda environments, clone repositories, or set up the workspace. If you don't need it, you can leave it empty or delete it.

### `icon.svg` — your app's icon

Replace the placeholder with an SVG icon for your app. This will be shown in the Datalabs catalogue.

## What happens when you push

Every time you push, a CI pipeline runs automatically and checks:

- **Dockerfile syntax** — catches common mistakes
- **Shell script quality** — checks your `.sh` files
- **Metadata validation** — verifies `meta.toml` is complete and correct
- **Security scan** — makes sure no passwords or tokens are accidentally committed

If all checks pass, you'll see a green checkmark on your commit. If something fails, click the red X to see what went wrong.

## How to create a release

When your recipe is ready and CI is green:

```bash
git tag v1.0.0
git push origin v1.0.0
```

This builds your Docker image and pushes it to your project's container registry.

## How to submit to the Datalabs public catalogue

1. Make sure your CI pipeline passes
2. Create a tagged release (see above)
3. Open an [issue in the catalogue](https://gitlab.esa.int/sci-sas/edl-apps/catalogue/-/issues/new) with:
   - Your project URL
   - The tag you want published (e.g. `v1.0.0`)
4. An admin will review and add your recipe

## FAQ

**How do I update my recipe after it's in the catalogue?**
Push your changes, bump the `version` in `meta.toml`, and create a new tag (`v1.1.0`). The catalogue detects new tags automatically and opens an update request for admin approval. See the [update guide](https://gitlab.esa.int/sci-sas/edl-apps/catalogue/-/blob/main/docs/user-guide.md#updating-your-recipe) for details.

**How do I try out my image?**
Build and run it locally with Docker:
```bash
docker build -t my-recipe .
docker run -p 8888:8888 my-recipe
```
We are working on enabling testing directly in Datalabs before submission.

**What if CI fails?**
Click the red X next to your commit to see the pipeline. Click on the failing job to read the error. Common fixes:
- *meta.toml schema*: a required field is missing or has the wrong format
- *title matches directory*: your `title` in meta.toml must match the project name exactly
- *Dockerfile header*: don't change the first two lines of the Dockerfile
- *no committed secrets*: you accidentally committed a token or password — remove it and use CI variables instead

**How do I use secrets (tokens, API keys)?**
Never commit secrets to your repository. Instead:
1. Go to **Settings > CI/CD > Variables** in your project
2. Add the secret as a variable (mark it as **Protected** and **Masked**)
3. In your Dockerfile, receive it with `ARG MY_TOKEN` and reference it as `${MY_TOKEN}`

See the [secrets guide](https://gitlab.esa.int/sci-sas/edl-apps/catalogue/-/blob/main/docs/user-guide.md#handling-secrets) for details.

**Who can see my data?**
By default, recipes are set to `access = "public"` — anyone on Datalabs can use your app. Set `access = "private"` and use `shared_with` in `meta.toml` to restrict access to specific users or groups.

**I need help / something is broken**
Open a ticket at the [SITU Service Desk](https://support.cosmos.esa.int/situ-service-desk/servicedesk/customer/portal/5).

## Documentation

- [How to create and maintain a recipe](https://gitlab.esa.int/sci-sas/edl-apps/catalogue/-/blob/main/docs/user-guide.md)
- [Architecture and design](https://gitlab.esa.int/sci-sas/edl-apps/catalogue/-/blob/main/docs/architecture.md)
