Return-Path: <linville@tuxdriver.com>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E34126867C
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 Nov 2005 14:13:47 +1100 (EST)
Date: Sat, 5 Nov 2005 21:57:04 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20051106025701.GA9698@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 2.6.14] fec_8xx: make CONFIG_FEC_8XX depend on CONFIG_8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Make CONFIG_FEC_8XX depend on CONFIG_8xx.  This keeps allmodconfig from
breaking on non-8xx (PPC) platforms.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/fec_8xx/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/fec_8xx/Kconfig b/drivers/net/fec_8xx/Kconfig
index 4560026..a84c232 100644
--- a/drivers/net/fec_8xx/Kconfig
+++ b/drivers/net/fec_8xx/Kconfig
@@ -1,6 +1,6 @@
 config FEC_8XX
 	tristate "Motorola 8xx FEC driver"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && 8xx
 	select MII
 
 config FEC_8XX_GENERIC_PHY
-- 
John W. Linville
linville@tuxdriver.com
