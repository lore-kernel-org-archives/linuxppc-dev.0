Message-ID: <3965B532.F00E82B6@univ-rennes1.fr>
Date: Fri, 07 Jul 2000 11:47:14 +0100
From: Martin Costabel <costabel@univ-rennes1.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: Gwyn Judd <b.judd@xtra.co.nz>
CC: Dan Foster <dsf@gblx.net>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: X still locks up
References: <20000707142631.B804@thislove.dyndns.org> <20000706232259.A3148@frontiernet.net> <20000707153525.A1445@thislove.dyndns.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gwyn Judd wrote:
[]
> Okay so you get it on x86 2.2.16 and XFree 4.01
> I get it on powerpc kernel >= 2.2.15 and XFree3.3.6
> Any other takers?

I don't know if all this is really the same thing, but I have been
getting sudden X freezes randomly with all 2.2.x kernels when using
Xpmac. For me this was the main reason to switch to XFree68_FBDev where
I *never* got these with 2.2.x kernels. Now I am getting these freezes
also with XFree68_FBDev (some 3.3.6 version) when using 2.3.x or 2.4.0
kernels. I very rarely use xmms (but always netscape), and I get these
freezes sometimes when the machine is completely idle. Sometimes this
happens after a couple of minutes, sometimes after 3 days.

The symptoms are: Mouse frozen, no keyboard input possible, no
MagicSysRq, no X shutdown with ctl-cmd-del, no console switching, the
only key combination working is the ctl-cmd-power hard reboot. On the
other hand, the kernel and even X seem to continue to live at least for
a while. I can see messages continue to scroll down and hear downloads
or compilations making their disk noise. The one time I tried to ping
from the outside, I was not successful, but then it sometimes takes 2
minutes of pinging to wake the machine up and get a response even when
it is not frozen.

>From my observations, I concluded that this must be a problem with the
keyboard and/or mouse drivers in X. But since this part of the kernel
and X ( I never understood why XFree has to have their own drivers for
everything that is already in the kernel) is worst black magic, rapidly
changing in incompatible ways, and since my machine (6400, ADB keyboard
and mouse, valkyrie video) belongs to an endangered species anyway, I
did not really try to understand what happens.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
