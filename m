Message-ID: <B25E2E5A003CD311B61E00902778AF2A02BBD72A@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 405GP and external masters
Date: Mon, 9 Jul 2001 14:26:31 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I hope someone here has experience with the 405GP and external masters.
Regarding burst-capable External Bus Masters on the EBC on the 405GP ...

"Once an external master owns the peripheral interface it can read and write
all PLB- and OPB- addressable memory,
with the exception of devices controlled by the EBC."

If an external master initiates a burst write to an address in SDRAM, does
the the data go directly to SDRAM, or does it go to the cache instead?  I
would guess SDRAM since the 405 doesn't snoop.  Are there any other
restrictions on this type of transfer, other than the address being aligned
on a cache-line/burst boundary?  During the burst, is the PLB tied up for
longer than usual, since the burst is coming from a 50MHz bus onto a 200MHz
(PLB) bus, or does the EBC buffer this burst like the DMA controller does?

Thanks in advance.
Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
