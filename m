Date: Sat, 8 May 2004 10:16:07 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 2.6.5 kernel build: 'macro "mfmsr" passed 1 arguments, but takes
 just 0'
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHCENOCFAA.Joakim.Tjernlund@lumentis.se>
Message-ID: <Pine.LNX.4.58.0405081014260.13274@localhost.localdomain>
References: <BCEFJBPJCGFCNMMMIDBHCENOCFAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 8 May 2004, Joakim Tjernlund wrote:

> >   as did someone else on this list recently, i did a first attempt at
> > compiling the stock 2.6.5 kernel for an MPC8xx board.  from a verbose
> > build:
> > ====================================================================
> > ...
> [SNIP]
>
> The stock kernel is not up to date. Use the PPC tree,
> http://ppc.bkbits.net:8080/linuxppc-2.5, instead. That tree should
> compile, but still has run time problems.

ok, thanks.  regarding the run-time problems, it's not like i wanted to
get a production-ready system right now -- i'll be satisfied to see just
how far i can get.  more a curiosity thing than anything else.

rday

p.s.  BTW, is this the right forum to discuss getting a 2.5/2.6 kernel
running on an MPX8xx board?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
