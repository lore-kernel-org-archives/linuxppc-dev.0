Message-ID: <3B797B40.DE0C75D7@cisco.com>
Date: Tue, 14 Aug 2001 12:25:53 -0700
From: Fabrizio Dellabernarda <fabrizio@cisco.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: problems with kgdb
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have a problem trying to compile Linux kernel for K2 750 PPC when
enabling the kgdb option to use kgdb. I see the following errors:

arch/ppc/kernel/kernel.o: In function `getpacket':
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:272:
undefined reference to `getDebugChar'
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:272:
relocation truncated to fit: R_PPC_REL24 getDebugChar
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:281:
undefined reference to `getDebugChar'
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:281:
relocation truncated to fit: R_PPC_REL24 getDebugChar
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:295:
undefined reference to `getDebugChar'
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:295:
relocation truncated to fit: R_PPC_REL24 getDebugChar
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:296:
undefined reference to `getDebugChar'
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:296:
relocation truncated to fit: R_PPC_REL24 getDebugChar
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:298:
undefined reference to `putDebugChar'
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:298:
relocation truncated to fit: R_PPC_REL24 putDebugChar
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:300:
undefined reference to `putDebugChar'
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:300:
relocation truncated to fit: R_PPC_REL24 putDebugChar
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:303:
undefined reference to `putDebugChar'
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:303:
relocation truncated to fit: R_PPC_REL24 putDebugChar
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:304:
undefined reference to `putDebugChar'
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:304:
relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/kernel.o: In function `putpacket':
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:324:
undefined reference to `putDebugChar'
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:324:
relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/kernel.o:/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:329:
more undefined references to `putDebugChar' follow
arch/ppc/kernel/kernel.o: In function `putpacket':
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:329:
relocation truncated to fit: R_PPC_REL24 putDebugChar
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:334:
relocation truncated to fit: R_PPC_REL24 putDebugChar
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:335:
relocation truncated to fit: R_PPC_REL24 putDebugChar
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:336:
relocation truncated to fit: R_PPC_REL24 putDebugChar
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:337:
undefined reference to `getDebugChar'
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:337:
relocation truncated to fit: R_PPC_REL24 getDebugChar
arch/ppc/kernel/kernel.o: In function `handle_exception':
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:495:
undefined reference to `kgdb_interruptible'
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:495:
relocation truncated to fit: R_PPC_REL24 kgdb_interruptible
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:685:
undefined reference to `kgdb_interruptible'
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:685:
relocation truncated to fit: R_PPC_REL24 kgdb_interruptible
make: *** [vmlinux] Error 1


Did anyone have same problem?
Any solution?
Thanks
Fabrizio


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
