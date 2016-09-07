
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

        
def writer_wrapper_from(coro):
    yield from coro

    
# w = writer()
# wrap = writer_wrapper(w)
# wrap.send(None)  # "prime" the coroutine
# for i in range(4):
#     wrap.send(i)


# w = writer()
# wrap_from = writer_wrapper_from(w)
# wrap_from.send(None)  # "prime" the coroutine
# for i in range(4):
#     wrap_from.send(i)    

# Sending data to a generator yield from - Part 2 - Exception handling    

def writer_wrapper(coro):
    """Works. Manually catches exceptions and throws them"""
    coro.send(None)  # prime the coro
    while True:
        try:
            try:
                x = (yield)
            except Exception as e:   # This catches the SpamException
                coro.throw(e)
            else:
                coro.send(x)
        except StopIteration:
            pass

        
class SpamException(Exception):
    pass

def writer():
    while True:
        try:
            w = (yield)
        except SpamException:
            print('***')
        else:
            print('>> ', w)


w = writer()
wrap = writer_wrapper(w)
wrap.send(None)  # "prime" the coroutine
for i in [0, 1, 2, 'spam', 4]:
    if i == 'spam':
        wrap.throw(SpamException)
    else:
        wrap.send(i)

def writer_wrapper(coro):
    yield from coro

    
w = writer()
wrap_from = writer_wrapper(w)
wrap_from.send(None)  # "prime" the coroutine
for i in [0, 1, 2, 'spam', 4]:
    if i == 'spam':
        wrap_from.throw(SpamException)
    else:
        wrap_from.send(i)        
            
