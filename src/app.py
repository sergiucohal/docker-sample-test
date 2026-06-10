from aiohttp import web
import os
import logging

log = logging.getLogger(__name__)


async def index_handler(request):
    log.info('[Index handler]')
    return web.Response(text="""\
<html>
    <head>
        <title>Test lab</title>
        <meta charset="utf-8">
    </head>
    <body>
        <h1>Test lab</h1>
        <a href="/page1">Page1</a><br>
        <a href="./page2">Page2</a>
    </body>
<html>
""", content_type='text/html')

async def test1_handler(request):
    log.info('[Test handler]')
    response = web.Response(text=f"""\
<html>
    <head>
        <title>Test page</title>
        <meta charset="utf-8">
    </head>
    <body>
        <h1>Test page</h1>
        <a href="/">Homepage</a><br/><a href="/page3">Page3</a>
    </body>
<html>
""")
    response.content_type = "text/html"
    return response

async def test2_handler(request):
    log.info('[Test handler]')
    response = web.Response(text=f"""\
<html>
    <head>
        <title>Page with relative paths</title>
        <meta charset="utf-8">
    </head>
    <body>
        <h1>Test page</h1>
        <a href="./">Back</a>
    </body>
<html>
""")
    response.content_type = "text/html"
    return response

async def test3_handler(request):
    log.info('[Test handler]')
    response = web.Response(text=f"""\
<html>
    <head>
        <title>Test page</title>
        <meta charset="utf-8">
    </head>
    <body>
        <h1>Test page</h1>
        <a href="/">Homepage</a>
    </body>
<html>
""")
    response.content_type = "text/html"
    return response

app = web.Application()
app.add_routes([
    web.get("/", index_handler),
    web.get("/page1", test1_handler),
    web.get("/page2", test2_handler),
    web.get("/page3", test3_handler),
])


env_port = os.environ.get('PORT')
port_number = int(env_port) if env_port and env_port.isdigit() else 10000

web.run_app(app, port=port_number)
