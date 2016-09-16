Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb5nr2Qw9zDsZy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:02:39 +1000 (AEST)
Message-Id: <cover.1474004638.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 0/3] Optimisation on 8xx prior to hugepage implementation
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 16 Sep 2016 08:42:02 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This serie is a prologue of hugepage implementation on the 8xx.
It some how optimises the DTLBMiss handler while allowing at the
same time to hook the hugepage handling that will be introduced in
a subsequent patch serie.

v1 of those patches was part of a serie identified
"powerpc/8xx: implementation of huge pages"

Christophe Leroy (3):
  powerpc/8xx: use r3 to scratch CR in ITLBmiss
  powerpc/8xx: Move additional DTLBMiss handlers out of exception area
  powerpc/8xx: make user addr DTLB miss the short path

 arch/powerpc/kernel/head_8xx.S | 134 +++++++++++++++++++----------------------
 1 file changed, 62 insertions(+), 72 deletions(-)

-- 
2.1.0
