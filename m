Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 548D5DDECB
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:14 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/22] ucc_geth: kill unused include
Date: Thu, 13 Sep 2007 16:07:39 -0500
Message-Id: <1189717681533-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11897176803590-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ucc_geth_mii code is based on the gianfar_mii code that use to include
ocp.h.  ucc never need this and it causes issues when we want to kill
arch/ppc includes from arch/powerpc.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/net/ucc_geth_mii.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ucc_geth_mii.c b/drivers/net/ucc_geth_mii.c
index 6c257b8..df884f0 100644
--- a/drivers/net/ucc_geth_mii.c
+++ b/drivers/net/ucc_geth_mii.c
@@ -32,7 +32,6 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <asm/ocp.h>
 #include <linux/crc32.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
-- 
1.5.2.4
