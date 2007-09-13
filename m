Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 321CFDDDFE
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 14:22:15 +1000 (EST)
In-Reply-To: <12648489.post@talk.nabble.com>
References: <12648489.post@talk.nabble.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <85940BCC-C5A7-4461-B49C-A5C1879708C3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
Date: Wed, 12 Sep 2007 23:25:10 -0500
To: sivaji <rameshmrm@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 12, 2007, at 11:18 PM, sivaji wrote:

>
> Hi,
>         I am try to boot the 2.6.23-rc3 kernel to my custom board  
> based on
> 8641D Processor. After uncompressing the kernel it was hang. I got the
> following messages.
>
>    Uncompressing Kernel Image ... OK
>    Booting using flat device tree at 0x600000.
>
>        Then i tried to debug with GDB. In my source path i given  
> the command
> ${CROSS_COMPILE}gdb vmlinux, I got GDB Prompt after i tried to set the
> breakpoint at start_kernel. I got follwing messages
>
> gdb) b start_kernel
> Cannot access memory at address 0xc02b44ec

how are you connecting gdb to the board?

do you have a JTAG debugger connected to the board?

- k
