Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSck81K3ZzDvp2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 19:52:16 +1100 (AEDT)
Message-Id: <cover.1480408630.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/2] powerpc: hw_breakpoint for book3s/32 and 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 Nov 2016 09:52:11 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This serie provides HW breakpoints on 32 bits Book3S and 8xx

Tested on mpc8321
Tested on mpc885

Christophe Leroy (2):
  powerpc/32: Enable HW_BREAKPOINT on BOOK3S
  powerpc/8xx: Implement hw_breakpoint

 arch/powerpc/Kconfig                 |  2 +-
 arch/powerpc/include/asm/processor.h |  2 +-
 arch/powerpc/include/asm/reg_8xx.h   |  7 +++++++
 arch/powerpc/kernel/head_8xx.S       | 28 +++++++++++++++++++++++++++-
 arch/powerpc/kernel/hw_breakpoint.c  |  6 +++++-
 arch/powerpc/kernel/process.c        | 22 ++++++++++++++++++++++
 6 files changed, 63 insertions(+), 4 deletions(-)

-- 
2.10.1
