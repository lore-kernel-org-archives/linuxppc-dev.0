Date: Mon, 18 Sep 2000 10:56:30 -0700
From: Matt Porter <mporter@mvista.com>
To: Adrian Cox <apc@agelectronics.co.uk>
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
Message-ID: <20000918105630.A7893@cx258813-a.chnd1.az.home.com>
References: <39C6262B.A54933C2@agelectronics.co.uk> <20000918144149.27565@mailhost.mipsys.com> <39C62D8C.D99457DF@agelectronics.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39C62D8C.D99457DF@agelectronics.co.uk>; from apc@agelectronics.co.uk on Mon, Sep 18, 2000 at 03:58:20PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Sep 18, 2000 at 03:58:20PM +0100, Adrian Cox wrote:
>
> Benjamin Herrenschmidt wrote:
>
> > I didn't find any mention of a DMA engine in the MPC106... Or did I miss
> > something ?
>
> You're probably right - I never worked with the 106, but went straight
> to the 107.

Yes, the 107 is the first Mot. Semi bridge to incorporate a DMA engine.
The IBM CPC710 and 405GP both have DMA engines that could be used this
way as well.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
