Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id E87BFDDF38
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 05:19:11 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/11] pa_pxp_ops: use named structure member initializers
Date: Thu,  9 Aug 2007 14:18:40 -0500
Message-Id: <1186687145968-git-send-email-ntl@pobox.com>
In-Reply-To: <11866871262306-git-send-email-ntl@pobox.com>
References: <11866871262306-git-send-email-ntl@pobox.com>
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>
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
 arch/powerpc/platforms/pasemi/pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index ab1f5f6..882b571 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -122,8 +122,8 @@ static int pa_pxp_write_config(struct pci_bus *bus, unsigned int devfn,
 }
 
 static struct pci_ops pa_pxp_ops = {
-	pa_pxp_read_config,
-	pa_pxp_write_config,
+	.read = pa_pxp_read_config,
+	.write = pa_pxp_write_config,
 };
 
 static void __init setup_pa_pxp(struct pci_controller *hose)
-- 
1.5.2.4
