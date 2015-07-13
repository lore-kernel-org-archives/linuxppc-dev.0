Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 606351A027C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 06:50:15 +1000 (AEST)
Message-Id: <20150713135648.540293392@linutronix.de>
Date: Mon, 13 Jul 2015 20:50:00 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [patch 00/20] powerpc: Interrupt cleanups and API change preparation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patch series contains the following changes:

    - Consolidation of chained interrupt handler setup/removal

    - Switch to functions which avoid a redundant interrupt
      descriptor lookup

    - Preparation of interrupt flow handlers for the 'irq' argument
      removal

The series has no dependencies and is also available as a git branch
for your convenience:

 git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/arm

If you want me to carry the patches in the irq/core branch of tip,
please let me know.

Thanks,

	tglx
