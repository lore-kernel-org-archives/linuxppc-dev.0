Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07BB6DE28C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 00:47:42 +1000 (EST)
Date: Tue, 3 Jun 2008 09:47:19 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: [RFC] Make board force selection of PHYLIB
In-Reply-To: <48448020.5020407@freescale.com>
Message-ID: <Pine.LNX.4.64.0806030945540.21537@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0806021019540.22439@blarg.am.freescale.net>
	<484419EE.5040503@garzik.org>
	<1E4EB64C-0618-497E-AABC-74EB7D74B97F@kernel.crashing.org>
	<48442239.7090906@garzik.org>
	<BF15FEBB-4876-4B16-915B-1D21BF989DA8@kernel.crashing.org>
	<83820D83-487C-4586-9867-F4226A87A276@freescale.com>
	<48445851.4090105@garzik.org>
	<095F258F-72DD-4F27-A457-A57D9FAA1E76@kernel.crashing.org>
	<48448020.5020407@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: netdev@vger.kernel.org, adrian.bunk@movial.fi,
	Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

How is this as a fix.

- k

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 7ff29d5..9e5c884 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -34,6 +34,7 @@ config MPC85xx_MDS
 	bool "Freescale MPC85xx MDS"
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
+	select PHYLIB if GIANFAR=m
 	help
 	  This option enables support for the MPC85xx MDS board
