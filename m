Date: Fri, 19 Oct 2001 21:47:21 -0500
From: Takashi Oe <toe@unlserve.unl.edu>
To: Andrew P McPherson <apm@MIT.EDU>
Cc: dgatwood@apple.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Compiling BootX?
Message-Id: <20011019214721.4b22cb68.toe@unlserve.unl.edu>
In-Reply-To: <Pine.GSO.4.30L.0110182335130.14820-100000@home-on-the-dome.mit.edu>
References: <ED9543FC-C3EC-11D5-951D-003065B90BBC@apple.com>
	<Pine.GSO.4.30L.0110182335130.14820-100000@home-on-the-dome.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 18 Oct 2001 23:39:12 -0400 (EDT), Andrew P McPherson wrote:

> I tried setting the machine ID to a 5200/75, but it didn't make a
> difference.  I'm starting to think that it crashes in the MkLinux booter
> before it even gets to the kernel.  Or it crashes before it initializes
> the framebuffer, but I thought there was some sort of early boot console
> in LinuxPPC like there is in Linux/mac68k.

Which kernel are you specifically using?  Recent nbpmac kernels
(< 6 mos) might possibly do wrong things on your machine resulting
no visible change before crashing.  Just to see if the booter is
at fault, you might try much older nbpmac kernels (> 1 yr) or some
of MkLinux kernels.  Or just to add some variety, try miBoot on
nbpmac kernel site.  By the way, when using the apple booter, make
sure you have virtual memory ON if it is OFF, or have some decent
amount of disk cache if not.  You might also try rearranging SIMM
in some way.


Takashi Oe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
