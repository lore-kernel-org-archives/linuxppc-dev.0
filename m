Message-ID: <38ED585D.1F90EB48@uncc.edu>
Date: Thu, 06 Apr 2000 23:39:09 -0400
From: "William H. Schultz" <whschult@uncc.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: More XFree86 v4 problems
References: <200004060500.AAA03927@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello.

You are probably all getting tired of hearing the problems that I am
having with XFree86 v4.

The problem I am having is that X isn't properly recognizing the
internal video to my 8500 -- /chaos/control.  I did get my XF86Config
file set up to work on it (as far as I'm aware) and xinerama works, to
some extent.  (the problem I was having before with xinerama wound up
being that miboot assumes ATI hardware and likewise passes video=atyfb
kernel arguments.)

symptoms:

Screen is rotated about 40% to the left (the left portion wraps around
to the right).  Despite XF86Config args, it will only do 640x480@60Hz.
Additionally, it appears that it is running in 16 colors, even though it
won't do 16 colors in MacOS and my voodoo is running in millions.


Additionally, as enlightenment is xinerama aware, I can get windows to
pop up on the /chaos/control screen (bad colors), but when I save the
session with enlightenment as my default wm, my gnome toolbars
permanently dissapear--unless I delete all of my .gnome* directories.


Any help would be greatly appreciated.


Hank

ps  I have a qt/OpenGL version of breakout (very simple) I've been
working on for school.  Anyone interested in playing it?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
