Message-ID: <37A6EB76.F36F142E@eng.uct.ac.za>
Date: Tue, 03 Aug 1999 15:15:34 +0200
From: Grant Carter <gcarter@eng.uct.ac.za>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Please help: kernel won't compile
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

I have tried a couple of kernel versions but cannot seem to get any of
them to compile. I seem to always land up with similar errors namely
those below from my 2.2.10 kernel attempt:

make[1]: Entering directory
`/usr/home/gcarter/Linux-ppc/src/linux/arch/ppc/kernel'
powerpc-linux-gcc -D__KERNEL__
-I/usr/home/gcarter/Linux-ppc/src/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -DEXPORT_SYMTAB -c ppc_ksyms.c
ppc_ksyms.c:73: `isa_io_base' undeclared here (not in a function)
ppc_ksyms.c:73: initializer element for `__ksymtab_isa_io_base.value' is
not constant
ppc_ksyms.c:74: `isa_mem_base' undeclared here (not in a function)
ppc_ksyms.c:74: initializer element for `__ksymtab_isa_mem_base.value'
is not constant
ppc_ksyms.c:75: `pci_dram_offset' undeclared here (not in a function)
ppc_ksyms.c:75: initializer element for
`__ksymtab_pci_dram_offset.value' is not constant
make[1]: *** [ppc_ksyms.o] Error 1
make[1]: Leaving directory
`/usr/home/gcarter/Linux-ppc/src/linux/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2

Any suggestions??? I am trying to compile this for a Motorola MBX board.

Thanks in advance
Grant
-- 
Grant Carter                              gcarter@eng.uct.ac.za
Department of Electrical Engineering      University of Cape Town
Tel: +27 (0)21 650-3467                   Fax: +27 (0)21 650-3465
                     "Coffee not found - operator halted!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
