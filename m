Date: Tue, 10 Aug 1999 10:17:04 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Andrew_Klosterman@3com.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: What is being setup in chrp_setup_pci_ptrs()?
In-Reply-To: <882567C9.000F1D9D.00@hqoutbound.ops.3com.com>
Message-ID: <Pine.LNX.4.10.9908101014350.32043-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 9 Aug 1999 Andrew_Klosterman@3com.com wrote:
>      In the function chrp_setup_pci_ptrs() at the end of the file
> /arch/ppc/kernel/chrp_pci.c there are three different variables that are
> initialized depending on the system being used:
>      pci_dram_offset,
>      isa_mem_base and
>      isa_io_base.
> 
>      Could someone please explain to me what the addresses these variables refer
> to mean, please?

  - pci_dram_offset: address at which system memory starts when viewed from a
                     PCI device. CPU and PCI may have a different view to RAM.
  - isa_mem_base: address where the ISA memory space is located (first 1 MB on
		  a PC)
  - isa_io_base: address where the ISA I/O space is located (65536 I/O ports on
		 a PC)

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
