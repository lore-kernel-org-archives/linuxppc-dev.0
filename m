Message-ID: <3739A212.36A30431@deneba.com>
Date: Wed, 12 May 1999 11:45:23 -0400
From: michael cardenas <michael_cardenas@deneba.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: compiling GAIM
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


    I tried to compile gAim last night (Thats the gtk version of aol
instant messenger) and got the following error at the end of the
compilation


gcc -DPACKAGE=\"gaim\" -DVERSION=\"0.8.0\" -DSTDC_HEADERS=1
-DHAVE_SYS_WAIT_H=1 -DHAVE_FCNTL_H=1 -DHAVE_SYS_TIME_H=1
-DHAVE_UNISTD_H=1 -DRETSIGTYPE=void -DHAVE_STRFTIME=1 -DHAVE_SOCKET=1
-DHAVE_STRDUP=1 -DHAVE_STRSTR=1  -I. -I.       -c about.c
In file included from /usr/include/gdk/gdktypes.h:25,
                 from /usr/include/gdk/gdk.h:23,
                 from /usr/include/gtk/gtk.h:23,
                 from about.c:31:
/usr/include/glib.h:22: glibconfig.h: No such file or directory
make: *** [about.o] Error 1
[root@(none) gaim-0.8.0]#

What exactly is glib.h or glibconfig.h and where can I get them?

Thanks...

I'll put my compiled binary up on my web page, or upload it to some
sites for public consumption.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
