Return-Path: <apw@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 18584679E0
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 05:44:15 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k71JiC1c019946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Aug 2006 15:44:12 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k71JiCgb262014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Aug 2006 13:44:12 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k71JiCGZ005019
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Aug 2006 13:44:12 -0600
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k71JiB9F004989
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Aug 2006 13:44:12 -0600
Received: from apw by kvasir.watson.ibm.com with local (Exim 4.52)
	id 1G809z-0006JA-Eh
	for linuxppc-dev@ozlabs.org; Tue, 01 Aug 2006 15:44:11 -0400
Date: Tue, 1 Aug 2006 15:44:11 -0400
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] turn on tigon3 support in maple_defconfig
Message-ID: <20060801194411.GA22933@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Amos Waterland <apw@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I think that most people who use maple_defconfig are doing so for a JS21,
so it might make sense to turn Tigon3 support on by default.  

Built and booted on a JS21.

Signed-off-by: Amos Waterland <apw@us.ibm.com>

---

 maple_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index 80a0db4..27b18ca 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -474,7 +474,7 @@ CONFIG_E1000=y
 # CONFIG_SKY2 is not set
 # CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
-# CONFIG_TIGON3 is not set
+CONFIG_TIGON3=y
 # CONFIG_BNX2 is not set
 # CONFIG_MV643XX_ETH is not set
 
