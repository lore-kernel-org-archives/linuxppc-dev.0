Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E7A82C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 11:32:44 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH 0/2] enable the coreint for the mpc85xx 64bit boards 
Date: Thu, 11 Apr 2013 09:32:32 +0800
Message-ID: <1365643954-20798-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

With the rework of the lazy EE, it seems that 64bit kernel works pretty
well on mpc85xx 64bit boards with lazy EE enabled. So this patch series
tries to enable the coreint for these boards by default. This passed
the ltp test on a t4240qds board and is based on Kumar's next branch.

---
Kevin Hao (2):
  powerpc/irq: remove the unneeded flag PACA_IRQ_EE_EDGE
  powerpc/85xx: enable coreint for all the 64bit boards

 arch/powerpc/include/asm/hw_irq.h       | 1 -
 arch/powerpc/kernel/exceptions-64e.S    | 1 -
 arch/powerpc/kernel/irq.c               | 8 --------
 arch/powerpc/platforms/85xx/p5020_ds.c  | 5 -----
 arch/powerpc/platforms/85xx/p5040_ds.c  | 5 -----
 arch/powerpc/platforms/85xx/t4240_qds.c | 5 -----
 6 files changed, 25 deletions(-)

-- 
1.8.1.4

Thanks,
Kevin
