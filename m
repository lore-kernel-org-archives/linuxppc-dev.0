Return-Path: <B02008@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A87B52C00FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:30:03 +1100 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 0/5] KVM: PPC: e500: Enable FSL e6500 core
Date: Wed, 30 Jan 2013 15:29:39 +0200
Message-ID: <1359552584-17861-1-git-send-email-mihai.caraman@freescale.com>
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

Enable Freescale e6500 core adding missing MAV 2.0 support. LRAT and Page
Table are not addresses by this commit.

Mihai Caraman (5):
  KVM: PPC: e500: Move VCPU's MMUCFG register initialization earlier
  KVM: PPC: e500: Emulate TLBnPS registers
  KVM: PPC: e500: Remove E.PT category from VCPUs
  KVM: PPC: e500: Emulate EPTCFG register
  KVM: PPC: e500mc: Enable e6500 cores

 arch/powerpc/include/asm/kvm_host.h |    2 ++
 arch/powerpc/kvm/e500.h             |   11 +++++++++++
 arch/powerpc/kvm/e500_emulate.c     |   19 +++++++++++++++++++
 arch/powerpc/kvm/e500_mmu.c         |   24 ++++++++++++++++++------
 arch/powerpc/kvm/e500mc.c           |    2 ++
 5 files changed, 52 insertions(+), 6 deletions(-)

-- 
1.7.4.1
