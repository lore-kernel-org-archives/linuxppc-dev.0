Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 28 Mar 2003 09:35:48 +0100
From: Toni Van Remortel <t.vanremortel@ha.be>
To: linuxppc-embedded@lists.linuxppc.org
Subject: IBM PPC 405GP kernel compile problem
Message-Id: <20030328093548.0597f71f.t.vanremortel@ha.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I'm using the cross-compiler from denx.de for PPC_4xx, and I patched a 2.4.15 kernel with the appropriate PPC-patch.
Now when I compile zImage, I get this error:

make[1]: Entering directory `/opt/linux_ppc/arch/ppc/kernel'
ppc-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I/opt/linux_ppc/include   -c -o head_
4xx.o head_4xx.S
head_4xx.S: Assembler messages:
head_4xx.S:111: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:112: Error: Unrecognized opcode: `tlbwe'
head_4xx.S:420: Error: Unrecognized opcode: `rfci'
make[1]: *** [head_4xx.o] Error 1
make[1]: Leaving directory `/opt/linux_ppc/arch/ppc/kernel'

I've found a 'solution' to this problem on this list, which tells me to use -Wa,-m405 as flag instead of -mcpu=403, but that doesn't change a thing.

So I wonder: doesn anybody know why this goes wrong? I don't think the compiler is wrong (comming from ELDK, downloaded on 18 march 2003), nor the kernel. Any ideas?

Thank you in advance,

Toni Van Remortel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
