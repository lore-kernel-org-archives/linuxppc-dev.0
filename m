Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4BCDDDDE3E
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 04:01:35 +1000 (EST)
Date: Tue, 24 Apr 2007 13:01:34 -0500
To: paulus@samba.org
Subject: [PATCH] pasemi: remove build warning
Message-ID: <20070424180134.GB7985@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/platforms/pasemi/setup.c: In function 'pasemi_publish_devices':
arch/powerpc/platforms/pasemi/setup.c:220: warning: implicit declaration of function 'of_platform_bus_probe'

Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 9944ffc..a7bf88e 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -35,6 +35,7 @@
 #include <asm/mpic.h>
 #include <asm/smp.h>
 #include <asm/time.h>
+#include <asm/of_platform.h>
 
 #include "pasemi.h"
 
