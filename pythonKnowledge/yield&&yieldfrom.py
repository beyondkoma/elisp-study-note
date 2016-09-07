
# Reading data from a generator using yield from
def reader():
    """A generator that fakes a read from a file, socket, etc."""
    for i in range(4):
        yield '<< %s' % i

def reader_wrapper(g):
    # Manually iterate over data produced by reader
    for v in g:
        yield v

def reader_wrapper_from(g):
    # Manually iterate over data produced by reader
    yield  from g

# wrap = reader_wrapper(reader())
# for i in wrap:
#     print(i)
    
# wrap_from = reader_wrapper_from(reader())
# for i in wrap_from:
#     print(i)




# Sending data to a generator (coroutine) using yield from

def writer():
    """A coroutine that writes data *sent* to it to fd, socket, etc."""
    while True:
        w = (yield)
        print('>> ', w)


def writer_wrapper(coro):
    coro.send(None)  # prime the coro
    while True:
        try:
            x = (yield)  # Capture the value that's sent
            coro.send(x)  # and pass it to the writer
        except StopIteration:
            pass


w = writer()
wrap = writer_wrapper(w)
wrap.send(None)  # "prime" the coroutine
for i in range(4):
    wrap.send(i)        
