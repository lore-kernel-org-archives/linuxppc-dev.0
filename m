Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2EBEF2C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 03:42:04 +1000 (EST)
From: Mark Brown <broonie@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Date: Tue,  6 Aug 2013 18:41:52 +0100
Message-Id: <1375810912-20542-1-git-send-email-broonie@kernel.org>
Subject: [PATCH] powerpc: Ignore zImage.epapr
Cc: linuxppc-dev@lists.ozlabs.org, Mark Brown <broonie@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mark Brown <broonie@linaro.org>

This is another file we can generate so add it to the list.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/powerpc/boot/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index c32ae5c..554734f 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -22,6 +22,7 @@ zImage.initrd
 zImage.bin.*
 zImage.chrp
 zImage.coff
+zImage.epapr
 zImage.holly
 zImage.*lds
 zImage.miboot
-- 
1.8.4.rc1
