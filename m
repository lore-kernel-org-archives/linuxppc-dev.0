Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
	[IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2A7AB6F9B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Oct 2011 23:30:59 +1100 (EST)
Message-Id: <20111005122122.553832402@linutronix.de>
Date: Wed, 05 Oct 2011 12:30:49 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [patch 0/4] powerpc: Mark various interrupts IRQF_NO_THREAD
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series marks the obvious interrupts IRQF_NO_THREAD to
prevent forced interrupt threading - no guarantee of completeness :)

The last patch enables the forced threading mechanism in the core
code, which in turn enables the "irqthreaded" commandline option.

Thanks,

	tglx
