Date: Mon, 18 Dec 2000 20:07:55 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Torsten Rissel <torsten.rissel@t-online.de>
cc: Matt Porter <mporter@mvista.com>,
        "Linuxppc-Embedded (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: AW: MVME 5100
In-Reply-To: <01C0692A.FCFDAC80@NB1>
Message-ID: <Pine.HPX.4.10.10012181958430.3991-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
