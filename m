Return-Path: <baruch@tkos.co.il>
Received: from tango.tkos.co.il (tango.tkos.co.il [62.219.50.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A89C3B6FB1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jun 2011 15:43:11 +1000 (EST)
From: Baruch Siach <baruch@tkos.co.il>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] MAINTAINERS: add arch/powerpc/platforms/85xx/ to the 85xx
	entry
Date: Mon, 20 Jun 2011 08:00:22 +0300
Message-Id: <f05e0f3cb5925c980c1f3b764a2e70d999419937.1308545941.git.baruch@tkos.co.il>
Cc: Baruch Siach <baruch@tkos.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e50fc6e..8294613 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3904,6 +3904,7 @@ W:	http://www.penguinppc.org/
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	arch/powerpc/platforms/83xx/
+F:	arch/powerpc/platforms/85xx/
 
 LINUX FOR POWERPC PA SEMI PWRFICIENT
 M:	Olof Johansson <olof@lixom.net>
-- 
1.7.5.3
