Subject: Re: How to change endian attribute for a memory region
To: Matt Porter <porter@cox.net>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	Michael Meriin <Michael@KSWaves.com>,
	linuxppc-embedded@lists.linuxppc.org
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Tue, 15 Oct 2002 16:57:56 +0200
Message-ID: <OFA8D7B9E2.58F185A5-ONC1256C53.0051DE49@eni.wago.de>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt,

In fact, after registering my frame buffer driver, my video memory is
accessed directly by the X server.
So I can't control the instruction (writew or other) it will use.

Thanks,

Laurent




Matt Porter <porter@cox.net> on 15/10/2002 16:15:46

To:    Laurent Mohin/SE/Wavetek@Global
cc:    Stefan Roese <stefan.roese@esd-electronics.com>, Michael Meriin
       <Michael@KSWaves.com>, linuxppc-embedded@lists.linuxppc.org
Subject:    Re: How to change endian attribute for a memory region




On Tue, Oct 15, 2002 at 01:07:19PM +0200, Laurent Mohin wrote:
>
> Stefan,
>
> I'm the initiator of the question.
> I use the Epson chip in big endian mode. The problem is that in 16 bpp
> mode, the RGB mapping into video memory is fixed by the chip and
described
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
