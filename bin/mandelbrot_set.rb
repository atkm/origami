#!/usr/bin/env ruby
# Mandelbrot set.
# Oleg Andreev aka oleganza
# 03.06.2008


require 'mathn'

class Matr
  include Enumerable
  
  def self.from_raw(rm)
    m = new(rm[0].size, rm.size)
    m.raw_matrix = rm
    m
  end
  
  def initialize(w, h)
    @matrix = [Array.new(w)]*h
  end
  
  def raw_matrix=(arr2d)
    @matrix = arr2d
  end
    
  def each(&block)
    @matrix.each do |row|
      row.each(&block)
    end
    self
  end
  
  def map(&block)
    new_matrix = @matrix.map do |row|
      row.map(&block)
    end
    self.class.from_raw(new_matrix)
  end
  
  def map_with_index
    y = 0
    new_matrix = @matrix.map do |row|
      x = 0
      row = row.map do |value|
        value = yield(x, y, value)
        x += 1
        value
      end
      y += 1
      row
    end
    self.class.from_raw(new_matrix)
  end
  
  def join(a = '', b = "\n") 
    @matrix.map do |row|
      row.map { |v| v.to_s }.join(a)
    end.join(b)
  end
  
  def render(medium)
    medium.new(self).render
  end

end

class ASCII
  SYMBOLS = [' '] + %w[ . : ; t b O M $ % ]
  def initialize(m)
    @m = m
  end
  def render
    matrix = @m
    a = matrix.min
    b = matrix.max
    q = (SYMBOLS.size - 1) / ((b - a) + 0.0000001)
    q = 1 if a == b
    matrix.map do |v|
      SYMBOLS[((v - a) * q).round]
    end.join
  end
end

def mandelbrot(x, c)
  x**2 + c
end

def mandelbrot_n(c, n = 10)
  i = 0
  x = 0
  while i < n
    x = mandelbrot(x, c)
    i+=1
  end
  x
end

W = 100
H = 30
R = W/H.to_f/2.8
M = 1.8

m = Matr.new(W, H)

puts(m.map_with_index do |i, j, v| 
  x = (i*2.0/W - 1)*M - 0.5
  y = (j*2.0/H - 1)*M*R
  Math.log(mandelbrot_n(Complex(x, y), 9).abs+0.0001)
end.render(ASCII))