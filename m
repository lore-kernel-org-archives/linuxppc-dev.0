Return-Path: <garyj@denx.de>
Received: from mout4.freenet.de (mout4.freenet.de [195.4.92.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 057C1DDE26
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 03:30:17 +1000 (EST)
Received: from [195.4.92.11] (helo=1.mx.freenet.de)
	by mout4.freenet.de with esmtpa (ID gary.jennejohn@freenet.de) (port
	25) (Exim 4.69 #19) id 1Jy9Bb-0003Fi-Je
	for linuxppc-dev@ozlabs.org; Mon, 19 May 2008 19:30:11 +0200
Received: from m95a5.m.pppool.de ([89.49.149.165]:37027
	helo=peedub.jennejohn.org)
	by 1.mx.freenet.de with esmtpa (ID gary.jennejohn@freenet.de) (port 25)
	(Exim 4.69 #12) id 1Jy9Bb-0007yE-AW
	for linuxppc-dev@ozlabs.org; Mon, 19 May 2008 19:30:11 +0200
Date: Mon, 19 May 2008 19:30:10 +0200
From: Gary Jennejohn <garyj@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Correct the size of reg in the spi@ entry to 7.
Message-ID: <20080519193010.56e61532@peedub.jennejohn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: gary.jennejohn@freenet.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 This is needed because there is a one byte gap between SR and CDM.

Signed-off-by: Gary Jennejohn <garyj@denx.de>
---
 arch/powerpc/boot/dts/yosemite.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/yosemite.dts b/arch/powerpc/boot/dts/yosemite.dts
index 0d6d332..26ab1f3 100644
--- a/arch/powerpc/boot/dts/yosemite.dts
+++ b/arch/powerpc/boot/dts/yosemite.dts
@@ -200,7 +200,7 @@
 
 			spi@ef600900 {
 				compatible = "amcc,spi-440ep";
-				reg = <ef600900 6>;
+				reg = <ef600900 7>;
 				interrupts = <8 4>;
 				interrupt-parent = <&UIC0>;
 			};
-- 
1.5.3.6

---
Gary Jennejohn
*********************************************************************
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
*********************************************************************
