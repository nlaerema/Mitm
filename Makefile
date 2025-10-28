NAME			= mitm

CXX				= c++
RM				= rm -f
GIT				= git

CXXFLAGS		+= -Wall -Wextra -Werror -std=c++98
LDLIBS			=

KDO_CPPLIB_DIR	= kdo_cpplib
KDO_CPPLIB		= $(KDO_CPPLIB_DIR)/kdo_cpplib.a

SRC				= Mitm.cpp

OBJ 			= $(SRC:.cpp=.o)

all: $(NAME)

$(NAME): $(KDO_CPPLIB) $(OBJ)
	$(CXX) $(CXXFLAGS) -o $(NAME) $(OBJ) $(KDO_CPPLIB) $(LDLIBS)

$(KDO_CPPLIB_DIR)/Makefile:
	$(GIT) submodule update --init --recursive $(KDO_CPPLIB_DIR)

$(KDO_CPPLIB): $(KDO_CPPLIB_DIR)/Makefile
	$(MAKE) -C $(KDO_CPPLIB_DIR)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	if [ -d "$(KDO_CPPLIB_DIR)" ]; then $(MAKE) clean -C $(KDO_CPPLIB_DIR); fi
	$(RM) $(OBJ)

fclean: clean
	$(RM) $(KDO_CPPLIB)
	$(RM) $(NAME)

clear: fclean
	$(RM) -r $(KDO_CPPLIB_DIR)

re: fclean all

fast: fclean
	$(MAKE) -j$$(nproc)

.PHONY:		all clean fclean clear re
