Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4125967B8A
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 04:43:27 +1000 (EST)
Message-Id: <20060718173018.730288000@sipsolutions.net>>
References: <20060718172841.046446000@sipsolutions.net>>
Date: Tue, 18 Jul 2006 19:28:46 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] add MAINTAINERS entry for snd-aoa
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds me into the MAINTAINERS file for the AOA driver.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/MAINTAINERS	2006-07-18 13:39:52.543476868 +0200
+++ linux-2.6-fetch/MAINTAINERS	2006-07-18 13:57:27.843476868 +0200
@@ -292,6 +292,13 @@ L:	info-linux@geode.amd.com
 W:	http://www.amd.com/us-en/ConnectivitySolutions/TechnicalResources/0,,50_2334_2452_11363,00.html
 S:	Supported
 
+AOA (Apple Onboard Audio) ALSA DRIVER
+P:	Johannes Berg
+M:	johannes@sipsolutions.net
+L:	linuxppc-dev@ozlabs.org
+L:	alsa-devel@alsa-project.org
+S:	Maintained
+
 APM DRIVER
 P:	Stephen Rothwell
 M:	sfr@canb.auug.org.au

--
