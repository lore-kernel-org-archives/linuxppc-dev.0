Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Matt Porter" <porter@cox.net>,
	"Laurent Mohin" <laurent.mohin@acterna.com>
Cc: "Stefan Roese" <stefan.roese@esd-electronics.com>,
	"Michael Meriin" <Michael@KSWaves.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: How to change endian attribute for a memory region
Date: Tue, 15 Oct 2002 07:35:40 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFKEHGDNAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20021015071546.A14041@home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > By the way, I really studied the chip and if I want to be able to manage
> > both 8 bpp and 16 bpp mode, I need to be able to change the endianness
> > attribute of the memory region.
>
> Why wouldn't you access video memory via a sthbrx instruction (writew)?

Right!
writew() - assumes that you are talking to a peripheral and all peripherals
must be little endian , thank you PCI.

__raw_writew() - accesses the memory in the native format which is
big-endian in your case.


To answer your other question:
You can not set an attribute on a memory region within the memory controller
to force the hardware to handle this for you on a region by region basis.
The chip's endianness may be configurable. This is an exercise let to the
programmer.  :(


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
