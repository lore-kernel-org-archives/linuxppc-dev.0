Date: Tue, 15 Oct 2002 07:15:46 -0700
From: Matt Porter <porter@cox.net>
To: Laurent Mohin <laurent.mohin@acterna.com>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	Michael Meriin <Michael@KSWaves.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to change endian attribute for a memory region
Message-ID: <20021015071546.A14041@home.com>
References: <OFC1D42D18.CCDFA3B3-ONC1256C53.003C90BA@eni.wago.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFC1D42D18.CCDFA3B3-ONC1256C53.003C90BA@eni.wago.de>; from laurent.mohin@acterna.com on Tue, Oct 15, 2002 at 01:07:19PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Oct 15, 2002 at 01:07:19PM +0200, Laurent Mohin wrote:
>
> Stefan,
>
> I'm the initiator of the question.
> I use the Epson chip in big endian mode. The problem is that in 16 bpp
> mode, the RGB mapping into video memory is fixed by the chip and described
> in little endian format.
>
> By the way, I really studied the chip and if I want to be able to manage
> both 8 bpp and 16 bpp mode, I need to be able to change the endianness
> attribute of the memory region.

Why wouldn't you access video memory via a sthbrx instruction (writew)?

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
