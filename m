Message-ID: <38C4D42A.1D0C19B3@fadata.bg>
Date: Tue, 07 Mar 2000 11:04:26 +0100
From: Momchil Velikov <velco@fadata.bg>
MIME-Version: 1.0
To: Shuangjun Zhu <r44089@email.sps.mot.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linuxppc-dev@lists.linuxppc.org,
        linux-kernel@vger.rutgers.edu
Subject: Re: Kernel debug about Linux for PowerPC
References: <005601bf87e6$32f88980$69f001dc@sjzhu.sps.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Shuangjun Zhu wrote:
>
> Hello,
>
> I want to use the gdb to debug the kernel version 2.2.13 for my MPC860
> board.
> So I set the compiler configuration parameter CONFIG_KGDB = YES,
> but when I re-compile the kernel, it complains that
>
> arch/ppc/kernel/kernel.o(.text+0x68ac): undefined reference to
> `getDebugChar'
> arch/ppc/kernel/kernel.o(.text+0x6934): undefined reference to
> `putDebugChar'
>
> PROBLEM:
> what's wrong? I find no define for function "getDebugChar" in arch/ppc
> directory.

You have to write these functions yourself. The stub uses them to
communicate with the debugger through whatever device is available on
the board. See 'Targets' -> 'Remote' -> 'Remote Serial' in GDB docs.

Regards,
-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
