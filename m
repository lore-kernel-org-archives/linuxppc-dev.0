Message-ID: <3A6C5015.AA99E37@pop.agri.ch>
Date: Mon, 22 Jan 2001 16:22:04 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Uwe Steinmann <steinm@majestix.fernuni-hagen.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: pcmcia on pismo: PCI irq 58 test failed
References: <20010122134226.A7757@gehtnix.fernuni-hagen.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Uwe Steinmann wrote:
>
> Hi,
>
> I'm trying to make pcmcia 3.1.22 support work on a pismo with
> kernel 2.2.18-pre17-ben1. I was able to talk to a serial model card
> but ran into problems with an AVM fritz!card though the necessary patch
> for this card has been applied to the pcmcia package.
>
> By looking at the syslog messages I feel like the problem is rather caused
> by the pcmcia support than by this particular pcmcia card.
> In the syslog I found a message
>
> Jan 19 20:33:06 pb kernel:     PCI irq 58 test failed
>
> which somewhat bother me.
>
> Is this a proper behaviour? Could this be the reason that the avm pcmcia card
> cannot request an irq?
>

Have you read this page : http://www.mpifr-bonn.mpg.de/div/iri/Archiv/LinuxPPC/PCMCIA.html

You may can update to pcmcia-cs-3.1.24. Without the ppc patches.

I don't own such a card, but these steps may help....

Cheers

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
