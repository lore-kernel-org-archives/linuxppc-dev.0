Date: Fri, 17 Jan 2003 20:23:59 +0100
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PrPMC800] Allocating DMA-able memory with scarce PCI resources
From: Anders Blomdell <anders.blomdell@control.lth.se>
To: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Message-Id: <3A721C65-2A51-11D7-98E2-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

My PrPMC800's are to be run in as slaves in a PCI-system, where they will
only be alloted a limited amount of PCI-space each (< 1MB), how do I do to
make allocation of datastructures that should be accessible from the
outside (e.g ethernet controllers) fall within a memory area that is
accessible from the PCI bus?

I guess that it has something to do with page_alloc and zones, but I have
[not yet] found out where zones gets initialized...

Regards

Anders Blomdell

------------------------------------------------------------------------------
  Anders Blomdell
  Department of Automatic Control        Email: anders.blomdell@control.lth.
se
  Lund Institute of Technology           Phone: +46 46 222 4625
  Box 118, S-221 00 Lund, Sweden         Fax:   +46 46 138118


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
