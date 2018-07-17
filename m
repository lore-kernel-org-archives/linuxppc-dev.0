Return-Path: <krzk@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VR004WBLzF3HZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 02:42:24 +1000 (AEST)
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vitaly Bordug <vbordug@ru.mvista.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] MAINTAINERS: Drop inactive Vitaly Bordug's email
Date: Tue, 17 Jul 2018 18:41:54 +0200
Message-Id: <20180717164154.6577-1-krzk@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Vitaly Bordug's email bounces ("ru.mvista.com: Name or service not
known") and there was no activity (ack, review, sign) since 2009.

Cc: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fcefb7a19f58..c84c8085d5b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5850,7 +5850,6 @@ F:	include/linux/fsl/
 
 FREESCALE SOC FS_ENET DRIVER
 M:	Pantelis Antoniou <pantelis.antoniou@gmail.com>
-M:	Vitaly Bordug <vbordug@ru.mvista.com>
 L:	linuxppc-dev@lists.ozlabs.org
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.14.1
