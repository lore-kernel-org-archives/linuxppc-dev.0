Return-Path: <cascardo@holoscopio.com>
Received: from liberdade.minaslivre.org (liberdade.minaslivre.org
	[72.232.254.139]) by ozlabs.org (Postfix) with ESMTP id 73CAFB7CE0
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jan 2010 08:31:38 +1100 (EST)
From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
To: trivial@kernel.org
Subject: [PATCH] trivial: fix typo s/leve/level/ in powerpc arch
Date: Sun, 17 Jan 2010 19:23:14 -0200
Message-Id: <1263763394-9572-1-git-send-email-cascardo@holoscopio.com>
Cc: linuxppc-dev@ozlabs.org,
	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 arch/powerpc/mm/tlb_low_64e.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index f288279..8b04c54 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -1,5 +1,5 @@
 /*
- *  Low leve TLB miss handlers for Book3E
+ *  Low level TLB miss handlers for Book3E
  *
  *  Copyright (C) 2008-2009
  *      Ben. Herrenschmidt (benh@kernel.crashing.org), IBM Corp.
-- 
1.6.6
