Date: Thu, 20 Dec 2001 11:09:42 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ISA DMA
In-Reply-To: <3C21B464.4030509@humboldt.co.uk>
Message-ID: <Pine.GSO.4.21.0112201108400.502-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 Dec 2001, Adrian Cox wrote:
> David Müller (ELSOFT AG) wrote:
> > What south bridge do you use? Some of the newer ones offer 32bit
> > addressing capability for DMA.
>
> Via686a. As I understand it, 32-bit DMA uses the DMA_HI_PAGE_x registers
> from 0x487 to 0x48a, and the Via manual doesn't claim to have any
> registers in that range. The only 32-bit DMA southbridge I've
> encountered is the Winbond chip on the Sandpoint, and that chip doesn't
> have UDMA66, USB, and audio.

And the Winbond South Bridge on the LongTrail (most probably the same chip).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
