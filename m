Return-Path: <lin.sunze@gmail.com>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xKHKz4Y0kzDrLs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 17:25:11 +1000 (AEST)
Received: by mail-pg0-f68.google.com with SMTP id d193so25548876pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 00:25:11 -0700 (PDT)
From: SZ Lin <sz.lin@moxa.com>
To: ashleydlai@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterhuewe@gmx.de, tpmdd@selhorst.ne, jarkko.sakkinen@linux.intel.com,
 jgunthorpe@obsidianresearch.com, tpmdd-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 SZ Lin <sz.lin@moxa.com>
Subject: [PATCH 2/5] Fix "ERROR: code indent should use tabs where possible"
Date: Sat, 29 Jul 2017 15:24:30 +0800
Message-Id: <20170729072433.13194-3-sz.lin@moxa.com>
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

ERROR: code indent should use tabs where possible
+^I^I         "Need to wait for TPM to finish\n");$

Signed-off-by: SZ Lin <sz.lin@moxa.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index f01d083eced2..23913fc86158 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -127,7 +127,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 
 	if (ibmvtpm->tpm_processing_cmd) {
 		dev_info(ibmvtpm->dev,
-		         "Need to wait for TPM to finish\n");
+			"Need to wait for TPM to finish\n");
 		/* wait for previous command to finish */
 		sig = wait_event_interruptible(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
 		if (sig)
-- 
2.13.3
