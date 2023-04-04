"""
setup.py file for SWIG buffer
"""

from distutils.core import setup, Extension

buffer_module = Extension('_buffer',
                           sources=['buffer_wrap.cxx', 'buffer.cpp'],
                           )

setup (name = 'buffer',
        version = '0.1',
        author      = "SWIG Docs",
        description = """Simple swig buffer wrapper""",
        ext_modules = [buffer_module],
        py_modules = ["buffer"],
        )

