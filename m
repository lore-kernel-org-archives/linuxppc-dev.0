Date: Mon, 2 Jun 2003 22:43:05 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] A stand-alone boot loader for PReP
Message-ID: <20030603064305.GW32642@plato.local.lan>
References: <62639.213.107.143.228.1054413401.squirrel@www.solinno.co.uk> <20030531214950.GP32642@plato.local.lan> <63891.213.107.143.228.1054475827.squirrel@www.solinno.co.uk> <20030601221249.GQ32642@plato.local.lan> <20030602174032.GC787@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
In-Reply-To: <20030602174032.GC787@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 02, 2003 at 10:40:32AM -0700, Tom Rini wrote:
>
> I suspect it's because some PReP boxes (IBM ones, _mostly_) have
> OpenFirmware.  And yes, there's a few versions of OF that are as funky,
> if not funkier, than the one Apple uses.  But, as the 2.5 kernel shows,
> the OF code can be shared.  The problem is that not all PReP boxes
> support OF, so yaboot2 won't work on them.  Unless you're up for
> allowing non-OF machines. :)

i am not opposed to it, prom-libc is designed so the prom specific
stuff is simply a sysdep, it can be ported to pretty much any prom on
any architecture.  so long as the bootloader (yaboot) avoids using low
level prom calls wherever possible it will be easily portable to any
new arch prom-libc is ported to.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
