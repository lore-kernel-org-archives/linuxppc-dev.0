Return-Path: <lists@gate-nine.de>
Received: from csmtp3.one.com (csmtp3.one.com [91.198.169.23])
	by ozlabs.org (Postfix) with ESMTP id 8C87FB6FAD
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Mar 2011 05:07:19 +1100 (EST)
Message-ID: <4D8F7B55.2050806@gate-nine.de>
Date: Sun, 27 Mar 2011 20:00:53 +0200
From: Philipp Ittershagen <lists@gate-nine.de>
MIME-Version: 1.0
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Early kernel debugging
References: <201103250950.20423.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201103250950.20423.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/25/2011 09:50 AM, Guillaume Dargaud wrote:
> Hello all,
> what can you do when the kernel you try to run stops before printing anything on the console ?

http://elinux.org/Kernel_Debugging_Tips#Debugging_early_boot_problems

Basically it means connecting a debugger to the running kernel (using
XMD, for example) and then reading the printk log buffer, which contains
the last lines printed.

Hope this helps!


Philipp
