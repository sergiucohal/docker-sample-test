import os

datalabs_url = os.getenv("DATALABS_URL", "https://datalabs.esa.int")

c.NotebookApp.tornado_settings = {
    "headers": {"Content-Security-Policy": "frame-ancestors %s 'self' ;" % datalabs_url}
}

c.NotebookApp.terminado_settings = {"shell_command": ["bash", "-i"]}

c.KernelSpecManager.ensure_native_kernel = False
