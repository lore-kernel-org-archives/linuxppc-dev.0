Message-ID: <37AFE5B4.A8599342@agelectronics.co.uk>
Date: Tue, 10 Aug 1999 09:41:24 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Andrew_Klosterman@3com.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: What is being setup in chrp_setup_pci_ptrs()?
References: <882567C9.000F1D9D.00@hqoutbound.ops.3com.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andrew_Klosterman@3com.com wrote:
>      In the function chrp_setup_pci_ptrs() at the end of the file
> /arch/ppc/kernel/chrp_pci.c there are three different variables that are
> initialized depending on the system being used:

>      pci_dram_offset,
The PCI address of physical memory address 0 (which should also be
kernel virtual address 0xc0000000). If physical memory does not start at
0, then things are a bit more complicated. 

>      isa_mem_base and
The kernel virtual address to which you have mapped ISA memory space.
You may need this for the ROMs on ISA cards.

>      isa_io_base.
The kernel virtual address to which you have mapped IO space. This is
used by insb and similar instructions.

For more details of these, read include/asm-ppc/io.h

- Adrian Cox, AG Electronics

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
