Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMbtQ507dzDvhN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 15:57:02 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4] powerpc/64: Preparation for KVM support on POWER9
Date: Mon, 21 Nov 2016 15:56:50 +1100
Message-Id: <1479704214-29147-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series, based on the current powerpc next branch, adds
various things we need in arch/powerpc in order to support KVM on
POWER9.

Michael, could you put these in a topic branch that I can pull?

Paul.
---

 arch/powerpc/include/asm/mmu.h                 |  5 ++++
 arch/powerpc/include/asm/opal.h                |  3 +++
 arch/powerpc/include/asm/reg.h                 | 12 +++++++++
 arch/powerpc/mm/hash_utils_64.c                | 28 +++------------------
 arch/powerpc/mm/pgtable-radix.c                | 18 +++++---------
 arch/powerpc/mm/pgtable_64.c                   | 34 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  3 +++
 arch/powerpc/platforms/powernv/opal.c          |  2 ++
 8 files changed, 69 insertions(+), 36 deletions(-)
