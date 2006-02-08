Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E746068A7D
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 14:19:50 +1100 (EST)
To: torvalds@osdl.org
Subject: [PATCH 23/29] bogus extern in low_i2c.c
Message-Id: <E1F6frv-0006Ds-5Y@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:47 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Date: 1138796714 -0500

extern in function definition is an odd thing..

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/powerpc/platforms/powermac/low_i2c.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

1d0bd717c86949e97a11855482b4a118029c10a9
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 535c802..87eb6bb 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1052,8 +1052,7 @@ struct pmac_i2c_bus *pmac_i2c_adapter_to
 }
 EXPORT_SYMBOL_GPL(pmac_i2c_adapter_to_bus);
 
-extern int pmac_i2c_match_adapter(struct device_node *dev,
-				  struct i2c_adapter *adapter)
+int pmac_i2c_match_adapter(struct device_node *dev, struct i2c_adapter *adapter)
 {
 	struct pmac_i2c_bus *bus = pmac_i2c_find_bus(dev);
 
-- 
0.99.9.GIT
