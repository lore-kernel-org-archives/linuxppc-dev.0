From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Matt Porter" <mporter@mvista.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Bogus interrupt
Date: Wed, 28 Feb 2001 09:29:18 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMGEIFCPAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20010227051445.A32137@cx258813-a.chnd1.az.home.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Hi everyone,
> >   I'm trying to run kernel 2.5 on Motorola MVME5100 and, after the sti
> > istruction in start_kernel, the kernel hangs due to a spurious
> interrupt.
> > (Bogus interrupt -1)
> > Is this a well-known problem also in other ports ? or have
> anyone of you a
> > suggestion to solve this ?
>
> If you are using the default openpic initsenses in prep_pci.c then you
> might see this problem since MPIC input 1 now has the 550 UART.  You'll
> need to change the initsenses since the edge triggered ECC interrupt
> used to be on input 1 on the older boards.
>
I've started working on MCPN765 port, since I think MVME5100 is an MCPN765
with a VME Bridge and without an ISA bridge, so I think the senses of
interrupt are correct because the 5100 and the 765 manual page related to
the interrupt senses is exactly the same (or it is a cut&paste error ??? :))
However this problem, like many other I've encountered, are all due to a bad
cross-compiler :(. I start working today with a good environment after a
month of nightmares !

Thank you very much for the help.
Stefano.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
