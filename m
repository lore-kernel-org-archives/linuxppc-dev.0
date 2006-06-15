Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A03467B5E
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 21:23:34 +1000 (EST)
Date: Thu, 15 Jun 2006 12:23:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] m68k: windfarm is powerpc-only, don't do it on m68k macs
Message-ID: <20060615112329.GL27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/macintosh/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

c3d6ecc77e8e5d4ac82c3bf27ed02b8c0d83d41d
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 12ad462..ccf5df4 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -171,6 +171,7 @@ config THERM_PM72
 
 config WINDFARM
 	tristate "New PowerMac thermal control infrastructure"
+	depends on PPC
 
 config WINDFARM_PM81
 	tristate "Support for thermal management on iMac G5"
-- 
1.3.GIT
