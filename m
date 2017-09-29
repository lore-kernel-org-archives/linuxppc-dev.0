Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3JS71vC7zDsPN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 14:27:19 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u136so287949pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 21:27:19 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v4 2/5] powerpc/mce: align the print of physical address better
Date: Fri, 29 Sep 2017 14:26:52 +1000
Message-Id: <20170929042655.14570-3-bsingharora@gmail.com>
In-Reply-To: <20170929042655.14570-1-bsingharora@gmail.com>
References: <20170929042655.14570-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the same alignment as Effective address and rename
phyiscal address to Page Frame Number

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index e254399..fef1408 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -340,7 +340,7 @@ void machine_check_print_event_info(struct machine_check_event *evt,
 			printk("%s    Effective address: %016llx\n",
 			       level, evt->u.ue_error.effective_address);
 		if (evt->u.ue_error.physical_address_provided)
-			printk("%s      Physical address: %016llx\n",
+			printk("%s    Physical address:  %016llx\n",
 			       level, evt->u.ue_error.physical_address);
 		break;
 	case MCE_ERROR_TYPE_SLB:
-- 
2.9.5
