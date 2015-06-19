OBJECTS=main.o
BINARIES=main

# Where our library resides. It is split between includes and the binary
# library in lib
RGB_INCDIR=matrix/include
RGB_LIBDIR=matrix/lib
RGB_LIBRARY_NAME=rgbmatrix
RGB_LIBRARY=$(RGB_LIBDIR)/lib$(RGB_LIBRARY_NAME).a
LDFLAGS+=-L$(RGB_LIBDIR) -l$(RGB_LIBRARY_NAME) -lrt -lm -lpthread

CXXFLAGS=-Wall -O3 -g -I$(RGB_INCDIR)

PROJECT_LIB=led-matrix-text

all : $(BINARIES)

$(RGB_LIBRARY):
	$(MAKE) -C $(RGB_LIBDIR)

.o : $(PROJECT_LIB)/%.cc $(RGB_LIBRARY)
	$(CXX) -I$(RGB_INCDIR) $(CXXFLAGS) -c -o $@ $<

main : $(PROJECT_LIB)/main.o $(RGB_LIBRARY)
	$(CXX) -I$(RGB_INCDIR) $(CXXFLAGS) $(PROJECT_LIB)/main.o -o $@ $(LDFLAGS)


clean:
	rm -f $(OBJECTS) $(ALL_BINARIES)
	$(MAKE) -C lib clean
