Date: Mon, 18 Dec 2000 19:07:47 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Matt Porter <mporter@mvista.com>
cc: Torsten Rissel <torsten.rissel@t-online.de>,
        "Linuxppc-Embedded (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MVME 5100
In-Reply-To: <20001218105831.B15513@beef.az.mvista.com>
Message-ID: <Pine.HPX.4.10.10012181905200.3991-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
