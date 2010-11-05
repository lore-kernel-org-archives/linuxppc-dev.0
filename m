Return-Path: <B25806@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31BB11007D5
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Nov 2010 14:09:52 +1100 (EST)
Received: from mail11-am1 (localhost.localdomain [127.0.0.1])	by
	mail11-am1-R.bigfish.com (Postfix) with ESMTP id 786A3F30366	for
	<linuxppc-dev@ozlabs.org>; Fri,  5 Nov 2010 02:54:45 +0000 (UTC)
Received: from AM1EHSMHS011.bigfish.com (unknown [10.3.201.252])	by
	mail11-am1.bigfish.com (Postfix) with ESMTP id 51C8C2B0050	for
	<linuxppc-dev@ozlabs.org>; Fri,  5 Nov 2010 02:54:45 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id oA52sfdf010443	for <linuxppc-dev@ozlabs.org>;
	Thu, 4 Nov 2010 19:54:41 -0700 (MST)
Received: from zch01exm28.fsl.freescale.net (zch01exm28.ap.freescale.net
	[10.192.129.225])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id oA52serq004404	for <linuxppc-dev@ozlabs.org>;
	Thu, 4 Nov 2010 21:54:40 -0500 (CDT)
From: Lan Chunhe <b25806@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] powerpc/85xx: Update of_platform_bus_probe list to
	include PCI controller
Date: Fri, 5 Nov 2010 10:57:54 +0800
Message-ID: <1288925874-1260-1-git-send-email-b25806@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Lan Chunhe <b25806@freescale.com>, akpm@linux-foundation.org,
	"Kai.Jiang" <Kai.Jiang@freescale.com>, dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to get the pci controller created as an of platform device to
allow the EDAC driver to bind to it on P4080DS.

Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Lan Chunhe <b25806@freescale.com>
---
 arch/powerpc/platforms/85xx/corenet_ds.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index 2ab338c..bf9b9e5 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -116,6 +116,9 @@ static const struct of_device_id of_device_ids[] __devinitconst = {
 	{
 		.compatible	= "fsl,rapidio-delta",
 	},
+	{
+		.compatible	= "fsl,p4080-pcie",
+	},
 	{}
 };
 
-- 
1.5.4.5
