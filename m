Message-Id: <200212200830.CAA05240@lists.linuxppc.org>
From: "=?GB2312?Q?=D3=DA=E6=BA?=" <yuj@mail.ndsc.com.cn>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: kgdb compile error
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 20 Dec 2002 16:35:6 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi!
  I want to debug the kernel with kgdb,so I build the kernel with CONFIG_KGDB.While there are something wrong with it.The error is listed below:
/////////
ppc_74xx-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o init/main.o init/version.o \
 --start-group \
 arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
  drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/macintosh/macintosh.o \
 net/network.o \
 /home/yujing/mykernel/kernel/lib/lib.a \
 --end-group \
 -o vmlinux
ppc_74xx-ld: Dwarf Error: Could not find abbrev number 106.
ppc_74xx-ld: Dwarf Error: Could not find abbrev number 97.
ppc_74xx-ld: Dwarf Error: Line offset (33554432) bigger than line size (223020).
ppc_74xx-ld: Dwarf Error: Could not find abbrev number 95.
ppc_74xx-ld: Dwarf Error: Could not find abbrev number 95.
ppc_74xx-ld: Dwarf Error: Could not find abbrev number 95.
ppc_74xx-ld: Dwarf Error: Could not find abbrev number 95.
ppc_74xx-ld: Dwarf Error: Could not find abbrev number 95.
ppc_74xx-ld: Dwarf Error: Could not find abbrev number 99.
arch/ppc/kernel/kernel.o: In function `_get_L2CR':
arch/ppc/kernel/entry.S(.text+0x89fc): undefined reference to
'getDebugChar'
arch/ppc/kernel/entry.S(.text+0x89fc): relocation truncated to fit: R_PPC_REL24 getDebugChar
arch/ppc/kernel/entry.S(.text+0x8a30): undefined reference to `getDebugChar'
arch/ppc/kernel/entry.S(.text+0x8a30): relocation truncated to fit: R_PPC_REL24 getDebugChar
arch/ppc/kernel/entry.S(.text+0x8a4c): undefined reference to `getDebugChar'
arch/ppc/kernel/entry.S(.text+0x8a4c): relocation truncated to fit: R_PPC_REL24 getDebugChar
arch/ppc/kernel/entry.S(.text+0x8a5c): undefined reference to `getDebugChar'
arch/ppc/kernel/entry.S(.text+0x8a5c): relocation truncated to fit: R_PPC_REL24 getDebugChar
arch/ppc/kernel/entry.S(.text+0x8a7c): undefined reference to `putDebugChar'
arch/ppc/kernel/entry.S(.text+0x8a7c): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/entry.S(.text+0x8a88): undefined reference to `putDebugChar'
arch/ppc/kernel/entry.S(.text+0x8a88): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/entry.S(.text+0x8aa0): undefined reference to `putDebugChar'
arch/ppc/kernel/entry.S(.text+0x8aa0): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/entry.S(.text+0x8aac): undefined reference to `putDebugChar'
arch/ppc/kernel/entry.S(.text+0x8aac): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/entry.S(.text+0x8b20): undefined reference to `putDebugChar'
arch/ppc/kernel/entry.S(.text+0x8b20): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/kernel.o(.text+0x8b3c):arch/ppc/kernel/entry.S: more undefined references to `putDebugChar' follow
arch/ppc/kernel/kernel.o: In function `_get_L2CR':
arch/ppc/kernel/entry.S(.text+0x8b3c): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/entry.S(.text+0x8b58): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/entry.S(.text+0x8b68): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/entry.S(.text+0x8b78): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/entry.S(.text+0x8b7c): undefined reference to `getDebugChar'
arch/ppc/kernel/entry.S(.text+0x8b7c): relocation truncated to fit: R_PPC_REL24 getDebugChar
arch/ppc/kernel/entry.S(.text+0x8df4): undefined reference to `kgdb_interruptible'
arch/ppc/kernel/entry.S(.text+0x8df4): relocation truncated to fit: R_PPC_REL24 kgdb_interruptible
arch/ppc/kernel/entry.S(.text+0x9388): undefined reference to `kgdb_interruptible'
arch/ppc/kernel/entry.S(.text+0x9388): relocation truncated to fit: R_PPC_REL24 kgdb_interruptible
make: *** [vmlinux] Error 1
 ///////
What's the problem?Wait for your help!
Thanks in advance!
                                                                         yujing
                                                                           yuj@mail.ndsc.com.cn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
