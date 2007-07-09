Return-Path: <laurent.pinchart@technotrade.biz>
Received: from mailrelay001.isp.belgacom.be (mailrelay001.isp.belgacom.be
	[195.238.6.51]) by ozlabs.org (Postfix) with ESMTP id C9359DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jul 2007 22:58:24 +1000 (EST)
Received: from mail.technotrade.biz (localhost [127.0.0.1])
	by mail.technotrade.biz (Postfix) with ESMTP id 605152066
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jul 2007 14:58:21 +0200 (CEST)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by mail.technotrade.biz (Postfix) with ESMTP id 4F59E1DE8
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jul 2007 14:58:21 +0200 (CEST)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] [PPC]: Add linux/pagemap.h to arch/ppc/mm/tlb.c
Date: Mon, 9 Jul 2007 14:58:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707091458.19445.laurent.pinchart@technotrade.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

When compiled without swap support, arch/mm/tlb.c complains about missing
function declarations. This patch fixes the warnings.

Signed-off-by: Laurent Pinchart <laurent.pinchart@technotrade.biz>
---
 arch/ppc/mm/tlb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/mm/tlb.c b/arch/ppc/mm/tlb.c
index fa29740..4ff260b 100644
--- a/arch/ppc/mm/tlb.c
+++ b/arch/ppc/mm/tlb.c
@@ -27,6 +27,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 
-- 
1.5.0
