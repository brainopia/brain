= brain

* http://brain.rubyforge.org
* http://github.com/brainopia/brain

== DESCRIPTION:

Implements several types of Neural Networks such as multilayer perceptron (data classification), Kohonen net (data clusterization), Hopfield net (data association).

== FEATURES:

Currently supports:
* Hopfield net

== SYNOPSIS:

Basic examples:
  
* Hopfield net
    
    sample = Brain::Hopfield[[-1, -1, -1, -1], [1, 1, 1, 1]].associate [1, 1, -1, 1]
    sample.run until sample.associated?
    sample.current # => [1, 1, 1, 1]
  

== INSTALL:

  sudo gem install brain

== LICENSE:

(The MIT License)

Copyright (c) 2008 Ravil Bayramgalin

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.