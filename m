Date: Fri, 12 Mar 1999 22:53:09 -0800
From: Sean Harding <sharding@gutenberg.uoregon.edu>
Reply-To: Sean Harding <sharding@oregon.uoregon.edu>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: linuxppc-dev@lists.linuxppc.org
Subject: XF68 problem
In-Reply-To: <Pine.LNX.3.95q.980411200636.617B-100000@cassiopeia.home>
Message-ID: <Pine.SGI.4.10.9903122248320.19776-100000@gutenberg.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This evening I decided to take the plunge and try XF68-fbdev on my
machine. I have a PowerCenter 150 (Platinum video) running a mish-mosh of
LinuxPPC which no longer can really be associated with a complete release.
The kernel is 2.1.130 at the moment. 

I'm getting a seg fault when I try to run the X server. Here's what strace
has to say about it:

execve("/usr/X11/bin/XF68", ["/usr/X11/bin/XF68"], [/* 33 vars */]) = 0
brk(0)                                  = 0x1aa02cc
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++

I indeed don't have an /etc/ld.so.preload, and I'm not entireley sure what
that file should contain. I'm also not clear on why the absence of that
file is causing the X server to seg fault....

Any ideas?

sean

-- 
Sean Harding sharding@oregon.uoregon.edu|"art may imitate life
http://gladstone.uoregon.edu/~sharding/ | but life imitates t.v."
Consulting: http://www.efn.org/~seanh/  | --ani difranco



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
