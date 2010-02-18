Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2FAD1B7CE7
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:31:45 +1100 (EST)
Message-Id: <20100218121904.620984825@linutronix.de>
Date: Thu, 18 Feb 2010 12:22:18 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 00/15] powerpc: raw_spinlock conversions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

the following patch series is from preempt-rt. It converts the locks
which need to be real spinlocks in -rt to raw_spinlocks.

There is no behaviourial change for !RT kernels because spinlocks and
raw_spinlocks are the same on !RT. So for mainline this is a pure
annotation while having it in mainline takes the burden of keeping up
with the code changes from the RT patch set.

Please consider to merge into .34.

Thanks,

	tglx
