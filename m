Message-Id: <v03010d00b2a0a3366e34@[209.96.178.53]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 18 Dec 1998 19:43:54 -0500
To: mklinux-setup-digest@public.lists.apple.com,
        linuxppc-user@lists.linuxppc.org,
        mklinux-development-apps@public.lists.apple.com,
        linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <kbhend@dogwood.tyler.wm.edu>
Subject: Help!  Desperately Need Help with JDK 1.2 on ppc
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The JDK ppc team has dwindled to simply Scott Hutinger and myself.  Sun has
already released JDK 1.2 and they have provided two engineers that help
with the Blackdown porting.  Sun has also proivided the JCK to Blackdown.
(that's the extent of the Sun's  official support for Linux!).  Steve Byrne
of Blackdown has commercially licensed the JDK 1.2 source and sublicensed
it to Scott and I.

I have bootstrapped JDK 1.2 now and need some real help tracking down and
fixing bugs of all sorts.  Also, the JIT compiler interface has changed
considerably so we really need to fix the Metrowerks JIT compiler so that
it will work with JDK 1.2.

If you can spare *alot* of time over the next month or so (maybe some CS
phd student or someone with a semester break...) are skilled in programming
C and some C++, know how to use gdb, are familiar with X11 and Xt, etc. and
are willing to sign the Sun JDK license and the Metrowerks JIT license, I
really need your help!

I simply can't do everything that needs to be done and do my real job (my
research output has taken a real beating over the last year or so)

We can't release the Linux JDK 1.2 until it passes Sun's 1.2 and we are
already behind (Sun has already released their versions).

Please only respond if you are serious about helping, have the skills, and
the time to get this thing debugged and out there asap.  The work is very
rewarding and you get to see and understand how virtual machines work,
threading (both linux kernel threads and user-based threads.  I have really
learned a great deal since helping to start the Java PPC team a year ago or
more.

If interested in helping bring JDK 1.2 and the Metrowerks JIT for 1.2 to
Linux PPC, please email me directly and I will get in touch with you.

mailto:kbhend@dogwood.tyler.wm.edu

Thanks,


Kevin




----------------------------------------------------------
Kevin B. Hendricks
Associate Professor, Operations & Information Technology
School of Business, College of William & Mary
Williamsburg, VA 23187, kbhend@dogwood.tyler.wm.edu
http://business.tyler.wm.edu


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
