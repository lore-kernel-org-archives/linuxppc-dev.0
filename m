Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id DCAE81A2AC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:18:56 +1000 (AEST)
Message-Id: <cover.1432047904.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 0/2] Optimise some IP checksum functions.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Tue, 19 May 2015 17:18:53 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset provides a few optimisations related to IP checksum functions.

Christophe Leroy (2):
  powerpc: put csum_tcpudp_magic inline
  powerpc: add support for csum_add()

 arch/powerpc/include/asm/checksum.h | 37 ++++++++++++++++++++++++++++---------
 arch/powerpc/lib/checksum_32.S      | 16 ----------------
 arch/powerpc/lib/checksum_64.S      | 21 ---------------------
 3 files changed, 28 insertions(+), 46 deletions(-)

-- 
2.1.0
