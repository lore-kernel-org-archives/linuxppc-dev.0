Date: Mon, 10 Nov 2003 13:45:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Christophe.LINDHEIMER@fr.thalesgroup.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Prob to compile Kernel on mpc860.
Message-ID: <20031110204527.GE8584@ip68-0-152-218.tc.ph.cox.net>
References: <66CE949D18BCB249ABE8D9AF48C4F1CE777849@helios.clb.tcfr.thales> <20031030161634.B01C7C59E4@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031030161634.B01C7C59E4@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 30, 2003 at 05:16:29PM +0100, Wolfgang Denk wrote:
>
> Dear Christophe,
>
> in message <66CE949D18BCB249ABE8D9AF48C4F1CE777849@helios.clb.tcfr.thales> you wrote:
> >
> > prob 1 :
> > I am trying to compile the linuxppc_2_4_devel_2.4_20-2002_12_04 from Denx.
> > As I need debug, I replace -O2 by -g in the Makefile.
> > The kernel doesn't link anymore :[
>
> You cannot compile the Linux kernel without optimization, as then  no
> inlining of functions will be done. Use "-Os -g".
>
> > prob 2 :
> > Using linux2.4.22 from kernel.org.
> > I apply the patch for powerpc
> > the kernel doesn't compile.
> > Prob with stdarg.h that doesn't exist ( in sched.c )
>
> Try this patch:
[snip]

Or if you select BDI/KGDB/XMON, you can also pick
CONFIG_MORE_COMPILE_OPTIONS and add in -g (or put -Os -g and that will
override the -O2 that preceeds it).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
