Message-ID: <3C5B26EA.C99DAE5A@mvista.com>
Date: Fri, 01 Feb 2002 16:38:18 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: Val Henson <val@nmt.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: GT64260 ethernet
References: <20020201134723.G30787@boardwalk> <20020201155645.B4843@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jeff Garzik wrote:

> On Fri, Feb 01, 2002 at 01:47:23PM -0700, Val Henson wrote:
> > We have a board with the Galileo GT64260 chip and we'd like to use the
> > gt64260 ethernet driver.  At the moment, its config option is in
> > arch/ppc/config.in and is controlled by the CONFIG_GT64260 option
> > (which is not turned on for our boards, CONFIG_GEMINI is).  I'd think
> > that the preferred way to fix this is to put the CONFIG_GT64260_ETH
> > option in drivers/net/config.in.  The alternative is to have
>
> I at least prefer to have as many drivers as possible, including
> arch-specific ones, in drivers/net and listed in drivers/net/Config.in.
> It makes life a lot easier when evaluating all drivers for a common bug,
> or common cleanup.

Yes, that make sense.  I'll get that moved over.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
