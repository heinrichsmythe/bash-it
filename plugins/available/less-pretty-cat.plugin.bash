cite about-plugin
about-plugin 'pygmentize instead of cat to terminal if possible'

if $(command -v pygmentize &> /dev/null) ; then
  # get the full paths to binaries
  CAT_BIN=$(which cat)
  LESS_BIN=$(which less)

  # pigmentize cat and less outputs - call them ccat and cless to avoid that
  # especially cat'ed output in scripts gets mangled with pygemtized meta characters
  function ccat()
  {
      about 'runs either pygmentize or cat on each file passed in'
      param '*: files to concatenate (as normally passed to cat)'
      example 'cat mysite/manage.py dir/text-file.txt'
      for var;
      do
          pygmentize "$var" 2>/dev/null || "$CAT_BIN" "$var";
      done
  }

  function cless()
  {
      about 'it pigments the file passed in and passes it to less for pagination'
      param '$1: the file to paginate with less'
      example 'less mysite/manage.py'
      pygmentize -g $* | "$LESS_BIN" -R
  }
fi
