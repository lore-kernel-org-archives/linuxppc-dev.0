Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 9512CDDF3C
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 05:19:03 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/11] celleb_epci_ops: use named structure member initializers
Date: Thu,  9 Aug 2007 14:18:38 -0500
Message-Id: <11866871374084-git-send-email-ntl@pobox.com>
In-Reply-To: <11866871262306-git-send-email-ntl@pobox.com>
References: <11866871262306-git-send-email-ntl@pobox.com>
Cc: Paul Mackerras <paulus@samba.org>
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
 arch/powerpc/platforms/celleb/scc_epci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/celleb/scc_epci.c b/arch/powerpc/platforms/celleb/scc_epci.c
index c4b0110..7506acc 100644
--- a/arch/powerpc/platforms/celleb/scc_epci.c
+++ b/arch/powerpc/platforms/celleb/scc_epci.c
@@ -278,8 +278,8 @@ static int celleb_epci_write_config(struct pci_bus *bus,
 }
 
 struct pci_ops celleb_epci_ops = {
-	celleb_epci_read_config,
-	celleb_epci_write_config,
+	.read = celleb_epci_read_config,
+	.write = celleb_epci_write_config,
 };
 
 /* to be moved in FW */
-- 
1.5.2.4
