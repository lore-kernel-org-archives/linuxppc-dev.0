Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0085.outbound.protection.outlook.com [157.56.110.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F374F1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 12:57:28 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <oss@buserror.net>
CC: <gregkh@linuxfoundation.org>, <leoyang.li@nxp.com>, <xiaobo.xie@nxp.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang
 <qiang.zhao@nxp.com>
Subject: [PATCH] QE-UART: add "fsl,t1040-ucc-uart" to of_device_id
Date: Wed, 9 Mar 2016 09:48:11 +0800
Message-ID: <1457488091-33619-1-git-send-email-qiang.zhao@nxp.com>
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

New bindings use "fsl,t1040-ucc-uart" as the compatible for qe-uart.
So add it.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 drivers/tty/serial/ucc_uart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 1a7dc3c..481eb29 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1478,6 +1478,9 @@ static const struct of_device_id ucc_uart_match[] = {
 		.type = "serial",
 		.compatible = "ucc_uart",
 	},
+	{
+		.compatible = "fsl,t1040-ucc-uart",
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ucc_uart_match);
-- 
2.1.0.27.g96db324
