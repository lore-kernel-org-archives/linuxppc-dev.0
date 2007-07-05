Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B37E3DDF1A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 00:38:19 +1000 (EST)
Date: Thu, 5 Jul 2007 09:49:04 -0500
To: paulus@samba.org
Subject: [PATCH] [2.6.23] pasemi: rename platform
Message-ID: <20070705144904.GA14605@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
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
