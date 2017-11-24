Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjsQg2ZwtzDr1w
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 21:10:51 +1100 (AEDT)
From: Colin King <colin.king@canonical.com>
To: Li Yang <leoyang.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] USB: gadget: udc: fix spelling mistake "unexpect" ->
 "unexpected"
Date: Fri, 24 Nov 2017 10:10:44 +0000
Message-Id: <20171124101044.26554-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Trival fix to spelling mistake in ERR message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index d606d4f13098..e5b4ee96c4bf 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1543,7 +1543,7 @@ static void ep0_req_complete(struct fsl_udc *udc, struct fsl_ep *ep0,
 		udc->ep0_state = WAIT_FOR_SETUP;
 		break;
 	case WAIT_FOR_SETUP:
-		ERR("Unexpect ep0 packets\n");
+		ERR("Unexpected ep0 packets\n");
 		break;
 	default:
 		ep0stall(udc);
-- 
2.14.1
