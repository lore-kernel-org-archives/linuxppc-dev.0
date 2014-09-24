Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews10.kpnxchange.com (cpsmtpb-ews10.kpnxchange.com
 [213.75.39.15])
 by lists.ozlabs.org (Postfix) with ESMTP id D4EEE1A0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 18:06:24 +1000 (EST)
Message-ID: <1411545979.19525.5.camel@x220>
Subject: [PATCH] powerpc/8xx: Remove Kconfig symbol FADS
From: Paul Bolle <pebolle@tiscali.nl>
To: Vitaly Bordug <vitb@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Date: Wed, 24 Sep 2014 10:06:19 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 39eb56da2b53 ("pcmcia: Remove m8xx_pcmcia driver") removed the
only driver that used CONFIG_FADS. Setting the Kconfig symbol FADS is
pointless since that commit. Remove it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Done on top of next-20140923. Tested with "git grep" only.

Another cleanup might be to remove MPC8XXFADS (or "FADS") from the "8xx
Machine Type" choice. Is there any reason left to pick "FADS" as a
machine type?

 arch/powerpc/platforms/8xx/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 247fdea0c8be..831f2e718b06 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -1,6 +1,3 @@
-config FADS
-	bool
-
 config CPM1
 	bool
 	select CPM
@@ -13,7 +10,6 @@ choice
 
 config MPC8XXFADS
 	bool "FADS"
-	select FADS
 
 config MPC86XADS
 	bool "MPC86XADS"
-- 
1.9.3
