Message-ID: <3DB7C77A.E7DDFB69@imc-berlin.de>
Date: Thu, 24 Oct 2002 12:12:10 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Ricardo Scop <scop@digitel.com.br>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] arch/ppc/8xx_io/enet.c
References: <200210230751.g9N7pN4d024262@blooper.utfors.se> <02102313323200.01073@scop.digitel.com.br>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ricardo Scop wrote:
>
> On Wednesday 23 October 2002 05:51, Joakim Tjernlund wrote:
> > On Monday 21 October 2002 15:13, Joakim Tjernlund wrote:
> > > Hi
> > >
> > > Here is a patch to drop the expensive memcpy of received ethernet frames
> > > in interrupt context. I have not done any bench marking, but mounting a
> > > NFS rootfs feels faster.
> > >
> > > I am using a heavily modified enet.c in my system, but I think I got the
> > > patch correct.
> > >
> > > Also fixed a bug in set_multicast_list(), move the dmi list forward when
> > > walking it(dmi = dmi->next;)
> > >
> > > Comments? Anyone care to do some benchmarking?
> >
> > No comments so far, no one interested in this?
> I'm interested! Indeed, I adapted and tested your patch in a 8260 FCC fast
> ethernet driver and it worked fine  I had a 20% increase in routing
> throughput with the  patch installed!
> ...

Did I understand that correctly that this patch would work with mith MPC8xx FEC
as well!?!?

Cheers,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
