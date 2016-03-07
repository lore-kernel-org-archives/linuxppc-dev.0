Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0070.outbound.protection.outlook.com [65.55.169.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 29DF81A0367
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 13:38:18 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <robh+dt@kernel.org>
CC: <oss@buserror.net>, <leoyang.li@nxp.com>, <xiaobo.xie@nxp.com>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v4 8/8] QE-UART: modify of_device_id for qe-uart driver
Date: Mon, 7 Mar 2016 10:28:08 +0800
Message-ID: <1457317688-20330-8-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1457317688-20330-1-git-send-email-qiang.zhao@nxp.com>
References: <1457317688-20330-1-git-send-email-qiang.zhao@nxp.com>
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

Drop device type and modify compatible to SoC specific compatible.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 drivers/tty/serial/ucc_uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 1a7dc3c..ff6c1ab 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1475,8 +1475,7 @@ static int ucc_uart_remove(struct platform_device *ofdev)
 
 static const struct of_device_id ucc_uart_match[] = {
 	{
-		.type = "serial",
-		.compatible = "ucc_uart",
+		.compatible = "t1040-ucc-uart",
 	},
 	{},
 };
-- 
2.1.0.27.g96db324
