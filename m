Message-ID: <3D78B748.FDB8449A@opensource.se>
Date: Fri, 06 Sep 2002 16:10:16 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Matthew Locke <mlocke@mvista.com>
Cc: Fanny Wakizaka <fanny.wakizaka@cyclades.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA cards for MPC8xx?
References: <005d01c254fc$220722e0$5fa1ba40@optiplex> <3D77D72D.1020505@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've used 16550 serial ports with the m8xx_pcmcia driver.
It did not work right out of the box then (2.2), I think
some structure was shared between 8xx_io/uart.c and
the generic 16550 serial.c. And I think serial.c poked
around in some unmapped io-space.

If you get a list of working cards, maybe they could
be put in the embedded powerpc howto?

/ Magnus


Matthew Locke wrote:
>
> Fanny Wakizaka wrote:
>
> >Hi,
> >We are developing a custom hw based on the MPC855 with support to PCMCIA. We
> >are using MontaVista linux kernel 2.4.17.
> >Could you give me some suggestions of PC Cards that worked with MPC8xx? I'm
> >looking for ethernet cards, modem cards and wireless cards.
> >Thanks in advance,
> >Fanny
> >
> I have used: cisco 340/350 and lucent wlan cards, 3com 3c589 lan cards,
> and modems cards do not work.  The problem with modem cards had
> something to do with a dependancy on serial.c (8xx uses
> arch/ppc/8xx_io/uart.c).  I don't remember the exact problem now.
>
> >
> >
> >
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
