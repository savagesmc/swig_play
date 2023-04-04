#pragma once

#include <array>
#include <stdexcept>
#include <cstring>

constexpr std::size_t maxBufferSize() { return 65536; }

class Buffer
{
  std::array<char, maxBufferSize()> buffer_;
  char* first_{&buffer_[0]};
  char* begin_{&buffer_[0]};
  char* end_{&buffer_[0]};
  char* last_{&buffer_[maxBufferSize()]};
  constexpr std::size_t headroom() const {
    return begin_ - first_;
  }
public:

  Buffer(std::size_t length=0, std::size_t hdroom=0)
  {
    reset(length, hdroom);
  }

  void reset(std::size_t length=0, std::size_t hdroom=0) {
    if (hdroom != 0 && hdroom < maxBufferSize()) {
      begin_ += hdroom;
    }
    if (length < available()) {
      end_ = begin_ + length;
    }
  }

  void* getDataPtr() {
    return begin_;
  }

  const void* getDataPtr() const{
    return begin_;
  }

  std::size_t getBufferSize() const {
    return end_ - begin_;
  }

  std::size_t getMaxBufferSize() const {
    return maxBufferSize();
  }

  void* getBufferPtr() {
    return &buffer_[0];
  }

  const void* getBufferPtr() const{
    return &buffer_[0];
  }

  std::size_t available() const {
    return last_ - end_;
  }

  // Add to tail
  void put(std::size_t sz) {
    if (sz + getBufferSize() > maxBufferSize()) {
      throw std::range_error("Buffer::put");
    }
    end_ += sz;
  }

  // Pop from tail
  void pull(std::size_t sz) {
    if (sz > getBufferSize()) {
      throw std::range_error("Buffer::pull");
    }
    end_ -= sz;
  }

  // Add to front
  void push(std::size_t sz) {
    if (sz > headroom()) {
      throw std::range_error("Buffer::push");
    }
    begin_ -= sz;
  }

  // Pop from front
  void pop(std::size_t sz) {
    if (sz > getBufferSize()) {
      throw std::range_error("Buffer::pop");
    }
    begin_ += sz;
  }

  // read/write for external copy access
  void read(char* str, size_t size, size_t offset=0) {
    // TOOD: Bound checking
    std::memcpy(str, begin_+offset, size);
  }

  void write(char* str, size_t size, size_t offset=0) {
    // TOOD: Bound checking
    std::memcpy(begin_+offset, str, size);
  }

};

int write(char* str, size_t size, Buffer& buffer, size_t offset);

