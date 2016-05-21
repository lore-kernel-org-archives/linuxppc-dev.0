Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x244.google.com (mail-lb0-x244.google.com
 [IPv6:2a00:1450:4010:c04::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk7n5dpnzDqQB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:07:17 +1000 (AEST)
Received: by mail-lb0-x244.google.com with SMTP id u2so697945lbo.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:07:17 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, adam.buchbinder@gmail.com, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0234/1529] Fix typo
Date: Sat, 21 May 2016 14:07:10 +0200
Message-Id: <20160521120710.12195-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/powerpc/perf/hv-24x7.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.h b/arch/powerpc/perf/hv-24x7.h
index 791455e..634ef40 100644
--- a/arch/powerpc/perf/hv-24x7.h
+++ b/arch/powerpc/perf/hv-24x7.h
@@ -66,7 +66,7 @@ struct hv_24x7_result_element {
 	/* -1 if @performance_domain does not refer to a virtual processor */
 	__be32 lpar_cfg_instance_id;
 
-	/* size = @result_element_data_size of cointaining result. */
+	/* size = @result_element_data_size of containing result. */
 	__u64 element_data[1];
 } __packed;
 
-- 
2.8.2.534.g1f66975
