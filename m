Date: Tue, 20 Nov 2001 11:18:26 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ivo Kwee <ivo@idsia.ch>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dmasound
In-Reply-To: <Pine.GSO.4.21.0111201015370.18779-100000@mullein.sonytel.be>
Message-ID: <Pine.LNX.4.33.0111201110110.4207-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Translating as best I can (which isn't much):

> > Ik weet niet of je nog aan de dma_sound driver werkt, maar ik zag je
> > naam als laatste. Ik ben een beetje aan het prutsen met /dev/dsp op een
>
> Dat is lang geleden...
>
> Iain Sandoe werkt er momenteel het hardste aan, geloof ik. Maar zijn adres heb
> ik hier niet.

Who's working on the dmasound driver? Apparently Geert isn't anymore, he
thinks Iain Sandoe is doing most of the work, e-mail address for Iain,
anyone?

> > De lockup gebeurt als ik SND_DSP_SETFRAGMENT roep na een open-device
> > O_RDWR of O_RDONLY. Ik heb gekeken naar ander code voor andere
> > geluidskaarten en die checken of the device in read of write mode staat;
> > de dmasound doet dat niet. Kennelijk wordt alleen write_sq
> > veronderstelt. Moet er ook een if-read stuk in? Of worden buffers niet
> > gebruikt in Recording(IN) mode?
>
> Geen idee. Je vraagt dat best op de mailing list hieronder.

Kernel locks up after calling ioctl(SND_DSP_SETFRAGMENT,...) with device
(/dev/dsp??) opened read/write or readonly. dmasound doesn't check read or
write mode of the device, other drivers do. What's used for recording
(lacking read_sq)?

Does the fish work for Dutch?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
