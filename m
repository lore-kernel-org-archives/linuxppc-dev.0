Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E92C1B6F99
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2011 18:57:00 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] drivers/virt: add ioctl for 32-bit compat on 64-bit to
 fsl-hv-manager
Date: Fri, 14 Oct 2011 02:56:51 -0500
Message-Id: <1318579011-17124-1-git-send-email-galak@kernel.crashing.org>
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mihai Caraman <mihai.caraman@freescale.com>

Add ioctl to Freescale hypervisor management driver for 32-bit user-space
applications running on 64-bit guests.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
Acked-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/virt/fsl_hypervisor.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index 3d91621..4939e0c 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -706,6 +706,7 @@ static const struct file_operations fsl_hv_fops = {
 	.poll = fsl_hv_poll,
 	.read = fsl_hv_read,
 	.unlocked_ioctl = fsl_hv_ioctl,
+	.compat_ioctl = fsl_hv_ioctl,
 };
 
 static struct miscdevice fsl_hv_misc_dev = {
-- 
1.7.3.4
