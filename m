Date: Mon, 25 Oct 1999 14:52:11 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: Dan Malek <dan@netx4.com>
cc: Dan Malek <dan@penguin.netx4.com>,
        "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx updates to 2.2.13
In-Reply-To: <3814641B.5A628170@netx4.com>
Message-ID: <Pine.LNX.3.96.991025145044.18069D-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 25 Oct 1999, Dan Malek wrote:

> Mark S. Mathews wrote:
> > 
> > Hey Dan,
> > 
> > We just got done getting the 2.2.13 running on the RPX-lite.  We had to
> > add CONFIG_ENET_SCC2 to its config to make it work.  Thanks for the
> > update!
> 
> You are welcome....but didn't 'make config' ask you which SCC
> to use for the Ethernet?  You really shouldn't edit .config by
> hand, as there are other files updated during the 'make config'
> procedure.

You are so right.  When we config'd it originally, we used the defaults
from your existing config.  If you select SCC1, then it (rightly) doesn't
ask you about SCC2.  Our bad.

Thanks for the note.

-Mark

Mark S. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
