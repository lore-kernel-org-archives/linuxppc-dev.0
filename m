Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF4F7680F2
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Sep 2005 11:47:10 +1000 (EST)
Date: Tue, 6 Sep 2005 01:44:23 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Message-ID: <20050906004423.GO5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: <viro@ftp.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] missed s/u32/pm_message_t/ in arch/ppc/syslib/ocp.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git5-mga/arch/ppc/syslib/ocp.c RC13-git5-ppc44x-pm/arch/ppc/syslib/ocp.c
--- RC13-git5-mga/arch/ppc/syslib/ocp.c	2005-08-28 23:09:40.000000000 -0400
+++ RC13-git5-ppc44x-pm/arch/ppc/syslib/ocp.c	2005-09-05 16:41:17.000000000 -0400
@@ -165,7 +165,7 @@
 }
 
 static int
-ocp_device_suspend(struct device *dev, u32 state)
+ocp_device_suspend(struct device *dev, pm_message_t state)
 {
 	struct ocp_device *ocp_dev = to_ocp_dev(dev);
 	struct ocp_driver *ocp_drv = to_ocp_drv(dev->driver);
