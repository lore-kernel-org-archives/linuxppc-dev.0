From: "Ron Bianco" <ronb@junction.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: custom mpc8240 student project (long)
Date: Thu, 21 Feb 2002 14:40:05 -0800
Message-ID: <001401c1bb28$b5363880$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <15477.22880.141084.768742@zaphod.musenki.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


My $.02:

Why don't you just use a regular old EPROM to hold your ppcboot monitor image.?
IIRC, it has a serial driver and provision for downloading linux kernels to
SDRAM.
I'm not sure if it has provision for R/W of flash, but maybe.

You're planning to run at a very low clock speed on your wire-wrapped board.
Ugh!
Better check the 8240 datasheet, there may be lower limits to what's allowed.

You'll be very handicapped by not having a BDI2000, which, BTW, uses JTAG port
for fast downloads to SDRAM.
Surely your school has a budget for development tools?  The BDI would have other
uses besides just your 8240 project.

Good luck, Ron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
