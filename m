From: Andrew_Klosterman@3com.com
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <882567C9.000F1D9D.00@hqoutbound.ops.3com.com>
Date: Mon, 9 Aug 1999 19:45:28 -0700
Subject: What is being setup in chrp_setup_pci_ptrs()?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>





Dear PCI Gurus,

     In the function chrp_setup_pci_ptrs() at the end of the file
/arch/ppc/kernel/chrp_pci.c there are three different variables that are
initialized depending on the system being used:
     pci_dram_offset,
     isa_mem_base and
     isa_io_base.

     Could someone please explain to me what the addresses these variables refer
to mean, please?

Many thanks,

--Andy



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
