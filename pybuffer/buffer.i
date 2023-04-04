%module buffer

%{
#define SWIG_FILE_WITH_INIT
#include "buffer.h"
%}

%import <pybuffer.i>
%pybuffer_mutable_binary(char *str, size_t sz);

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
};

%extend Buffer {
  void read(char *str, size_t sz, size_t offset=0) const {
    const unsigned char* base = static_cast<const unsigned char*>($self->getDataPtr()) + offset;
    if (($self->getBufferSize()-offset) > sz)
    {
      throw std::runtime_error("Buffer::read - size mismatch");
    }
    memcpy(str, base, $self->getBufferSize());
  }
  void write(char *str, size_t sz, size_t offset=0) {
    unsigned char* base = static_cast<unsigned char*>($self->getDataPtr()) + offset;
    if (sz > ($self->getBufferSize()-offset))
    {
      throw std::runtime_error("Buffer::write - size mismatch");
    }
    memcpy(base, str, sz);
  }
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


}

