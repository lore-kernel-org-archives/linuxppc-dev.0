Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DBBF2C0125
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 15:22:10 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 13 May 2013 15:13:55 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 82C5E2CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 15:22:07 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4D581wZ23003152
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 15:08:01 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4D5M6li014156
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 15:22:07 +1000
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 5/5] powerpc: select HAVE_CONTEXT_TRACKING for pSeries
Date: Mon, 13 May 2013 13:21:33 +0800
Message-Id: <1368422493-9831-6-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1368422493-9831-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1368422493-9831-1-git-send-email-zhong@linux.vnet.ibm.com>
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
index 9a0941b..023b288 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -18,6 +18,7 @@ config PPC_PSERIES
 	select PPC_PCI_CHOICE if EXPERT
 	select ZLIB_DEFLATE
 	select PPC_DOORBELL
+	select HAVE_CONTEXT_TRACKING
 	default y
 
 config PPC_SPLPAR
-- 
1.7.9.5
