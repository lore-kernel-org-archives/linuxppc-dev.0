To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Silicon Motion VGA controllers and PPC architecture
MIME-Version: 1.0
Message-ID: <OFD7959B2B.BABE0C63-ONC1256DDD.002D77C3-C1256DDD.002D7E99@se.wavetek.com>
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Thu, 13 Nov 2003 09:16:48 +0100
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Forwarded by Laurent Mohin/STE/Global on 13/11/03 09:16 -----


Laurent Mohin
13/11/03 08:25


        To:     llandre <r&d@wawnet.biz>
        cc:     "'Mark Powell'" <medp@primagraphics.co.uk>
        Subject:        Re: Silicon Motion VGA controllers and PPC architecture

Hi,

We do use a SMI712 chip from Silicon Motion on an embedded 405GP board and
we have made it work without to more difficulties. The only real problem
you would be faced to is little endian manipulation, as always with this
kind of chip.
I also agree with Mark Powell concerning documentation which is very poor
and only describe registers contents, not the way to initialize the chip.

You will find a driver for it on u-boot and also a framebuffer driver in
Linux (at least in 2.4.20 if I remember well). You will also find an
accelerated driver for Xfree (I haven't tested it yet).

Laurent MOHIN
Acterna






llandre <r&d@wawnet.biz>
Sent by: owner-linuxppc-embedded@lists.linuxppc.org
12/11/03 17:52


        To:     linuxppc-embedded@lists.linuxppc.org
        cc:
        Subject:        Silicon Motion VGA controllers and PPC architecture



I'm looking for a VGA controller to use with an embedded PPC405-based
system.
I had a look at the Silicon Motion chips (712/722) and they seem very
suited for embedded applications.
Unfortunately the techical support claims that these chips, because the
presence of x86 BIOS, support only the x86 architecture. Anybody can
confirm this?

Thanks in advance,

llandre


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
