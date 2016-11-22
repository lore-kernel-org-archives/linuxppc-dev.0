Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNMq2220JzDvmd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 21:56:46 +1100 (AEDT)
Message-Id: <cover.1479742486.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 0/2] powerpc: stack protector (-fstack-protector) support
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Tue, 22 Nov 2016 11:49:28 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add HAVE_CC_STACKPROTECTOR to powerpc. This is copied from ARM.

Christophe Leroy (2):
  powerpc: initial stack protector (-fstack-protector) support
  powerpc/32: stack protector: change the canary value per task

 arch/powerpc/Kconfig                      |  1 +
 arch/powerpc/include/asm/stackprotector.h | 40 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile              |  4 ++++
 arch/powerpc/kernel/asm-offsets.c         |  3 +++
 arch/powerpc/kernel/entry_32.S            |  6 ++++-
 arch/powerpc/kernel/process.c             |  6 +++++
 6 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/stackprotector.h

-- 
2.10.1
