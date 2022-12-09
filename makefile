all: lua-f c-f java-f
	@echo "#!/usr/bin/\necho '\n--Lua--'\nlua ./lout\necho '\n\n--C--'\n./cout\necho '\n\n--Java--'\njava mine" > run.sh

all-v3: lua-v3 c-v3 java-v3
	@echo "#!/usr/bin/\necho '\n--Lua--'\nlua ./lout\necho '\n\n--C--'\n./cout\necho '\n\n--Java--'\njava mine" > run.sh

all-v2: lua-v2 c-v2 java-v2
	@echo "#!/usr/bin/\necho '\n--Lua--'\nlua ./lout\necho '\n\n--C--'\n./cout\necho '\n\n--Java--'\njava mine" > run.sh

all-v1: lua-v1 c-v1 java-v1
	@echo "#!/usr/bin/\necho '\n--Lua--'\nlua ./lout\necho '\n\n--C--'\n./cout\necho '\n\n--Java--'\njava mine" > run.sh

lua-f: ./lua/final/mine.lua
	@echo "Compiling Lua FINAL ver"
	@luac -o ./lout ./lua/final/mine.lua
	@echo "#!/usr/bin/\nlua ./lout" > run.sh
	@echo "Done: run 'bash ./run.sh' to test"

java-f: ./java/final/mine.java
	@echo "Compiling Java FINAL ver"
	@javac -d ./ ./java/final/mine.java
	@echo "#!/usr/bin/\njava mine" > run.sh
	@echo "Done: run 'bash ./run.sh' to test"

c-f: ./c/final/mine.c
	@echo "Compiling C FINAL ver"
	@gcc -o ./cout ./c/final/mine.c
	@echo "#!/usr/bin/\n./cout" > run.sh
	@echo "Done: run 'bash ./run.sh' to test"
	
lua-v3: ./lua/polish/mine.lua
	@echo "Compiling Lua ver 3"
	@luac -o ./lout ./lua/polish/mine.lua
	@echo "#!/usr/bin/\nlua ./lout" > run.sh
	@echo "Done: run 'bash ./run.sh' to test"

java-v3: ./java/polish/mine.java
	@echo "Compiling Java ver 3"
	@javac -d ./ ./java/polish/mine.java
	@echo "#!/usr/bin/\njava mine" > run.sh
	@echo "Done: run 'bash ./run.sh' to test"

c-v3: ./c/polish/mine.c
	@echo "Compiling C ver 3"
	@gcc -o ./cout ./c/polish/mine.c
	@echo "#!/usr/bin/\n./cout" > run.sh
	@echo "Done: run 'bash ./run.sh' to test"

lua-v2: ./lua/features/mine.lua
	@echo "Compiling Lua ver 2"
	@luac -o ./lout ./lua/features/mine.lua
	@echo "#!/usr/bin/\nlua ./lout" > run.sh
	@echo "Done: run 'bash ./run.sh' to test"

java-v2: ./java/features/mine.java
	@echo "Compiling Java ver 2"
	@javac -d ./ ./java/features/mine.java
	@echo "#!/usr/bin/\njava mine" > run.sh
	@echo "Done: run 'bash ./run.sh' to test"

c-v2: ./c/features/mine.c
	@echo "Compiling C ver 2"
	@gcc -o ./cout ./c/features/mine.c
	@echo "#!/usr/bin/\n./cout" > run.sh
	@echo "Done: run 'bash ./run.sh' to test"

lua-v1: ./lua/frame/mine.lua
	@echo "Compiling Lua ver 1"
	@luac -o ./lout ./lua/frame/mine.lua
	@echo "#!/usr/bin/\nlua ./lout" > run.sh
	@echo "Done: run 'bash ./run.sh' to test"

java-v1: ./java/frame/mine.java
	@echo "Compiling Java ver 1"
	@javac -d ./ ./java/frame/mine.java
	@echo "#!/usr/bin/\njava mine" > run.sh
	@echo "Done: run 'bash ./run.sh' to test"

c-v1: ./c/frame/mine.c
	@echo "Compiling C ver 1"
	@gcc -o ./cout ./c/frame/mine.c
	@echo "#!/usr/bin/\n./cout" > run.sh
	@echo "Done: run 'bash ./run.sh' to test"

clean:
	@echo "Cleaning Up"
	@if [ -f ./run.sh ]; then rm ./run.sh; echo "removed runner"; fi
	@if [ -f ./lout ]; then rm ./lout; echo "removed lout"; fi
	@if [ -f ./cout ]; then rm ./cout; echo "removed cout"; fi
	@if [ -f ./mine.class ]; then rm ./*.class; echo "removed mine + classes"; fi
	@echo "Done"