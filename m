Message-ID: <01C06932.30CD0E00@NB1>
From: torsten.rissel@t-online.de (Torsten Rissel)
To: "'Gabriel Paubert'" <paubert@iram.es>,
        Torsten Rissel
	 <torsten.rissel@t-online.de>
Cc: Matt Porter <mporter@mvista.com>,
        "Linuxppc-Embedded (E-Mail)"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: AW: MVME 5100
Date: Mon, 18 Dec 2000 20:36:23 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yeah,

that's exactly what I am working on in the moment.

Thanks,
Torsten

-----Ursprungliche Nachricht-----
Von:	Gabriel Paubert [SMTP:paubert@iram.es]
Gesendet am:	Montag, 18. Dezember 2000 20:08
An:	Torsten Rissel
Cc:	Matt Porter; Linuxppc-Embedded (E-Mail)
Betreff:	Re: AW: MVME 5100



On Mon, 18 Dec 2000, Torsten Rissel wrote:

> ???
>
> So would it be better to use the CHRP settings to build a kernel for the MVME5100 ?

Not necessarily. What I did on my machines was to put them in CHRP mode by
reprogramming the Raven or the Hawk, but I essentially used a common
kernel (just adding a powerplus boolean in some cases, this is however not
the right solution). Try the CHRP version but you might still run into
problems. I don't trust residual data, the problem you have is most likely
the missing interrupt routing information thing.

Try to find what the network interrupts are on the MVME5100 and add the
data in the tables in prep_pci.c, since Motorola does not provideeeee
this vital information.

	Regards,
	Gabriel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
