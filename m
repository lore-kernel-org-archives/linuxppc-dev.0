Message-ID: <3B7C0B57.4EBE47FF@cisco.com>
Date: Thu, 16 Aug 2001 11:05:12 -0700
From: Fabrizio Dellabernarda <fabrizio@cisco.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: still problems with kgdb
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

sorry to bother anybody again with same subject but I'm debugging some
drivers under Hard Hat Linux for PPC and I can't enable the kgdb to use
it. I tryed to compile the kernel (for K2 750 PPC) after enabling the
kgdb option (using make xconfig) but I have compilation errors:

arch/ppc/kernel/kernel.o: In function `getpacket':
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:272:
undefined reference to `getDebugChar'
elocation truncated to fit: R_PPC_REL24 kgdb_interruptible
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:685:
undefined reference to `kgdb_interruptible'
/opt/hardhat/devkit/lsp/k2/linux-2.2.14/arch/ppc/kernel/ppc-stub.c:685:
relocation truncated to fit: R_PPC_REL24 kgdb_interruptible
make: *** [vmlinux] Error 1


Did anybody have the same problem?
Thanks
Fabrizio


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
