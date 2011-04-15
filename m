Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <473a29a46089f5a3f9ab30412a910ede3ad98264.1302856271.git.michael@ellerman.id.au>
In-Reply-To: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 04/15] powerpc/xics: xics.h relies on linux/interrupt.h
Date: Fri, 15 Apr 2011 18:31:58 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/xics.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index 146aad8..c4ed4c5 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -6,6 +6,8 @@
 #ifndef _XICS_H
 #define _XICS_H
 
+#include <linux/interrupt.h>
+
 #define XICS_IPI		2
 #define XICS_IRQ_SPURIOUS	0
 
-- 
1.7.1
