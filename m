Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Stable BK for 405GP Walnut?
Date: Tue, 21 May 2002 21:35:23 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFAEGJDHAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I retrieved the latest linuxppc_2_4 source code with the intentions of
building a Walnut kernel. We are looking to build the next shippable kernel
ASAP so we thought it would be best to use the "stable" version.
Unfortunately when I tried to configure and compile we encountered several
surprises:

1. All the 405GP stuff is missing from the non-development tree. (PCI, DMA,
all the OCP support such as Ethernet)
2. Compile errors in ppc4xx_pic.c, invalid relocation type messages. (This
is something that I can solve with a little time.)

What should I use to build a Walnut kernel?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
