Message-ID: <3AA9176B.1F1AA505@mvista.com>
Date: Fri, 09 Mar 2001 09:48:27 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: David Hopcroft <dhopcroft@aminocom.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem implementing pcmcia_cs on ppc 823 hardware
References: <01030917160500.00652@dhopcroft>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Try upgrading to the latest pcmcia-cs which is 3.1.24.  There have been
several changes.

Are you sure your card is 16 bit?  Typically the 100Mbit cards are
CardBus(32bit).

David Hopcroft wrote:
>
> Hi,
>
> I wonder if any one can shed some light on a problem I am having? I am trying
> to implement PCMCIA services on a custom PPC based board.
>
> I am using;
>         Processor - PPC 823 @ 64MHz
>         Kernel - 2.2.14
>         Card Services - 3.1.10
>         PCMCIA card - Xircom CreditCard Ethernet (CE3B-100BTX)
>
> I "insmod" the required modules (pcmcia_core, m8xx_pcmcia, ds and xirc2ps_cs)
> and run cardmgr.
>
> The problem arises when I insert a pcmcia card, into it's slot. At which
> point I get a "Kernel panic: machine check".  This seems to be around the area,
> in the code, where the card services are starting to read it's CIS/attribute
> area.
>
> I have iormap'd _IO_BASE to 0x80000000 in init.c
>
> My BMT is enabled but set to 255(Max value).
>
> The bus frequency of the board is 32Mhz I have tried setting this in the code
> to values of 32 & 32000000 with the same results. looking at file m8xx_pcmcia.c
> it should be set to the latter.
>
> Can any one suggest any thing obvious I have missed, or misunderstood?
>
> I can post a debug log if required, but it's quite long.
>
> ---
> David Hopcroft
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
