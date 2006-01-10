Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A3C7E689E6
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 07:57:45 +1100 (EST)
Date: Tue, 10 Jan 2006 21:57:40 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Message-ID: <20060110205740.GA22091@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] enable the RTC driver in ppc64_defconfig
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Enable the RTC driver.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/configs/ppc64_defconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15-olh/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-2.6.15-olh.orig/arch/powerpc/configs/ppc64_defconfig
+++ linux-2.6.15-olh/arch/powerpc/configs/ppc64_defconfig
@@ -878,7 +878,7 @@ CONFIG_HVCS=m
 #
 # CONFIG_WATCHDOG is not set
 # CONFIG_RTC is not set
-# CONFIG_GEN_RTC is not set
+CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
