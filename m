Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E90E92C0095
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 21:28:09 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 1 Feb 2013 15:55:51 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id BAF53394004E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 15:58:05 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r11AS4L018350104
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Feb 2013 15:58:04 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r11AS4T9023035
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Feb 2013 21:28:05 +1100
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] powerpc: select HAVE_CONTEXT_TRACKING for pSeries
Date: Fri,  1 Feb 2013 18:27:45 +0800
Message-Id: <1359714465-6297-6-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1359714465-6297-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1359714465-6297-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: Li Zhong <zhong@linux.vnet.ibm.com>, fweisbec@gmail.com, paulus@samba.org,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Start context tracking support from pSeries.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 837cf49..a9570fe 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -17,6 +17,7 @@ config PPC_PSERIES
 	select PPC_NATIVE
 	select PPC_PCI_CHOICE if EXPERT
 	select ZLIB_DEFLATE
+	select HAVE_CONTEXT_TRACKING
 	default y
 
 config PPC_SPLPAR
-- 
1.7.9.5
