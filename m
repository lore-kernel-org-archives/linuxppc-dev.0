Date: Thu, 14 Oct 1999 20:48:25 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Re: Enet on FADS
In-reply-to: <38066057.1D220DEA@mvista.com>
To: Jim Lewis <jlewis@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9910142037320.991-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Jim,

thanks for your offer. Are you using 2.2.5 or 2.3.18? I found that there
is not much to modify, here is what I found:
 1) add FADS board type in config.in in arch/ppc
 2) change init.c in arch/ppc/mm
 3) change commproc.h and enet.c in arch/ppc/8xx_io
 4) add fads_cfg im embedded_config.c in arch/ppc/mbxboot
 5) modify head.S in arch/ppc/mbxboot to call 4)
 6) modify Makefile in arch/ppc/mbxboot to remove unnecessary OBJ
 7) update fads.h in include/asm-ppc

It seems that the FADS was supported in the past since there is some
trace of it. Is it possible to put it back in a public tree?

Right now I am able to go to the point where the kernel is trying to
bootp except that an error is reported in devinet.c.

So, Jim, if you are using 2.3.18 can you generate a patch? I am 
tempted to look at what you have done.

Another question: it there a way to track down the source file containing
a given function? And track down an include file containing a definition?
I am sure there is a way.

Claude

On Thu, 14 Oct 1999, Jim Lewis wrote:

> I am using Ethernet on an 823 FADS. I sort of inherited some work that someone
> else began. I don't consider it finished yet, but if you want a snapshot of
> what we have now, let me know.
> 
> Claude Robitaille wrote:
> 
> > I see many people using the FADS but yet, enet.c does not seems to
> > support it. So, people are either just using the SMC serial port
> > or the change in enet.c is not committed yet into vger. Is there
> > someone using the Ethernet port on the FADS?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
