Date: Thu, 18 Oct 2001 23:39:12 -0400 (EDT)
From: Andrew P McPherson <apm@MIT.EDU>
To: "David A. Gatwood" <dgatwood@apple.com>
Cc: Takashi Oe <toe@unlserve.unl.edu>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Compiling BootX?
In-Reply-To: <ED9543FC-C3EC-11D5-951D-003065B90BBC@apple.com>
Message-ID: <Pine.GSO.4.30L.0110182335130.14820-100000@home-on-the-dome.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I missed your hardware config.  What was it, again?  If it's a 68k mac
> with a PPC card, you probably want to set it to the gestalt of a 5300.
> The kernel should then identify that it isn't really a 5300 and should
> half-heartedly attempt to boot anyway, then crash at some point.  Let me
> know the gestalt, and I can verify whether the MkLinux booter knows it.
> I can't promise that I'd be allowed to send you an update or anything,
> but at least I can check and see if it knows the gestalt.  :-)
>

I'm running a Quadra 700 with PPC card.  It allegedly has a gestalt of
116, which the booter doesn't recognize.  I also have a Quadra 800
available to work with, or a IIci with its own PPC card, but I suspect
that would be a lot of work to get going with the RBV framebuffer and
whatnot.

I tried setting the machine ID to a 5200/75, but it didn't make a
difference.  I'm starting to think that it crashes in the MkLinux booter
before it even gets to the kernel.  Or it crashes before it initializes
the framebuffer, but I thought there was some sort of early boot console
in LinuxPPC like there is in Linux/mac68k.

It looks like I don't have much choice other than to pick up an older copy
of CodeWarrior to work with.  Anyone want to sell me one? ;)

-Andrew


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
