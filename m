Subject: Re: [PATCH] MPC85XX TSEC driver: support for intel phy
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1088505754.4834.28.camel@lucy.pep-kaufbeuren.de>
References: <1088505754.4834.28.camel@lucy.pep-kaufbeuren.de>
Content-Type: multipart/mixed; boundary="=-pHq/ui8ZrkDdXk6qv5np"
Message-Id: <1088506166.4834.31.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Tue, 29 Jun 2004 12:49:27 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-pHq/ui8ZrkDdXk6qv5np
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-06-29 at 12:42, Stefan Nickl wrote:
> I've added support for Intel-style PHYs to gianfar,
> which is the one attached to the FEC on our module.

Oops, forgot #defines in gianfar_phy.h

--
Stefan Nickl
Kontron Modular Computers


--=-pHq/ui8ZrkDdXk6qv5np
Content-Disposition: attachment; filename=gfar_lxt971_phy_h.patch
Content-Type: text/x-patch; name=gfar_lxt971_phy_h.patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

--- linuxppc-2.4/drivers/net/gianfar_phy.h	2004-05-18 14:29:35.000000000 +0200
+++ linuxppc-2.4_85xx/drivers/net/gianfar_phy.h	2004-06-29 10:10:38.000000000 +0200
@@ -127,6 +133,22 @@
 #define MIIM_DM9161_10BTCSR	0x12
 #define MIIM_DM9161_10BTCSR_INIT	0x7800

+/* LXT971 PHY Status Register #2 */
+#define MIIM_LXT971_SR2         0x11
+#define MIIM_LXT971_SR2_SPEED   0x4000
+#define MIIM_LXT971_SR2_DUPLEX  0x0200
+
+/* LXT971 PHY Interrupt Enable Register */
+#define MIIM_LXT971_IER         0x12
+#define MIIM_LXT971_IER_INIT    0x00f2
+#define MIIM_LXT971_IER_CLEAR   0x0000
+
+/* LXT971 PHY Interrupt Status Register */
+#define MIIM_LXT971_ISR         0x13

 #define MIIM_READ_COMMAND       0x00000001



--=-pHq/ui8ZrkDdXk6qv5np--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
