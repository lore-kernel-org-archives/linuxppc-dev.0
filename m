Return-Path: <tglx@linutronix.de>
Received: from mail.tglx.de (www.osadl.org [213.239.205.134])
	by ozlabs.org (Postfix) with ESMTP id 49162DDE36
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 02:52:58 +1000 (EST)
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: revert fix for threaded fasteoi
	IRQ handlers
From: Thomas Gleixner <tglx@linutronix.de>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <46965B28.7000703@ru.mvista.com>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<200705171719.34968.sshtylyov@ru.mvista.com>
	<46965B28.7000703@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 12 Jul 2007 18:52:53 +0200
Message-Id: <1184259173.12353.227.camel@chaos>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
	dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-07-12 at 20:47 +0400, Sergei Shtylyov wrote:
>     Now that the -rt patch has been first release in the broken-out version, 
> let me tell you that the following 3 patches in the series can be just 
> annihilated:
> 
> preempt-irqs-ppc-ack-irq-fixups.patch
> preempt-irqs-ppc-fix-b5.patch
> preempt-irqs-ppc-fix-more-fasteoi.patch
> 
> as all that the latter two are doing is undoing the former one.

Really ? I know for quite a while. 

We kept some of those files to document contributions. Go read back on
the LKML archives, where we were accused more than once not to keep
track of these things.

They can be folded together and fixed up, one thing after the other
please.

	tglx
