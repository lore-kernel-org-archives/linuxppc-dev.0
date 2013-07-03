Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 057602C04F7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 22:44:17 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 0/6] KVM: PPC: Book3E: AltiVec support
Date: Wed, 3 Jul 2013 15:42:33 +0300
Message-ID: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
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

Add KVM Book3E AltiVec support and enable e6500 core.

Mihai Caraman (6):
  KVM: PPC: Book3E: Use common defines for SPE/FP/AltiVec int numbers
  KVM: PPC: Book3E: Refactor SPE/FP exit handling
  KVM: PPC: Book3E: Increase FPU laziness
  KVM: PPC: Book3E: Add AltiVec support
  KVM: PPC: Book3E: Add ONE_REG AltiVec support
  KVM: PPC: Book3E: Enable e6500 core

 arch/powerpc/kvm/booke.c              |  211 +++++++++++++++++++++++++++------
 arch/powerpc/kvm/booke.h              |    5 +-
 arch/powerpc/kvm/bookehv_interrupts.S |    8 +-
 arch/powerpc/kvm/e500.c               |   10 +-
 arch/powerpc/kvm/e500_emulate.c       |    8 +-
 arch/powerpc/kvm/e500mc.c             |   12 ++-
 6 files changed, 201 insertions(+), 53 deletions(-)

-- 
1.7.3.4
