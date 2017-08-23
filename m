Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcr6z58rHzDqYb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:54:35 +1000 (AEST)
Message-Id: <cover.1503277387.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/4] powerpc/32: memset() optimisations
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 23 Aug 2017 16:54:30 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This serie provide small optimisation of memset() for PPC32.

Christophe Leroy (4):
  powerpc/32: add memset16()
  powerpc: fix location of two EXPORT_SYMBOL
  powerpc/32: optimise memset()
  powerpc/32: remove a NOP from memset()

 arch/powerpc/include/asm/string.h |  4 +++-
 arch/powerpc/kernel/setup_32.c    |  7 ++++++-
 arch/powerpc/lib/copy_32.S        | 44 ++++++++++++++++++++++++++++++---------
 arch/powerpc/mm/hash_low_32.S     |  2 +-
 4 files changed, 44 insertions(+), 13 deletions(-)

-- 
2.13.3
