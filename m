Date: Fri, 13 Oct 2000 13:16:35 -0400
From: Josh Huber <huber@mclx.com>
To: Michel D?nzer <daenzerm@student.ethz.ch>
Cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
Message-ID: <20001013131623.E3387@missioncriticallinux.com>
References: <20001011141722.A1437@missioncriticallinux.com> <39E4B4D0.FA62D929@student.ethz.ch> <20001011145249.B1437@missioncriticallinux.com> <39E4BAD4.E78B4E3B@student.ethz.ch> <20001011152633.A1614@missioncriticallinux.com> <39E4EE41.9E708472@student.ethz.ch>
Mime-Version: 1.0
In-Reply-To: <39E4EE41.9E708472@student.ethz.ch>; from daenzerm@student.ethz.ch on Thu, Oct 12, 2000 at 12:48:33AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 12, 2000 at 12:48:33AM +0200, Michel D?nzer wrote:
> > I'll also upgrade to 2.4 to see if that makes a difference.
> >
> > btw, dmesg shows that the fbcon system only detected one card -- the
> > AGP one.
>
> That should work better with a 2.4 kernel. Anyway, have you used two
> video=aty128fb: ?

I tried this, and also tried the 2.4 kernel, with no luck.  2.4 spit
out some messages about pci assignments, but other than that, no other
framebuffer devices were configured, and X didn't function as
expected.

But, someone mentioned later in this thread, there might be a problem
with using a PC video card on ppc because of #ifdef __powerpc__'s in
ani patches?

Thanks for the help,

--
Josh
| huber@mclx.com |
1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
