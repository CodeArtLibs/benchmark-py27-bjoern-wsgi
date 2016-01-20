import ujson as json


def request_json(environ, start_response):
    data = {}
    response = json.dumps(data)
    response_headers = [
        ('Content-Type', 'application/json; charset=utf-8'),
        ('Content-Length', str(len(response))),
    ]
    start_response(b'200 OK', response_headers)
    return [response]


def app(environ, start_response):
    path = environ['PATH_INFO']
    if path.startswith('/json-response'):
        return request_json(environ, start_response)
    else:
        return request_json(environ, start_response)


if __name__ == "__main__":
    import logging
    import os

    logging.disable(logging.CRITICAL)
    logger = logging.getLogger()
    logger.setLevel(logging.CRITICAL)
    logger.disabled = True
    logger.propagate = False

    import bjoern
    bjoern.listen(app, '0.0.0.0', int(os.getenv('PORT', 8000)), reuse_port=True)
    bjoern.run()
