Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 73179DDF2A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:46 +1000 (EST)
Message-Id: <20070705170233.671358000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:34 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 01/35] pasemi: rename platform
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rename the pasemi platform to "pasemi" to be in line with the platforms
directory name.

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: mainline/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- mainline.orig/arch/powerpc/platforms/pasemi/setup.c
+++ mainline/arch/powerpc/platforms/pasemi/setup.c
@@ -239,7 +239,7 @@ static int __init pas_probe(void)
 	return 1;
 }
 
-define_machine(pas) {
+define_machine(pasemi) {
 	.name			= "PA Semi PA6T-1682M",
 	.probe			= pas_probe,
 	.setup_arch		= pas_setup_arch,

--
