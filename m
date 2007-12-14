Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 464BDDE1E6
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 05:45:38 +1100 (EST)
Date: Fri, 14 Dec 2007 21:48:26 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] [POWERPC] booting-without-of: localbus should not include
	board name
Message-ID: <20071214184826.GA1654@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix documentation once and for ever, because I'm pretty tired of
repeating that I am merely following it. ;-)

http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048096.html

http://ozlabs.org/pipermail/linuxppc-dev/2007-November/046977.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-November/046979.html

http://ozlabs.org/pipermail/linuxppc-dev/2007-October/044411.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-October/044413.html

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index ee0209a..b3948fa 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2091,8 +2091,7 @@ platforms are moved over to use the flattened-device-tree model.
 
    Example:
 	localbus@f0010100 {
-		compatible = "fsl,mpc8272ads-localbus",
-		             "fsl,mpc8272-localbus",
+		compatible = "fsl,mpc8272-localbus",
 		             "fsl,pq2-localbus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-- 
1.5.2.2
