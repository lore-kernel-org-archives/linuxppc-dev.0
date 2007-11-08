Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F984DDE1E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 10:20:30 +1100 (EST)
Subject: Re: Kernel locks up after calling kernel_execve()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20071108214723.135260@gmx.net>
References: <20071108214723.135260@gmx.net>
Content-Type: text/plain
Date: Fri, 09 Nov 2007 10:20:17 +1100
Message-Id: <1194564017.6561.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-11-08 at 22:47 +0100, Gerhard Pircher wrote:
> Hi,
> 
> I tested my patches for the AmigaOne platform with the lastest 2.6.24-rc2
> kernel snapshot. The kernel runs through all initcalls, but locks up
> completely after calling INIT (/sbin/init) by kernel_execve(). Thus I
> couldn't capture any kernel oops or panic output. Also the magic sysrq
> key doesn't work. Enabling debug code for soft lockups and spinlock
> debugging didn't reveal any information.
> I'm not sure, but I think it is the same problem I had with all kernels
> >= 2.6.17. All of these kernels lock up shortly before or right at calling
> the init program (resp. as soon as the kernel forks some kernel theads).
> Any suggestions on how to track down this problem?

You don't have a HW debugger or anything like that ?

Ben.
