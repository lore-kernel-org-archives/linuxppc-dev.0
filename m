Date: Tue, 13 Apr 1999 17:26:31 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Jim Somerville <somer@nortelnetworks.com>
cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: quik vs. bootx
In-Reply-To: <03E3E0690542D211A1490000F80836F4877DEC@zcard00f.ca.nortel.com>
Message-ID: <Pine.LNX.4.05.9904131724590.487-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 13 Apr 1999, Jim Somerville wrote:

> None of my systems have MacOS on them...I'm using quik.  I have no desire
> to reinstall MacOS just so I can boot linux.  Will quik work with the 2.2
> kernel, or will I be screwed here?  I'm currently using 2.1.24 on all my
> systems.

Quik works fine w/ 2.2.x and 2.1.xxx.  Tho when you install R5 you might
have a bit of trouble. (BootX only install ATM, but putting the ramdisk
and a vmlinux into a .coff ala R4 is doable of course.  And if anyone
wishes to make the installer do the Quik things needed, patches are
welcome.)

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
