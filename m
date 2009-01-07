Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 22F6DDE725
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 11:28:54 +1100 (EST)
Date: Wed, 7 Jan 2009 11:28:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: cleanup from l64 to ll64 change: drivers/char
Message-Id: <20090107112848.913750fa.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Sonny Rao <sonnyrao@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a powerpc specific driver.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/bsr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index 977dfb1..f6094ae 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -103,7 +103,7 @@ static ssize_t
 bsr_len_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct bsr_dev *bsr_dev = dev_get_drvdata(dev);
-	return sprintf(buf, "%lu\n", bsr_dev->bsr_len);
+	return sprintf(buf, "%llu\n", bsr_dev->bsr_len);
 }
 
 static struct device_attribute bsr_dev_attrs[] = {
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
