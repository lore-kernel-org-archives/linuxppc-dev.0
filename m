Subject: Re: How to change endian attribute for a memory region
To: "Stefan Roese" <stefan.roese@esd-electronics.com>
Cc: "Michael Meriin" <Michael@KSWaves.com>,
	linuxppc-embedded@lists.linuxppc.org
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Tue, 15 Oct 2002 13:07:19 +0200
Message-ID: <OFC1D42D18.CCDFA3B3-ONC1256C53.003C90BA@eni.wago.de>
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan,

I'm the initiator of the question.
I use the Epson chip in big endian mode. The problem is that in 16 bpp
mode, the RGB mapping into video memory is fixed by the chip and described
in little endian format.

By the way, I really studied the chip and if I want to be able to manage
both 8 bpp and 16 bpp mode, I need to be able to change the endianness
attribute of the memory region.

Thanks for your answer,

Laurent




"Stefan Roese" <stefan.roese@esd-electronics.com> on 15/10/2002 11:55:51

To:    Laurent Mohin/SE/Wavetek@Global, "Michael Meriin"
       <Michael@KSWaves.com>
cc:    linuxppc-embedded@lists.linuxppc.org
Subject:    Re: How to change endian attribute for a memory region




Michael,

why don't you use the MD4 signal of the Epson Chip to configure it as big
endian device? Or am I missing something here?

Best regards,
Stefan.

> -----Ursprüngliche Nachricht-----
> Von: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]Im Auftrag von
> Laurent Mohin
> Gesendet: Dienstag, 15. Oktober 2002 11:08
> An: Michael Meriin
> Cc: linuxppc-embedded@lists.linuxppc.org
> Betreff: Re: How to change endian attribute for a memory region
>
>
>
> Michaêl,
>
> I can't connect the chip as a byte wide device due to performance
> degradation.
> Due to other constraints, I can't invert MSB and LSB. In fact,
> due to color
> mapping, if I work in 8 bit per pixel, I must address my
> framebuffer in big
> endian mode. In 16 bit per pixel, I need to use little endian mode.
> So I really need to change the endian attribute.
>
> Thanks for your answer
>
> Laurent
>
>
>
>
> "Michael Meriin" <Michael@KSWaves.com> on 14/10/2002 10:57:00
>
> To:    linuxppc-embedded@lists.linuxppc.org, Laurent
>        Mohin/SE/Wavetek@Global
> cc:
> Subject:    Re: How to change endian attribute for a memory region
>
>
>
> > I'm trying to interface a 405GP chip with an EPSON S1D13506 graphic
> > controller. Because the EPSON chip is a little endian, I need to have
my
> > framebuffer memory acceded in little endian mode.
> > What is the best way to change endian attribute for a specific memory
> > region (ioremap little endian)?
> >
> > Laurent
>
> I suggest you to connect it to the uP as a byte wide device, this will
> immediately solve your problem.
> The second way you can do it for 16 bit bus to connect MSB and LSB wise a
> wiser.
> >
> Best Regards,
>                      Michael Meriin
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
