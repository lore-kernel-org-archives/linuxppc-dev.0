Return-Path: <tnt@246tNt.com>
Received: from outmx033.isp.belgacom.be (outmx033.isp.belgacom.be
	[195.238.6.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F062DDE46
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 01:39:12 +1000 (EST)
Received: from outmx033.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx033.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l46Fd7r4027613
	for <linuxppc-dev@ozlabs.org>; Sun, 6 May 2007 17:39:07 +0200
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/8] powerpc: Set efika's device_type to "soc"
Date: Sun,  6 May 2007 17:38:50 +0200
Message-Id: <11784659372712-git-send-email-tnt@246tNt.com>
In-Reply-To: <11784659371139-git-send-email-tnt@246tNt.com>
References: <11784659324066-git-send-email-tnt@246tNt.com>
	<11784659351487-git-send-email-tnt@246tNt.com>
	<1178465935138-git-send-email-tnt@246tNt.com>
	<11784659368-git-send-email-tnt@246tNt.com>
	<1178465936695-git-send-email-tnt@246tNt.com>
	<11784659371139-git-send-email-tnt@246tNt.com>
Cc: PPC dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>,
	Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Domen Puncer <domen.puncer@telargo.com>

Device type should be "soc" (as in lite5200.dts), compatible is
already set to "mpc5200".

Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/kernel/prom_init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index e27d9d1..87efb42 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2153,7 +2153,7 @@ static void __init fixup_device_tree_efika(void)
 	                             3,12,0, 3,13,0, 3,14,0, 3,15,0 };
 	struct subst_entry efika_subst_table[] = {
 		{ "/",			"device_type",	prop_cstr("efika") },
-		{ "/builtin",		"compatible",	prop_cstr("soc") },
+		{ "/builtin",		"device_type",	prop_cstr("soc") },
 		{ "/builtin/ata",	"compatible",	prop_cstr("mpc5200b-ata\0mpc5200-ata"), },
 		{ "/builtin/bestcomm",	"compatible",	prop_cstr("mpc5200b-bestcomm\0mpc5200-bestcomm") },
 		{ "/builtin/bestcomm",	"interrupts",	prop_bcomm_irq, sizeof(prop_bcomm_irq) },
-- 
1.5.1.2
