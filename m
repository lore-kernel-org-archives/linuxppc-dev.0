Message-ID: <3EF8A001.2090603@gmx.net>
Date: Tue, 24 Jun 2003 21:01:21 +0200
From: Oliver Amft <oam@gmx.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCI DMA memory problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am implementing a network driver for a DMA device on a custom
405GP/GPr based board. The networking device is attached over PCI bus.
Kernel is currently 2.4.21. BIOS is PPCBoot 1.2.0.

To map the data buffers from skb the driver uses pci_map_single(). When
starting the kernel with SDRAM size configurations other than 32MByte
the device is unable to transfer data (currupted data) - descriptor
dword read/write-back works (set up with pci_alloc_consistent()). For
the kernel start option mem=32MB everything is fine (descriptor +
correct data).

I am wondering if someone has stumbled over this too - any advice
appreciated.

Thanks,
Oliver


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
