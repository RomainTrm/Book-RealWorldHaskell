- Create SimpleJSON.hs
- Compile it : ghc -c SimpleJSON.hs
- Create Main.hs
- Compile it and link to make a exe :
    - ghc -o simple Main.hs SimpleJSON.o (caused a linker error on my machine)
    - ghc -o simple Main.hs              (worked fine)

    Add -odir <dir> to specify output directory