Content-Type: text/plain;
  charset="us-ascii"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: linuxppc-embedded@lists.linuxppc.org
Subject: address translation
Date: Wed, 14 May 2003 23:50:05 -0400
MIME-Version: 1.0
Message-Id: <200305142350.05555.ppc339@vtnet.ca>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I want to setup a mapping so that when anything tries to read/write the
16 bytes of 0x1f0 - 0x1ff the actual physical memory that gets accessed
is 0xf7000000 - 0xf700000f.

I can't figure out what I need to call to get this done.

ioremap() is the exact opposite of what I want, and remap_page_range()
comes very close but aligns everything to the page boundary (in other
words, after I do the mapping, accessing 0x1f0 gives me 0xf70001f0
instead of 0xf7000000). I also tried using io_block_mapping(), which I
use in my platform io setup routine, but the MMU crashed with one of
those '###A' thingies. :-)

any suggestions, please?

	Trevor

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
