%module buffer

%{
#define SWIG_FILE_WITH_INIT
#include "buffer.h"
#include <cstdio>
%}

%import <pybuffer.i>

// This is the example from the <pybuffer.i> documentation
%pybuffer_mutable_binary(char *str, size_t sz);
int snprintf(char* str, size_t sz, const char *format, ...);

namespace SwigPlay
{

class Buffer
{
public:
  Buffer(std::size_t length=0, std::size_t headdroom=0);
  ~Buffer();
  void *getDataPtr();
  const void *getDataPtr() const;
  size_t getBufferSize();
  size_t getMaxBufferSize();
  void put(std::size_t sz);
  void pull(std::size_t sz);
  void push(std::size_t sz);
  void pop(std::size_t sz);
  void read(char* str, size_t sz);
  void read2(char* str, size_t sz, size_t offset);
  void write(char* str, size_t sz);
  void write2(char* str, size_t sz, size_t offset);
};

%extend Buffer {
  unsigned char __getitem__(int i) const {
    const unsigned char* base = static_cast<const unsigned char*>($self->getDataPtr());
    return *(base + i);
  }
  void __setitem__(size_t i, unsigned char value) {
    unsigned char* base = static_cast<unsigned char*>($self->getDataPtr());
    *(base + i) = value;
  }
  size_t __len__() {
    return $self->getBufferSize();
  }
}

/*
The only way I could get swig to work was with standalone functions that took the
class as a parameter. I could not figure out how to get swig to work on a class method
*/
void read(char* str, size_t sz, Buffer &buffer);
void write(char* str, size_t sz, Buffer &buffer);

/*
Also, the only way I could have a version that took an offset (from
the beginning of the buffer begin), was to name the function differently
from the non offset version.
*/
void read2(char* str, size_t sz, Buffer &buffer, size_t offset);
void write2(char* str, size_t sz, Buffer &buffer, size_t offset);

}
