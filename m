Message-ID: <01C0692A.FCFDAC80@NB1>
From: torsten.rissel@t-online.de (Torsten Rissel)
To: "'Gabriel Paubert'" <paubert@iram.es>, Matt Porter <mporter@mvista.com>
Cc: Torsten Rissel <torsten.rissel@t-online.de>,
        "Linuxppc-Embedded (E-Mail)"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: MVME 5100
Date: Mon, 18 Dec 2000 19:44:49 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


???

So would it be better to use the CHRP settings to build a kernel for the MVME5100 ?

Torsten

-----Ursprungliche Nachricht-----
Von:	Gabriel Paubert [SMTP:paubert@iram.es]
Gesendet am:	Montag, 18. Dezember 2000 19:08
An:	Matt Porter
Cc:	Torsten Rissel; Linuxppc-Embedded (E-Mail)
Betreff:	Re: MVME 5100



On Mon, 18 Dec 2000, Matt Porter wrote:

> > On the MVME2400 (and older Raven/Falcon based boards) the config space by
> > default is at 0x80000cf8 and 0x8000cfc. Does it mean that on the MVME5100,
> > the Hawk is reprogrammed by PPCBUG to look like a CHRP system ?
>
> Yes...and Yes. :)  The only thing the newer MCG boards really do
> (correctly) that looks like a PReP system is the disk booting
> mechanism.
>
> BTW, the MVME2100 (8240/Universe II board) is put in map B for a CHRP
> map as well.

Ok, fine. It means that  my code to reprogram the Raven/Hawk on 2[467]xx
just makes things more uniform. I still don't like the fact that the DMA
is offset, though (unless it's a residual data bug, and map B on 106/107
does not have this DMA offset).

	Regards,
	Gabriel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
