From: gopi@india.tejasnetworks.com
Date: Tue, 29 Apr 2003 05:52:52 +0000 (GMT)
To: linuxppc-embedded@lists.linuxppc.org
Cc: anil@india.tejasnetworks.com
Subject: Error in compiling 2.4.18 kernel for PPC
Message-ID: <Pine.LNX.4.21.0304290542560.27871-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  We are trying to compile kernel 2.4.18 for ppc(&mbxboard) with
gcc(cross compiler version 2.95.2)

Compilation breaks with the following error.
-----------------------------------------------
In file included from /opt/hardhat/devkit/ppc/8xx/lib/gcc-lib/powerpc-hardhat-linux/2.95.2/../../../../powerpc-hardhat-linux/include/linux/mm.h:4,
                 from /opt/hardhat/devkit/ppc/8xx/lib/gcc-lib/powerpc-hardhat-linux/2.95.2/../../../../powerpc-hardhat-linux/include/asm/pgtable.h:7,
                 from head_8xx.S:33:
/opt/hardhat/devkit/ppc/8xx/lib/gcc-lib/powerpc-hardhat-linux/2.95.2/../../../../powerpc-hardhat-linux/include/linux/sched.h:30: warning: `CLONE_VM' redefined
ppc_defs.h:72: warning: this is the location of the previous definition
/opt/hardhat/devkit/ppc/8xx/lib/gcc-lib/powerpc-hardhat-linux/2.95.2/../../../../powerpc-hardhat-linux/include/asm/ptrace.h: Assembler messages:
/opt/hardhat/devkit/ppc/8xx/lib/gcc-lib/powerpc-hardhat-linux/2.95.2/../../../../powerpc-hardhat-linux/include/asm/ptrace.h:21: Error: Unrecognized opcode: `struct'
/opt/hardhat/devkit/ppc/8xx/lib/gcc-lib/powerpc-hardhat-linux/2.95.2/../../../../powerpc-hardhat-linux/include/asm/ptrace.h:22: Error: Unrecognized opcode: `unsigned'
/opt/hardhat/devkit/ppc/8xx/lib/gcc-lib/powerpc-hardhat-linux/2.95.2/../../../../powerpc-hardhat-linux/include/asm/ptrace.h:23: Error: Unrecognized opcode: `unsigned'
/opt/hardhat/devkit/ppc/8xx/lib/gcc-lib/powerpc-hardhat-linux/2.95.2/../../../../powerpc-hardhat-linux/include/asm/ptrace.h:24: Error: Unrecognized opcode: `unsigned'
/opt/hardhat/devkit/ppc/8xx/lib/gcc-lib/powerpc-hardhat-linux/2.95.2/../../../../powerpc-hardhat-linux/include/asm/ptrace.h:25: Error: Unrecognized opcode: `unsigned'
-----------------------------------------------

What could be the problem?

Also, are there any patches to be applied to get this working for 860T?

thanx in advance.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
