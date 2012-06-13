Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DAF41007F2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 04:24:57 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Wed, 13 Jun 2012 14:24:55 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A45776E8079
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 14:23:25 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5DINP9D139950
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 14:23:25 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5DINNqS032748
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 14:23:25 -0400
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] drivers: crypto: fix typo in nx driver config option
Date: Wed, 13 Jun 2012 13:22:43 -0500
Message-Id: <1339611763-14603-2-git-send-email-sjenning@linux.vnet.ibm.com>
In-Reply-To: <1339611763-14603-1-git-send-email-sjenning@linux.vnet.ibm.com>
References: <1339611763-14603-1-git-send-email-sjenning@linux.vnet.ibm.com>
Cc: Seth Jennings <sjenning@linux.vnet.ibm.com>, trivial@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-crypto@vger.kernel.org,
 Kent Yoder <key@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc: Kent Yoder <key@linux.vnet.ibm.com>
Signed-off-by: Seth Jennings <sjenning@linux.vnet.ibm.com>
---
 drivers/crypto/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 1092a77..b9b11a6 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -298,7 +298,7 @@ config CRYPTO_DEV_TEGRA_AES
 	  will be called tegra-aes.
 
 config CRYPTO_DEV_NX
-	tristate "Support for Power7+ in-Nest cryptographic accleration"
+	tristate "Support for Power7+ in-Nest cryptographic acceleration"
 	depends on PPC64 && IBMVIO
 	select CRYPTO_AES
 	select CRYPTO_CBC
-- 
1.7.9.5
