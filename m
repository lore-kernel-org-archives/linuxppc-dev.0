Return-Path: <tnt@246tNt.com>
Received: from outmx007.isp.belgacom.be (outmx007.isp.belgacom.be
	[195.238.5.234])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED489689CF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 07:41:15 +1100 (EST)
Received: from outmx007.isp.belgacom.be (localhost [127.0.0.1])
	by outmx007.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id jBKKf08U001347
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Dec 2005 21:41:03 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <2.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
In-Reply-To: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
References: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
Date: Tue, 20 Dec 2005 21:41:02 +0100 (CET)
Cc: Tom Rini <trini@kernel.crashing.org>, Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2/9] ppc32/serial: Fix compiler errors with GCC 4.x in
	mpc52xx_uart.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32/serial: Fix compiler errors with GCC 4.x in mpc52xx_uart.c

Signed-off-by: Wolfgang Denk <wd@denx.de>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

---
commit c83b03a94291bdd952c6b1b20ab15981456e8625
tree 81e1121a440a4624a4cd7f112fe44fca438ee140
parent 144f9d12ec7d04b38f83a131c4e544f78d2d47b2
author Sylvain Munaut <tnt@246tNt.com> Sat, 17 Dec 2005 23:12:39 +0100
committer Sylvain Munaut <tnt@246tNt.com> Sat, 17 Dec 2005 23:12:39 +0100

 drivers/serial/mpc52xx_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index b8727d9..4dcf031 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -668,7 +668,7 @@ mpc52xx_console_setup(struct console *co
 }
 
 
-extern struct uart_driver mpc52xx_uart_driver;
+static struct uart_driver mpc52xx_uart_driver;
 
 static struct console mpc52xx_console = {
 	.name	= "ttyS",
