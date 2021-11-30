(import (fetchTarball https://github.com/edolstra/flake-compat/archive/master.tar.gz) {
  src = ./.;
}).defaultNix.packages.x86_64-linux.zeroad-unwrapped
