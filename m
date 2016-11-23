Return-Path: <jerry.huang@nxp.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0063.outbound.protection.outlook.com [104.47.41.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNvK44c7FzDw6C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 18:36:08 +1100 (AEDT)
From: Changming Huang <jerry.huang@nxp.com>
To: <balbi@kernel.org>, <leoyang.li@nxp.com>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Changming
 Huang" <jerry.huang@nxp.com>, Suresh Gupta <suresh.gupta@nxp.com>
Subject: [PATCH] fsl/usb: Add FSL USB Gadget entry in platform device id table
Date: Wed, 23 Nov 2016 15:20:04 +0800
Message-ID: <1479885605-5529-1-git-send-email-jerry.huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add FSL USB Gadget entry in platform device id table

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
Signed-off-by: Suresh Gupta <suresh.gupta@nxp.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index aab5221..b24b1c9 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2671,6 +2671,8 @@ static int fsl_udc_otg_resume(struct device *dev)
 	}, {
 		.name = "imx-udc-mx51",
 	}, {
+		.name = "fsl-usb2-udc",
+	}, {
 		/* sentinel */
 	}
 };
-- 
1.7.9.5
