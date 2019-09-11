override COMPILER        += rbuic4
override COMPILE_OPTIONS += 
override LINK_OPTIONS    += 
override STATIC_LIBS     += 
RM                        = rm -f
RUBY					  = ruby
MKDIR                     = mkdir -p
MAIN_TARGET               = rgraph4.rb
UI_RB                   = graphpanel4.rb graphwindow4.rb
UI_SRCS                   = graphpanel4.ui graphwindow4.ui

.PHONY: all go clean

all: $(UI_RB)

go: $(MAIN_TARGET)
	$(RUBY) $(MAIN_TARGET)
	
clean:
	$(RM) $(UI_RB)

%.rb : %.ui
	$(COMPILER) $(COMPILE_OPTIONS)  -o $@ $<

$(MAIN_TARGET): $(UI_RB)


