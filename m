Date: Thu, 6 Jul 2000 13:01:20 -0400 (EDT)
From: "Peter R. Wood" <pwood@gordon.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: GAIM compile error
Message-ID: <Pine.LNX.4.21.0007061254230.8579-100000@dyn-133-196.gordon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I've contacted the authors of GAIM regarding this problem, but they don't
seem to have a clue about it so I thought I'd submit it here. I'm trying
to compile GAIM, the AOL instant messenger clone, from its CVS source.  I
get this error during the compile:

make[2]: Entering directory `/usr/src/gaim/src'
/bin/sh ../libtool --mode=link gcc  -g -O2 -I/usr/local/include
-I/opt/include -I../ -I../libfaim -I../libfaim/faim
-I/usr/lib/glib/include -D_REENTRANT -I/usr/X11R6/include
-DLOCALEDIR=\"/usr/local/share/locale\"  -o gaim  about.o aim.o away.o
browser.o buddy.o buddy_chat.o conversation.o dialogs.o
gaimrc.o gnome_applet_mgr.o gtkhtml.o html.o idle.o network.o oscar.o
plugins.o prefs.o proxy.o rvous.o server.o sound.o toc.o util.o ticker.o
gtkticker.o -L../libfaim -lfaim -pthread -L/usr/lib -lesd -laudiofile -lm
-L/usr/lib -L/usr/X11R6/lib -lgtk -lgdk -rdynamic -lgmodule -lgthread
-lglib -lpthread -ldl -lXi -lXext -lX11 -lm
gcc -g -O2 -I/usr/local/include -I/opt/include -I../ -I../libfaim
-I../libfaim/faim -I/usr/lib/glib/include -D_REENTRANT
-I/usr/X11R6/include -DLOCALEDIR=\"/usr/local/share/locale\" -o gaim
about.o aim.o away.o browser.o buddy.o buddy_chat.o conversation.o
dialogs.o gaimrc.o gnome_applet_mgr.o gtkhtml.o html.o idle.o network.o
oscar.o plugins.o prefs.o proxy.o rvous.o server.o sound.o
toc.o util.o ticker.o gtkticker.o -L../libfaim -lfaim -pthread -L/usr/lib
-lesd -laudiofile -lm -L/usr/lib -L/usr/X11R6/lib -lgtk -lgdk -rdynamic
-lgmodule -lgthread -lglib -lpthread -ldl -lXi -lXext -lX11 -lm
oscar.o: In function `gaim_parse_incoming_im':
/usr/src/gaim/src/oscar.c:537: undefined reference to
`__va_arg_type_violation'
/usr/src/gaim/src/oscar.c:537: relocation truncated to fit: R_PPC_REL24
__va_arg_type_violation
oscar.o: In function `gaim_parse_user_info':
/usr/src/gaim/src/oscar.c:627: undefined reference to
`__va_arg_type_violation'
/usr/src/gaim/src/oscar.c:627: relocation truncated to fit: R_PPC_REL24
__va_arg_type_violation
oscar.o: In function `gaim_parse_motd':
/usr/src/gaim/src/oscar.c:658: undefined reference to
`__va_arg_type_violation'
/usr/src/gaim/src/oscar.c:658: relocation truncated to fit: R_PPC_REL24
__va_arg_type_violation
oscar.o: In function `gaim_chatnav_info':
/usr/src/gaim/src/oscar.c:677: undefined reference to
`__va_arg_type_violation'
/usr/src/gaim/src/oscar.c:677: relocation truncated to fit: R_PPC_REL24
__va_arg_type_violation
collect2: ld returned 1 exit status
make[2]: *** [gaim] Error 1
make[2]: Leaving directory `/usr/src/gaim/src'

This is at the last step as it's about to link the object files in to the
gaim binary. If you're not familiar with the gaim source you can browse
the CVS repository at:

http://cvs.sourceforge.net/cgi-bin/cvsweb.cgi/gaim/src/?cvsroot=gaim

Note that's the src directory under the main distribution.

If you have any clues, please Cc: me since I read this in digest mode.

Thanks,

Peter

--
Peter R. Wood		pwood@gordon.edu
Computer Science	http://www.cs.gordon.edu/~pwood/
Gordon College		http://www.gordon.edu/
Wenham, MA		http://www.boston.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
