Subject: Re: How to change endian attribute for a memory region
To: "Ralph Blach" <rcblach@us.ibm.com>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Tue, 15 Oct 2002 17:00:02 +0200
Message-ID: <OF780A3997.14F8A90A-ONC1256C53.00523F95@eni.wago.de>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph,

That was the purpose of my question. Has anybody written this IOremap_LE
function?

Laurent




"Ralph Blach" <rcblach@us.ibm.com> on 15/10/2002 16:34:14

To:    Matt Porter <porter@cox.net>
cc:    linuxppc-embedded@lists.linuxppc.org
Subject:    Re: How to change endian attribute for a memory region




OK, I know this is absolute HERESY  for all you out there, and would never
be supported in the kernel tree,
and probably with very good reasons, but I'll mention it anyway.

ON the 405 and the 440 class processors, there is an endian bit in the TLB
which would make a 4k region
little endian.  To use this bit one would have to write an IOremap_LE and
support the bit in the page table,
but it could be used.

There are probabley better ways that are more inline with the PPC
philosophy.

Chip



Matt Porter <porter@cox.net>@lists.linuxppc.org on 10/15/2002 10:15:46 AM

Sent by:    owner-linuxppc-embedded@lists.linuxppc.org


To:    Laurent Mohin <laurent.mohin@acterna.com>
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
