Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id BD41E1A051F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 20:06:50 +1000 (AEST)
Message-Id: <cover.1429694647.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/3] powerpc/8xx: Implementation of execute protection
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Wed, 22 Apr 2015 12:06:39 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset implements execute protection on the 8xx.
It also simplifies the handling of PAGE_USER and PAGE_RO,
and adds a small fix to the kernel pages definition.

This patchset goes on to of my previous patchset named
"[v5] powerpc8xx: Further optimisation of TLB handling"

Christophe Leroy (3):
  powerpc/8xx: mark _PAGE_SHARED all types of kernel pages
  powerpc/8xx: Handle PAGE_USER via APG bits
  powerpc/8xx: Implementation of PAGE_EXEC

 arch/powerpc/include/asm/cputable.h      |  2 +-
 arch/powerpc/include/asm/mmu-8xx.h       | 26 ++++++++++++++++++++++++++
 arch/powerpc/include/asm/pgtable-ppc32.h | 19 -------------------
 arch/powerpc/include/asm/pte-8xx.h       | 31 ++++++++++++++-----------------
 arch/powerpc/kernel/head_8xx.S           | 31 ++++++++++++++++++++-----------
 5 files changed, 61 insertions(+), 48 deletions(-)

-- 
2.1.0
