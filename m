Date: Sun, 22 Oct 2000 18:10:30 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michael Norton <mnorton@cisco.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Mesa Application Makefile
In-Reply-To: <200010220521.WAA05528@cisco.com>
Message-ID: <Pine.LNX.4.10.10010221808550.9309-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> GLUT = /usr/lib/libglut.so.3.7.0
>
> LIBPATH = -L/usr/X11R6/lib -L/usr/local/lib
> XLIBS =  -L/usr/X11R6/lib -lXext -lX11
>
> GLLIBS = -lMesaGLU -lMesaGL $(XLIBS)
>
> [mnorton@b9 console]#make
> gcc     -I/usr/X11R6/include -I/usr/include/GL  -o     gameCon glConsole.o      -lMesaGLU -lMesaGL -L/usr/X11R6/lib -lXext -lX11   /usr/lib/libglut.so.3.7.0
> /usr/bin/ld: cannot find -lMesaGLU
> collect2: ld returned 1 exit status
> make: *** [gameCon] Error 1
>
>
> What am I doing wrong? What is missing from my Makefile?

-L/path/to/libMesaGLU perhaps? Add it in front of your GLLIBS def.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
