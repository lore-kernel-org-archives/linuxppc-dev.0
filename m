MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: SPI driver for m8xx
Date: Tue, 12 Mar 2002 09:54:24 -0600
Message-ID: <D3A72C5007329A4F991C0DD87202259F0EAFCD@sekhmet.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Jeremy Rosen" <Jeremy.Rosen@au.thalesgroup.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Jeremy,

The crappy driver you have is something I whipped up a long time back. It is a skeleton driver which does SPI transfer successfully. I dont have any includes and all the defines are in numbers, which can be a pain to understand. I hope to clean up all the crap and put out a clean driver soon.

About the m8xx_cpm_hostalloc, I have no clue why I used it either. I lifted it for an old i2c driver by Dan. I am looking at the routine in an old commproc.c file and see some comments on the top. It looks like one page of buffer is reserved for things like UART fifo's etc. I dont think you really need to use it.

I'll put the driver in this mailing list once I have it all ready and clean.

Navin.

-----Original Message-----
From: Jeremy Rosen [mailto:Jeremy.Rosen@au.thalesgroup.com]
Sent: Monday, March 11, 2002 10:03 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: SPI driver for m8xx



Hello everybody

a quick question while the subject of SPI driver is in the air

I am trying to reimplement the driver for the SPI based on the driver
from David Boppuri and Prashant Patel,
and their is a thing I don't understand...

for the TX and RX buffer, they use memory they get for
m8xx_cpm_hostalloc... why ?
Does it have something to do with the MMU ?
I would like to avoid doing that, is their a way to use normal ( kernel
space) memory ?

Thanks

Jeremy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
