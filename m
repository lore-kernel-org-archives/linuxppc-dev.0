Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 97B0ADE029
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 05:19:34 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/11] tsi108_direct_pci_ops: use named structure member
	initializers
Date: Thu,  9 Aug 2007 14:18:46 -0500
Message-Id: <1186687168786-git-send-email-ntl@pobox.com>
In-Reply-To: <11866871262306-git-send-email-ntl@pobox.com>
References: <11866871262306-git-send-email-ntl@pobox.com>
Cc: Alexandre Bounine <alexandreb@tundra.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/sysdev/tsi108_pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 90db8a7..cf0bfbd 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -193,8 +193,8 @@ void tsi108_clear_pci_cfg_error(void)
 }
 
 static struct pci_ops tsi108_direct_pci_ops = {
-	tsi108_direct_read_config,
-	tsi108_direct_write_config
+	.read = tsi108_direct_read_config,
+	.write = tsi108_direct_write_config,
 };
 
 int __init tsi108_setup_pci(struct device_node *dev, u32 cfg_phys, int primary)
-- 
1.5.2.4
