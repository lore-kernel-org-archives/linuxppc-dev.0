Date: Thu, 24 Oct 2002 12:14:47 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] arch/ppc/8xx_io/enet.c
In-reply-to: <3DB7C77A.E7DDFB69@imc-berlin.de>
To: Steven Scholz <steven.scholz@imc-berlin.de>,
	Ricardo Scop <scop@digitel.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLCEFIFHAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Ricardo Scop wrote:
> >
> > On Wednesday 23 October 2002 05:51, Joakim Tjernlund wrote:
> > > On Monday 21 October 2002 15:13, Joakim Tjernlund wrote:
> > > > Hi
> > > >
> > > > Here is a patch to drop the expensive memcpy of received ethernet frames
> > > > in interrupt context. I have not done any bench marking, but mounting a
> > > > NFS rootfs feels faster.
> > > >
> > > > I am using a heavily modified enet.c in my system, but I think I got the
> > > > patch correct.
> > > >
> > > > Also fixed a bug in set_multicast_list(), move the dmi list forward when
> > > > walking it(dmi = dmi->next;)
> > > >
> > > > Comments? Anyone care to do some benchmarking?
> > >
> > > No comments so far, no one interested in this?
> > I'm interested! Indeed, I adapted and tested your patch in a 8260 FCC fast
> > ethernet driver and it worked fine  I had a 20% increase in routing
> > throughput with the  patch installed!
> > ...
>
> Did I understand that correctly that this patch would work with mith MPC8xx FEC
> as well!?!?

Yes, but you have to adapt it a little.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
