From: wohlj7s0@elon.edu
Date: Thu, 17 Jun 1999 14:48:10 -0400 (EDT)
To: linuxppc-dev@lists.linuxppc.org
Subject: MBX board , PCI_DMA , virt_to_bus
Message-ID: <Pine.HPX.4.02.9906171441490.15756-100000@numen.elon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello!

I was wondering if anyone could help me with a little snag I am running
into.

Using a MBX board I have successfully started to get a driver to work with
a pci card that I am working with.  I figured out how to remap the cards
pci memory back down to virtual memory with ioremap(pci_base_addr+0xc0000000)
and have everything working, including interrupts with the exception of
the PCI dma transfers.  It seems that virt_to_bus on kmalloc'd memory will
not work on the MBX board where it will work fine on my x86 kernel module.
If anyone has any ideas I would greatly appreciate any advice.

Basically I am writing the address of some virtual memory into a register
on the card to hopefully get the DMA transfer to work, with no success.  

I have tried virt_to_bus, virt_to_phys, iopa, and have run out of ideas.

Thanks,
Jason Wohlgemuth


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
