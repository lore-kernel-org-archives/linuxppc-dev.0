Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 89D661A0C70
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 22:39:34 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, scottwood@freescale.com
Subject: [PATCH v2 0/2] powerpc32: Optimise some IP checksum functions.
Message-Id: <20150203113927.1DCAD1A5F12@localhost.localdomain>
Date: Tue,  3 Feb 2015 12:39:27 +0100 (CET)
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

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/include/asm/checksum.h | 28 ++++++++++++++++++++++++++++
 arch/powerpc/lib/checksum_32.S      | 16 ----------------
 2 files changed, 28 insertions(+), 16 deletions(-)
