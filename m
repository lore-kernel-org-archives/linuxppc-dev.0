Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE018.bigfish.com (ch1ehsobe001.messaging.microsoft.com
	[216.32.181.181]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 30F9DB6F8C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 May 2011 08:55:08 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <akpm@linux-foundation.org>,
	<linuxppc-dev@ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/misc: add Kbuild header file entry for Freescale
	hypervisor management driver
Date: Thu, 26 May 2011 17:55:01 -0500
Message-ID: <1306450501-29583-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fsl_hypervisor.h includes an ioctl interface, so it should be made available
via "make headers_install".

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This adds one change that I forgot to include in my previous patch,
"drivers/misc: introduce Freescale hypervisor management driver".

Kumar, if at all possible, please squash this patch into that one.

 include/linux/Kbuild |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/Kbuild b/include/linux/Kbuild
index 75cf611..68c341a 100644
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -134,6 +134,7 @@ header-y += firewire-cdev.h
 header-y += firewire-constants.h
 header-y += flat.h
 header-y += fs.h
+header-y += fsl_hypervisor.h
 header-y += fuse.h
 header-y += futex.h
 header-y += gameport.h
-- 
1.7.3.4
