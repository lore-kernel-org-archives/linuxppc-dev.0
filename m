Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29D6CDDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 07:20:56 +1000 (EST)
Received: from cpe-66-69-204-88.austin.res.rr.com ([66.69.204.88]
	helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1Hee3h-0000qr-9b
	for linuxppc-dev@ozlabs.org; Thu, 19 Apr 2007 16:20:53 -0500
Date: Thu, 19 Apr 2007 16:16:52 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC/PATCH] Change 440GP platform to ppc440
Message-ID: <Pine.LNX.4.64.0704191615040.25069@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I don't see any reason the 440GP should its own platform.  Posting this to
see if anyone thinks otherwise.

- k

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6b59e40..4237aea 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1119,7 +1119,7 @@ static struct cpu_spec cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.platform		= "ppc440gp",
+		.platform		= "ppc440",
 	},
 	{	/* 440GP Rev. C */
 		.pvr_mask		= 0xf0000fff,
@@ -1129,7 +1129,7 @@ static struct cpu_spec cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.platform		= "ppc440gp",
+		.platform		= "ppc440",
 	},
 	{ /* 440GX Rev. A */
 		.pvr_mask		= 0xf0000fff,
