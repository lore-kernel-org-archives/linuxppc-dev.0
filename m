MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: memory problems on ppc 8260 based hardware
Date: Tue, 4 May 2004 13:56:11 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DACE@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "liuming" <13787783324@hnmcc.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


See
http://e-www.motorola.com/files/32bit/doc/white_paper/MPC826XSDRAMWP.pdf

Basically the clocks going to the SDRAM has to be leading the clock
going to the 8260 by about 1 ns.

This will only show up when doing burst accesses (like linux does all
the time) and no while doing standard memory tests.


> -----Original Message-----
> From: liuming [mailto:13787783324@hnmcc.com]
> Sent: Tuesday, May 04, 2004 13:38
> To: Rune Torgersen
> Subject: Re: memory problems on ppc 8260 based hardware
>
>
> Hi,
>       Mr Torgersen, thanks a lot .
>       I have read the Errata of 8260.  SDRAM is 32bit    (60x
> bus), is it the reason?  could you say something about you
> fixed the hardware on an inhouse board?
>
> Best regards!
>  liu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
