Date: Sat, 31 May 2003 13:49:50 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] A stand-alone boot loader for PReP
Message-ID: <20030531214950.GP32642@plato.local.lan>
References: <62639.213.107.143.228.1054413401.squirrel@www.solinno.co.uk>
Mime-Version: 1.0
In-Reply-To: <62639.213.107.143.228.1054413401.squirrel@www.solinno.co.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, May 31, 2003 at 09:36:41PM +0100, Leigh Brown wrote:
>
> [If you bore easily: http://www.solinno.co.uk/leigh/pablo/pablo-0.2.tar.gz ]
>
> Ever since I got Linux going on my PReP box I've been unhappy about the
> boot loader.  There is no lilo or yaboot equivalent for PReP and it's a
> pain.  For the past several months I've been trying to devise a way of
> making a bootloader similar to lilo or yaboot, and this is the best I've
> been able to come up with.

I have been working (slowly due to lack of time) on a complete rewrite
of yaboot, the plan is for it to support any OF based hardware (not
limited to powerpc), and to design it in a general way so it can
accomidate the various ways different architectures boot.

to start with im writing a prom-libc library so all the usual stdc
stuff doesn't have to be reinvented crappilly like every other loader
seems to do, as well as get the prom specific stuff out of bootloaders
and into a common place (it also should allow for a bootloader which
is designed well enough to be more easily portable to different prom
types so long as prom-libc has support). it will also allow the
bootloader to be written much more like ordinary unix C programs,
making them more portable (don't port the loader, port prom-libc).

my goal is to eliminate the need for a different bootloader for every
variation of hardware, i particularly hate how there is a dozen
different loaders all with different user interfaces just for powerpc,
much less other architectures.

I would much appreciate help with the yaboot2.0 project, if anyone is
interested contact me privatly, or on the yaboot-devel list
(http://lists.penguinppc.org/yaboot-devel).

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
