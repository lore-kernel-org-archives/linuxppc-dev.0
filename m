Message-ID: <021e01c2735f$a8f52280$450fa8c0@amitesting>
From: "Michael Meriin" <Michael@KSWaves.com>
To: <linuxppc-embedded@lists.linuxppc.org>,
	"Laurent Mohin" <laurent.mohin@acterna.com>
References: <OFA0841909.55B0BFCD-ONC1256C53.002F2136@eni.wago.de>
Subject: Re: How to change endian attribute for a memory region
Date: Mon, 14 Oct 2002 10:57:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I'm trying to interface a 405GP chip with an EPSON S1D13506 graphic
> controller. Because the EPSON chip is a little endian, I need to have my
> framebuffer memory acceded in little endian mode.
> What is the best way to change endian attribute for a specific memory
> region (ioremap little endian)?
>
> Laurent

I suggest you to connect it to the uP as a byte wide device, this will
immediately solve your problem.
The second way you can do it for 16 bit bus to connect MSB and LSB wise a
wiser.
>
Best Regards,
                     Michael Meriin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
