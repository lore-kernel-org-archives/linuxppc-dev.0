Message-ID: <19991023054805.29308.qmail@www0e.netaddress.usa.net>
Date: 23 Oct 99 00:48:05 CDT
From: jeramy b smith <ultrapenguin@netscape.net>
To: linuxppc-user@lists.linuxppc.org
Subject: Re: enlightenment--0.16.0-1.ppc.rpm causes crash
CC: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I have had problems with the pager from enlightenment on bigendian
> machines for some time (dox or epp?), and the new rpm 0.16.0-1 is no
> exception. 

> Too bad I really like 16 and the new themes on my intel machine.  Any
> ideas?
> 

I compiled the CVS e 16.1 on Tuesday along with CVS imlib 1.9.8. I've been
running the x server 24/7 since then without a hitch except for an Eterm
induced segfault. E caught it though, stayed in gui, and gave me the option to
quit or restart. It then restarted with no problems.

The web address for my RPMS is www.penguinppc.org/meat.html

On that page I also have the october gnome link up. I compiled with the
october gnome devel packages installed so e might bug you to fulfill some
dependencies. That's where you'll find em.

You might want to try my stuff if your having problems. There's a fourth theme
in my rpm and e runs very nicely if you turn off gmc and gnome-panel. My pager
works fine but I turned off the screen scanning garbage.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
