From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ashish anand <ashisha@india.infogain.com>
Cc: <Hollis@india.infogain.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PReP and generic PCI resource assignment
Date: Wed, 8 Aug 2001 14:23:52 +0200
Message-Id: <20010808122352.14864@smtp.adsl.oleane.com>
In-Reply-To: <3B70D192.AAF239AB@india.infogain.com>
References: <3B70D192.AAF239AB@india.infogain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>if I remember correctly there should be some a board specific variable
>like pci_dram_offset
>it is zero for your case.
>0xc1000000 is a virtual address ..while pci bar should be programmed with
>bus address .
>your case bios is not apropiately updating the resource assignment with
>0xc0000000 , the kernel_base.

pci_dram_offset is the offset of system memory as seen by PCI devices,
what Hollis needs to look at is the pci_controller's pci_mem_offset.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
