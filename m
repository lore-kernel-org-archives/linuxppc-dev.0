Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862FEC433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jun 2022 06:27:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXs2z1fpKz3dsM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jun 2022 16:27:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=nfschina.com (client-ip=2400:dd01:100f:2:72e2:84ff:fe10:5f45; helo=mail.nfschina.com; envelope-from=jiaming@nfschina.com; receiver=<UNKNOWN>)
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXs2X2J3Lz3bls
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2022 16:27:27 +1000 (AEST)
Received: from localhost (unknown [127.0.0.1])
	by mail.nfschina.com (Postfix) with ESMTP id 35BB01E80D59;
	Wed, 29 Jun 2022 14:26:13 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
	by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jbSZ3cCwngJl; Wed, 29 Jun 2022 14:26:10 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
	(Authenticated sender: jiaming@nfschina.com)
	by mail.nfschina.com (Postfix) with ESMTPA id F0ED51E80D50;
	Wed, 29 Jun 2022 14:26:09 +0800 (CST)
From: Zhang Jiaming <jiaming@nfschina.com>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org,
	paulus@samba.org
Subject: [PATCH] UAPI: fix a spelling mistake
Date: Wed, 29 Jun 2022 14:27:17 +0800
Message-Id: <20220629062717.23027-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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
Cc: liqiong@nfschina.com, renyu@nfschina.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Zhang Jiaming <jiaming@nfschina.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Change 'informations' to 'information'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 arch/powerpc/include/uapi/asm/bootx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/uapi/asm/bootx.h b/arch/powerpc/include/uapi/asm/bootx.h
index 6728c7e24e58..eb0769e50e93 100644
--- a/arch/powerpc/include/uapi/asm/bootx.h
+++ b/arch/powerpc/include/uapi/asm/bootx.h
@@ -60,7 +60,7 @@ typedef struct boot_info_map_entry
 } boot_info_map_entry_t;
 
 
-/* Here are the boot informations that are passed to the bootstrap
+/* Here are the boot information that are passed to the bootstrap
  * Note that the kernel arguments and the device tree are appended
  * at the end of this structure. */
 typedef struct boot_infos
-- 
2.34.1

