Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27121C282DD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 15:12:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CF320685
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 15:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CF320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pRkr07d0zDq9B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 01:12:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=canonical.com
 (client-ip=91.189.89.112; helo=youngberry.canonical.com;
 envelope-from=colin.king@canonical.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=canonical.com
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pRhl0PqVzDq9B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 01:10:31 +1000 (AEST)
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.76) (envelope-from <colin.king@canonical.com>)
 id 1hIx3p-0000OD-KM; Tue, 23 Apr 2019 15:10:17 +0000
From: Colin King <colin.king@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH][next] powerpc/mm: fix spelling mistake "Outisde" -> "Outside"
Date: Tue, 23 Apr 2019 16:10:17 +0100
Message-Id: <20190423151017.14429-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Colin Ian King <colin.king@canonical.com>

There are several identical spelling mistakes in warning messages,
fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/powerpc/mm/hash_utils_64.c  | 4 ++--
 arch/powerpc/mm/pgtable-hash64.c | 2 +-
 arch/powerpc/mm/pgtable-radix.c  | 6 +++---
 arch/powerpc/mm/pgtable_64.c     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f727197de713..6eb89643ce58 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -784,7 +784,7 @@ int hash__create_section_mapping(unsigned long start, unsigned long end, int nid
 	int rc;
 
 	if (end >= H_VMALLOC_START) {
-		pr_warn("Outisde the supported range\n");
+		pr_warn("Outside the supported range\n");
 		return -1;
 	}
 
@@ -932,7 +932,7 @@ static void __init htab_initialize(void)
 		    base, size, prot);
 
 		if ((base + size) >= H_VMALLOC_START) {
-			pr_warn("Outisde the supported range\n");
+			pr_warn("Outside the supported range\n");
 			continue;
 		}
 
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index d934de4e2b3a..097a3b3538b1 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -115,7 +115,7 @@ int __meminit hash__vmemmap_create_mapping(unsigned long start,
 	int rc;
 
 	if ((start + page_size) >= H_VMEMMAP_END) {
-		pr_warn("Outisde the supported range\n");
+		pr_warn("Outside the supported range\n");
 		return -1;
 	}
 
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index e6d5065b0bc8..fcb0169e2d32 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -341,7 +341,7 @@ void __init radix_init_pgtable(void)
 		 */
 
 		if ((reg->base + reg->size) >= RADIX_VMALLOC_START) {
-			pr_warn("Outisde the supported range\n");
+			pr_warn("Outside the supported range\n");
 			continue;
 		}
 
@@ -902,7 +902,7 @@ static void __meminit remove_pagetable(unsigned long start, unsigned long end)
 int __meminit radix__create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
 	if (end >= RADIX_VMALLOC_START) {
-		pr_warn("Outisde the supported range\n");
+		pr_warn("Outside the supported range\n");
 		return -1;
 	}
 
@@ -934,7 +934,7 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 	int ret;
 
 	if ((start + page_size) >= RADIX_VMEMMAP_END) {
-		pr_warn("Outisde the supported range\n");
+		pr_warn("Outside the supported range\n");
 		return -1;
 	}
 
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 72f58c076e26..95ad2a09501c 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -122,7 +122,7 @@ void __iomem *__ioremap_at(phys_addr_t pa, void *ea, unsigned long size, pgprot_
 		return NULL;
 
 	if ((ea + size) >= (void *)IOREMAP_END) {
-		pr_warn("Outisde the supported range\n");
+		pr_warn("Outside the supported range\n");
 		return NULL;
 	}
 
-- 
2.20.1

