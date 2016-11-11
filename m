Return-Path: <geliangtang@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFfsf1rg8zDvHZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 23:50:46 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id n85so2516492pfi.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 04:50:46 -0800 (PST)
From: Geliang Tang <geliangtang@gmail.com>
To: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: nx - drop duplicate header types.h
Date: Fri, 11 Nov 2016 20:50:38 +0800
Message-Id: <3923d14d2f0129262f8088e1a1880718765fdce9.1478868492.git.geliangtang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop duplicate header types.h from nx.c.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/crypto/nx/nx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/nx/nx.c b/drivers/crypto/nx/nx.c
index 42f0f22..036057a 100644
--- a/drivers/crypto/nx/nx.c
+++ b/drivers/crypto/nx/nx.c
@@ -32,7 +32,6 @@
 #include <linux/scatterlist.h>
 #include <linux/device.h>
 #include <linux/of.h>
-#include <linux/types.h>
 #include <asm/hvcall.h>
 #include <asm/vio.h>
 
-- 
2.9.3
