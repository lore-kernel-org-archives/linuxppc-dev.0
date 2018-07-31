Return-Path: <acolin@isi.edu>
Received: from mail-d.ads.isi.edu (mail-d.ads.isi.edu [128.9.180.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fzP12ks6zF15Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 00:30:11 +1000 (AEST)
From: Alexei Colin <acolin@isi.edu>
To: Alexandre Bounine <alex.bou9@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>
Cc: Alexei Colin <acolin@isi.edu>, Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@armlinux.org.uk>, John Paul Walters <jwalters@isi.edu>,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/6] x86: factor out RapidIO Kconfig menu
Date: Tue, 31 Jul 2018 10:29:50 -0400
Message-Id: <20180731142954.30345-3-acolin@isi.edu>
In-Reply-To: <20180731142954.30345-1-acolin@isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The menu entry is now defined in the rapidio subtree.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mips@linux-mips.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexei Colin <acolin@isi.edu>
---
 arch/x86/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 27fce7e84357..6f057000e486 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2828,14 +2828,6 @@ config AMD_NB
 
 source "drivers/pcmcia/Kconfig"
 
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on PCI
-	default n
-	help
-	  If enabled this option will include drivers and the core
-	  infrastructure code to support RapidIO interconnect devices.
-
 source "drivers/rapidio/Kconfig"
 
 config X86_SYSFB
-- 
2.18.0
