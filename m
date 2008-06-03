Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EFBE2DE26F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 06:19:36 +1000 (EST)
Message-ID: <4845A756.6010407@scram.de>
Date: Tue, 03 Jun 2008 22:19:34 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] i2c: Add MAINTAINER entry for i2c-cpm.
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a6d2ca..bdfc7bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1659,6 +1659,13 @@ L:	linux-fbdev-devel@lists.sourceforge.net (moderated for non-subscribers)
 W:	http://linux-fbdev.sourceforge.net/
 S:	Maintained
 
+FREESCALE I2C CPM DRIVER
+P:	Jochen Friedrich
+M:	jochen@scram.de
+L:	linuxppc-dev@ozlabs.org
+L:	i2c@lm-sensors.org
+S:	Maintained
+
 FREESCALE DMA DRIVER
 P:	Li Yang
 M:	leoli@freescale.com
-- 
1.5.5.3
