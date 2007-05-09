Return-Path: <bgill@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 81E57DDE01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 05:31:31 +1000 (EST)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Move reg_booke.h to include/asm-powerpc
Date: Wed,  9 May 2007 14:31:19 -0500
Message-Id: <11787390792190-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves reg_booke.h from include/asm-ppc to include/asm-powerpc.  This is
just a git-mv of the file; no changes were made.  Tested builds of 8540 ADS and
Ebony platforms with ARCH=ppc and ARCH=powerpc.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 include/{asm-ppc => asm-powerpc}/reg_booke.h |    0 
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename include/{asm-ppc => asm-powerpc}/reg_booke.h (100%)

diff --git a/include/asm-ppc/reg_booke.h b/include/asm-powerpc/reg_booke.h
similarity index 100%
rename from include/asm-ppc/reg_booke.h
rename to include/asm-powerpc/reg_booke.h
-- 
1.5.0.3
