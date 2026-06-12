# -*- coding: utf-8 -*-

import os

datalabs_url = os.getenv("DATALABS_URL", "https://datalabs.esa.int")

c.NotebookApp.tornado_settings = {  # noqa
    "headers": {
        "Content-Security-Policy": "frame-ancestors %s 'self' ;" % datalabs_url
    }
}

c.NotebookApp.terminado_settings = {  # noqa
    "shell_command": ["bash", "-i"]
}

c.KernelSpecManager.ensure_native_kernel = False

c.MultiKernelManager.default_kernel_name = 'demo' 

c.MappingKernelManager.default_kernel_name='demo'