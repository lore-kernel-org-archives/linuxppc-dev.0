Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2FA34B6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Mar 2011 10:25:30 +1100 (EST)
Subject: Re: Early kernel debugging
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Philipp Ittershagen <lists@gate-nine.de>
In-Reply-To: <4D8F7B55.2050806@gate-nine.de>
References: <201103250950.20423.dargaud@lpsc.in2p3.fr>
	<4D8F7B55.2050806@gate-nine.de>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Mar 2011 10:25:16 +1100
Message-ID: <1301268316.2402.489.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-03-27 at 20:00 +0200, Philipp Ittershagen wrote:
> On 03/25/2011 09:50 AM, Guillaume Dargaud wrote:
> > Hello all,
> > what can you do when the kernel you try to run stops before printing anything on the console ?
> 
> http://elinux.org/Kernel_Debugging_Tips#Debugging_early_boot_problems
> 
> Basically it means connecting a debugger to the running kernel (using
> XMD, for example) and then reading the printk log buffer, which contains
> the last lines printed.

It actually mostly depends on the platform. There's various powerpc
specific early debug mechanisms that are more/less robust/functional
depending on the CPU type, the platform, etc...

Look in udbg.c, there's a list of early debug hacks in there controlled
by various config options.

Cheers,
Ben.
