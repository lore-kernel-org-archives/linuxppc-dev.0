Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E04F92C02B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2013 06:54:53 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [RFC PATCH 0/6] KVM: PPC: Book3E: AltiVec support
Date: Mon, 3 Jun 2013 23:54:22 +0300
Message-ID: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mihai Caraman (6):
  KVM: PPC: Book3E: Fix AltiVec interrupt numbers and build breakage
  KVM: PPC: Book3E: Refactor SPE_FP exit handling
  KVM: PPC: Book3E: Rename IRQPRIO names to accommodate ALTIVEC
  KVM: PPC: Book3E: Add AltiVec support
  KVM: PPC: Book3E: Add ONE_REG AltiVec support
  KVM: PPC: Book3E: Enhance FPU laziness

 arch/powerpc/include/asm/kvm_asm.h    |   16 ++-
 arch/powerpc/kvm/booke.c              |  189 ++++++++++++++++++++++++++++----
 arch/powerpc/kvm/booke.h              |    4 +-
 arch/powerpc/kvm/bookehv_interrupts.S |    8 +-
 arch/powerpc/kvm/e500.c               |   10 +-
 arch/powerpc/kvm/e500_emulate.c       |    8 +-
 arch/powerpc/kvm/e500mc.c             |   10 ++-
 7 files changed, 199 insertions(+), 46 deletions(-)

-- 
1.7.4.1
