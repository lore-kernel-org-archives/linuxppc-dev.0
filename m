Message-ID: <005601bf87e6$32f88980$69f001dc@sjzhu.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linuxppc-dev@lists.linuxppc.org>, <linux-kernel@vger.rutgers.edu>
Subject: Kernel debug about Linux for PowerPC
Date: Tue, 7 Mar 2000 11:35:29 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I want to use the gdb to debug the kernel version 2.2.13 for my MPC860
board.
So I set the compiler configuration parameter CONFIG_KGDB = YES,
but when I re-compile the kernel, it complains that

arch/ppc/kernel/kernel.o(.text+0x68ac): undefined reference to
`getDebugChar'
arch/ppc/kernel/kernel.o(.text+0x6934): undefined reference to
`putDebugChar'

PROBLEM:
what's wrong? I find no define for function "getDebugChar" in arch/ppc
directory.

Any suggestion is appreciated!

BRs,
Shuangjun


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
