Content-Type: text/plain;
  charset="us-ascii"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: linuxppc-embedded@lists.linuxppc.org
Subject: pcmcia terminology
Date: Thu, 24 Apr 2003 22:50:40 -0500
MIME-Version: 1.0
Message-Id: <200304242350.40637.ppc339@vtnet.ca>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, I have another PCMCIA/CF question to ask of this list.

I have a PPC405gp-based device (similar to the Walnut) that has a CF
slot on the front that we'd like to get working. I did some looking
around in the archives and came across this:

	http://lists.linuxppc.org/linuxppc-embedded/200207/msg00124.html

I guess I too am tripping up a bit over the terminology. The hardware
spec for my device says the following:

	The intended mode for the device is "Common Memory Mode". The
	motherboard does not provide signals to the CF to operate in I/O or
	True IDE mode. There are two memory regions in the device's memory
	map for accessing the card's attribute and common memory.

Any idea if this is going to present a problem? Or is this how they
normally work (i.e. is this what Linux expects)?

I've read the SanDisk documentation and I think I understand that fairly
well. I've written a quick and dirty driver that can check the DCR and
GPIO registers to see if a card is inserted and dump out the contents
of some of the attribute memory.

I'm just not sure how it all fits together on the Linux side. How does
PCMCIA fit together with CF and how does that fit together with IDE?
(or is it ATA?). Does MTD play any part? And what ever happened to
filesystems?

Should I be looking at pccf_4xx.c? My understanding is that this might
be what I'm looking for... a "common memory mode" -only to I/O mode
translator??

Help with any of the above would be very much appreciated.

	Trevor

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
