Message-ID: <023a01c2736b$0db250c0$450fa8c0@amitesting>
From: "Michael Meriin" <Michael@KSWaves.com>
To: "Stefan Roese" <stefan.roese@esd-electronics.com>,
	"Laurent Mohin" <laurent.mohin@acterna.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <EFEAIMDCOOOHIEPHDNFJAENOEHAA.stefan.roese@esd-electronics.com>
Subject: Re: How to change endian attribute for a memory region
Date: Mon, 14 Oct 2002 12:18:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan,

> why don't you use the MD4 signal of the Epson Chip to configure it as big
> endian device? Or am I missing something here?
>
> Best regards,
> Stefan.
>

First of all it is not my implementation problem :))
You are right you can use this signal,  but in my implementation for 13704
it was impossible to use it, because of other signals constrains:
 this signal was possible to be used only for 68000 bus.
So in our case (MPC855) we simply flipped the data bus, by the way only
after that we
found out that this solution was suggested by Epson too.

Best Regards,
                     Michael Meriin

> > Betreff: Re: How to change endian attribute for a memory region
> >
> >
> >
> > Michaêl,
> >
> > I can't connect the chip as a byte wide device due to performance
> > degradation.
> > Due to other constraints, I can't invert MSB and LSB. In fact,
> > due to color
> > mapping, if I work in 8 bit per pixel, I must address my
> > framebuffer in big
> > endian mode. In 16 bit per pixel, I need to use little endian mode.
> > So I really need to change the endian attribute.
> >
> > Thanks for your answer
> >
> > Laurent
> >
> >
> >
> >
> > "Michael Meriin" <Michael@KSWaves.com> on 14/10/2002 10:57:00
> >
> > To:    linuxppc-embedded@lists.linuxppc.org, Laurent
> >        Mohin/SE/Wavetek@Global
> > cc:
> > Subject:    Re: How to change endian attribute for a memory region
> >
> >
> >
> > > I'm trying to interface a 405GP chip with an EPSON S1D13506 graphic
> > > controller. Because the EPSON chip is a little endian, I need to have
my
> > > framebuffer memory acceded in little endian mode.
> > > What is the best way to change endian attribute for a specific memory
> > > region (ioremap little endian)?
> > >
> > > Laurent
> >
> > I suggest you to connect it to the uP as a byte wide device, this will
> > immediately solve your problem.
> > The second way you can do it for 16 bit bus to connect MSB and LSB wise
a
> > wiser.
> > >
> > Best Regards,
> >                      Michael Meriin
> >
> >
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
