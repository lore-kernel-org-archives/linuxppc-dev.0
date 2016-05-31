Return-Path: <k.kozlowski@samsung.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJwqj6XpqzDqbf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 00:29:53 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O81004W6P4XCL60@mailout2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 31 May 2016 15:19:45 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Tobias Klauser <tklauser@distanz.ch>,
 Russell King <linux@armlinux.org.uk>, Nicolas Ferre <nicolas.ferre@atmel.com>,
 Sonic Zhang <sonic.zhang@analog.com>,
 "Maciej W. Rozycki" <macro@linux-mips.org>, Vladimir Zapolskiy <vz@mleia.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>, Andy Gross <andy.gross@linaro.org>,
 David Brown <david.brown@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Barry Song <baohua@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Tony Prisk <linux@prisktech.co.nz>, Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 nios2-dev@lists.rocketboards.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFT PATCH 2/2] serial: pnx8xxx: Fix coding style
Date: Tue, 31 May 2016 16:19:32 +0200
Message-id: <1464704372-17668-2-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
References: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Definition of function should start from new line.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/tty/serial/pnx8xxx_uart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pnx8xxx_uart.c b/drivers/tty/serial/pnx8xxx_uart.c
index 84c4efdde8dc..9eaedd6a049e 100644
--- a/drivers/tty/serial/pnx8xxx_uart.c
+++ b/drivers/tty/serial/pnx8xxx_uart.c
@@ -690,7 +690,8 @@ static void pnx8xxx_console_putchar(struct uart_port *port, int ch)
 
 /*
  * Interrupts are disabled on entering
- */static void
+ */
+static void
 pnx8xxx_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct pnx8xxx_port *sport = &pnx8xxx_ports[co->index];
-- 
1.9.1
