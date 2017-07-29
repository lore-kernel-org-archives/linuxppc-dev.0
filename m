Return-Path: <lin.sunze@gmail.com>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xKHKz4mktzDrLv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 17:25:11 +1000 (AEST)
Received: by mail-pf0-f194.google.com with SMTP id e3so4685517pfc.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 00:25:11 -0700 (PDT)
From: SZ Lin <sz.lin@moxa.com>
To: ashleydlai@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterhuewe@gmx.de, tpmdd@selhorst.ne, jarkko.sakkinen@linux.intel.com,
 jgunthorpe@obsidianresearch.com, tpmdd-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 SZ Lin <sz.lin@moxa.com>
Subject: [PATCH 3/5] Fix 'void function return statements are not generally
 useful' warning
Date: Sat, 29 Jul 2017 15:24:31 +0800
Message-Id: <20170729072433.13194-4-sz.lin@moxa.com>
In-Reply-To: <20170729072433.13194-1-sz.lin@moxa.com>
References: <20170729072433.13194-1-sz.lin@moxa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

WARNING: void function return statements are not generally useful
+       return;
+}

Signed-off-by: SZ Lin <sz.lin@moxa.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 23913fc86158..e53b9fb517d9 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -531,7 +531,6 @@ static void ibmvtpm_crq_process(struct ibmvtpm_crq *crq,
 			return;
 		}
 	}
-	return;
 }
 
 /**
-- 
2.13.3
