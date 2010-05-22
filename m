Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (mail.lixom.net [66.141.50.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5068AB7D29
	for <linuxppc-dev@ozlabs.org>; Sun, 23 May 2010 00:59:39 +1000 (EST)
Date: Sat, 22 May 2010 10:17:38 -0500
From: Olof Johansson <olof@lixom.net>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/pasemi: update maintainers file
Message-ID: <20100522151738.GA19504@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PWRficient platform work is definitely in maintenance mode these
days, update MAINTAINERS file to reflect reality.

Website is long gone as well.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/MAINTAINERS b/MAINTAINERS
index d329b05..78bb64d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3444,9 +3444,8 @@ F:	arch/powerpc/platforms/83xx/
 
 LINUX FOR POWERPC PA SEMI PWRFICIENT
 M:	Olof Johansson <olof@lixom.net>
-W:	http://www.pasemi.com/
 L:	linuxppc-dev@ozlabs.org
-S:	Supported
+S:	Maintained
 F:	arch/powerpc/platforms/pasemi/
 F:	drivers/*/*pasemi*
 F:	drivers/*/*/*pasemi*
