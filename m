From: Michael Norton <mnorton@cisco.com>
Message-Id: <200010220521.WAA05528@cisco.com>
Subject: Mesa Application Makefile
To: linuxppc-dev@lists.linuxppc.org
Date: Sat, 21 Oct 2000 22:21:21 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

I am trying to get a program I wrote on Linux (Intel) to compile on my LinuxPPC G4 machine.

Here is my Makefile:
CC = gcc
CFLAGS = -g

INCLUDE = -I/usr/X11R6/include -I/usr/include/GL

GLUT = /usr/lib/libglut.so.3.7.0

LIBPATH = -L/usr/X11R6/lib -L/usr/local/lib
XLIBS =  -L/usr/X11R6/lib -lXext -lX11

GLLIBS = -lMesaGLU -lMesaGL $(XLIBS)



PROG = gameCon
SRCS = glConsole.c
OBJS = glConsole.o

$(PROG) : $(OBJS)
	$(CC)	$(INCLUDE)	-o	$(PROG)	$(OBJS)	$(GLLIBS)	$(GLUT)

I see thois error form the linker:

[mnorton@b9 console]#make
gcc     -I/usr/X11R6/include -I/usr/include/GL  -o     gameCon glConsole.o      -lMesaGLU -lMesaGL -L/usr/X11R6/lib -lXext -lX11   /usr/lib/libglut.so.3.7.0
/usr/bin/ld: cannot find -lMesaGLU
collect2: ld returned 1 exit status
make: *** [gameCon] Error 1


What am I doing wrong? What is missing from my Makefile?

thanks,

Mike


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
