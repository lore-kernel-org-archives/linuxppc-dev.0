Date: Tue, 20 Nov 2001 10:19:10 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ivo Kwee <ivo@idsia.ch>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dmasound
In-Reply-To: <83DAF59A.7000607@idsia.ch>
Message-ID: <Pine.GSO.4.21.0111201015370.18779-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hoi Ivo,

> Ik weet niet of je nog aan de dma_sound driver werkt, maar ik zag je
> naam als laatste. Ik ben een beetje aan het prutsen met /dev/dsp op een

Dat is lang geleden...

Iain Sandoe werkt er momenteel het hardste aan, geloof ik. Maar zijn adres heb
ik hier niet.

> PPC titanium en elke keer locks de computer volop na een
> SND_DSP_SETFRAGMENT.  Ten eerst moet volgens my the sq_ioctl for the
> case SND_DSP_SETFRAGMENT een return geven met de aktuele settings
>          return IOCTL_OUT(arg, size | nbufs << 16);
> ipv
>          return IOCTL_OUT(arg,write_sq.bufSize | write_sq.numBufs << 16);
> niet?
>
> De lockup gebeurt als ik SND_DSP_SETFRAGMENT roep na een open-device
> O_RDWR of O_RDONLY. Ik heb gekeken naar ander code voor andere
> geluidskaarten en die checken of the device in read of write mode staat;
> de dmasound doet dat niet. Kennelijk wordt alleen write_sq
> veronderstelt. Moet er ook een if-read stuk in? Of worden buffers niet
> gebruikt in Recording(IN) mode?

Geen idee. Je vraagt dat best op de mailing list hieronder.

> P.S.1 Waar moet ik normaal zulke vragen stellen ipv naar jou direkt?

linuxppc-dev@lists.linuxppc.org

> P.S.2 Werk je aan de Aibo?

Neen, dat is een ander team. Ik werk aan set top boxes.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
