"""
Parallel programming
Lab 8

Functions:
F1: C := A - B * (MA * MD)
F2: o := Min(MK * MM)
F3: T := (MS * MZ) * (W + X)

@since 2015-12-09
@author Olexandr Kovalchuk
IP-32
"""
from multiprocessing import Process
import logging
import os

from data import func1, func2, func3, make_sq_matrix, make_vector


def verbose(f):
    def _wrapper(*args, **kwargs):
        det = kwargs.get('det', args[0] if args else 0)
        pid = os.getpid()
        logging.info('Task %s in process %s started', det, pid)
        result = f(*args, **kwargs)
        logging.info('Task %s in process %s finished', det, pid)
        return result

    return _wrapper


@verbose
def task(det, size=4):
    assert 1 <= det <= 3
    assert size > 0

    if det == 1:
        ma = make_sq_matrix(size)
        md = make_sq_matrix(size)
        a = make_vector(size)
        b = make_vector(size)
        result = func1(a, b, ma, md)
    elif det == 2:
        mk = make_sq_matrix(size)
        mm = make_sq_matrix(size)
        result = func2(mk, mm)
    elif det == 3:
        w = make_vector(size)
        x = make_vector(size)
        ms = make_sq_matrix(size)
        mz = make_sq_matrix(size)
        result = func3(ms, mz, w, x)
    if (size < 8):
        print('task %s: %s' % (det, result))


def runapp(sz):
    assert sz > 0
    ps = [Process(target=task, args=(d, sz)) for d in range(1, 4)]
    for p in ps:
        p.start()
    for p in ps:
        p.join()


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.NOTSET)
    sz = 1000
    runapp(sz)
