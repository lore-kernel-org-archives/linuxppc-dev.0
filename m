Return-Path: <nix.or.die@googlemail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.184])
	by ozlabs.org (Postfix) with ESMTP id AC358DDDEB
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 19:41:30 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so162701mue
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Aug 2007 02:41:28 -0700 (PDT)
Message-ID: <46B05535.7000100@googlemail.com>
Date: Wed, 01 Aug 2007 11:41:09 +0200
From: Gabriel C <nix.or.die@googlemail.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] Typo fixes interrrupt -> interrupt ( try 2
 )
References: <46AFFB0B.102@googlemail.com>
	<20070801144318.f81fd988.sfr@canb.auug.org.au>
In-Reply-To: <20070801144318.f81fd988.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes some interrrupt -> interrupt typos

Signed-off-by: Gabriel Craciunescu <nix.or.die@googlemail.com>

---

 arch/powerpc/platforms/embedded6xx/holly.c        |    2 +-
 arch/powerpc/platforms/embedded6xx/linkstation.c  |    2 +-
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    2 +-
 arch/powerpc/platforms/iseries/it_lp_naca.h       |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 6292e36..fda16e8 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -147,7 +147,7 @@ static void __init holly_setup_arch(void)
 }
 
 /*
- * Interrupt setup and service.  Interrrupts on the holly come
+ * Interrupt setup and service.  Interrupts on the holly come
  * from the four external INT pins, PCI interrupts are routed via
  * PCI interrupt control registers, it generates internal IRQ23
  *
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index bd5ca58..8c60e02 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -99,7 +99,7 @@ static void __init linkstation_setup_arch(void)
 }
 
 /*
- * Interrupt setup and service.  Interrrupts on the linkstation come
+ * Interrupt setup and service.  Interrupts on the linkstation come
  * from the four PCI slots plus onboard 8241 devices: I2C, DUART.
  */
 static void __init linkstation_init_IRQ(void)
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index 1e3cc69..25c29bc 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -91,7 +91,7 @@ static void __init mpc7448_hpc2_setup_arch(void)
 }
 
 /*
- * Interrupt setup and service.  Interrrupts on the mpc7448_hpc2 come
+ * Interrupt setup and service.  Interrupts on the mpc7448_hpc2 come
  * from the four external INT pins, PCI interrupts are routed via
  * PCI interrupt control registers, it generates internal IRQ23
  *
diff --git a/arch/powerpc/platforms/iseries/it_lp_naca.h b/arch/powerpc/platforms/iseries/it_lp_naca.h
index 9bbf589..cf6dcf6 100644
--- a/arch/powerpc/platforms/iseries/it_lp_naca.h
+++ b/arch/powerpc/platforms/iseries/it_lp_naca.h
@@ -60,7 +60,7 @@ struct ItLpNaca {
 	u8	xRsvd2_0[128];		// Reserved			x00-x7F
 
 // CACHE_LINE_3-6 0x0100 - 0x02FF Contains LP Queue indicators
-// NB: Padding required to keep xInterrruptHdlr at x300 which is required
+// NB: Padding required to keep xInterruptHdlr at x300 which is required
 // for v4r4 PLIC.
 	u8	xOldLpQueue[128];	// LP Queue needed for v4r4	100-17F
 	u8	xRsvd3_0[384];		// Reserved			180-2FF
