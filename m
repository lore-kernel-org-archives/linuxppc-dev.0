Message-ID: <6DF87017DA95D611AC6000606730DE9B0BD764@BLREXSR>
From: Sanjeev Manral <sanjeevm@sanyo.co.in>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: pcmcia- config.opts, cis and pci
Date: Wed, 28 Aug 2002 15:30:14 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I'm using pcmcia-cs-3.2.0 my kernel is 2.4.17. It's a ppc405 board.

pcmcia-cs is not able to detect ide_cs card and telling it a Blank card.

I've tried many options in /etc/pcmcia/config.opts but nothing is working.

I'm having one more doubt. there is no PCI brige in manual of my hardware.
It is using coreconnect architecture and PCMCIA controller is directly
connected to processor local bus. In hardware there is not a single mention
of pci-plb bridge.

If I disable "pci" in "make xconfig" "card bus support" is also disabling
and there are no sockets.
shall I enable "pci" and "card bus support"( I'm trying this, IS IT
CORRECT?)

I debugged it with enable "pci" and "card bus support". driver is not able
to get a valid cis. and trying to load a blank card driver( memory_cs )
instead of ide_cs.

Is it a problem with only config.opts or some other problem.

I don't know where to proceed. if somebody knows how and where to get a
valid config.opts please let me know.

thanks,
Sanjeev


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
