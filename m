Return-Path: <mporter@kernel.crashing.org>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id 9C598679F9
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 09:52:27 +1000 (EST)
In-Reply-To: <11181019442715@foobar.com>
Date: Mon, 6 Jun 2005 16:52:24 -0700
Message-Id: <11181019442621@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: akpm@osdl.org
From: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][RIO] -mm: ppc32 EXPORT_SYMBOL_GPL conversions
Reply-To: Matt Porter <mporter@kernel.crashing.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Convert PPC32/MPC85xx EXPORT_SYMBOL->EXPORT_SYMBOL_GPL.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

commit 113049d95f681dcb7317d7c641cc180634b35a1d
tree fe55ba09ede44aac1dfb0c416143ea3b4a8ca9a2
parent 7127e712a4aac828daecd47be8a0d15b3977a5e0
author Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 10:26:57 =
-0700
committer Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 10:26:=
57 -0700

 arch/ppc/syslib/ppc85xx_rio.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/syslib/ppc85xx_rio.c b/arch/ppc/syslib/ppc85xx_rio.c
--- a/arch/ppc/syslib/ppc85xx_rio.c
+++ b/arch/ppc/syslib/ppc85xx_rio.c
@@ -341,7 +341,7 @@ rio_hw_add_outb_message(struct rio_mport
 	return ret;
 }
=20
-EXPORT_SYMBOL(rio_hw_add_outb_message);
+EXPORT_SYMBOL_GPL(rio_hw_add_outb_message);
=20
 /**
  * mpc85xx_rio_tx_handler - MPC85xx outbound message interrupt handler
@@ -637,7 +637,7 @@ int rio_hw_add_inb_buffer(struct rio_mpo
 	return rc;
 }
=20
-EXPORT_SYMBOL(rio_hw_add_inb_buffer);
+EXPORT_SYMBOL_GPL(rio_hw_add_inb_buffer);
=20
 /**
  * rio_hw_get_inb_message - Fetch inbound message from the MPC85xx message=
 unit
@@ -684,7 +684,7 @@ void *rio_hw_get_inb_message(struct rio_
 	return buf;
 }
=20
-EXPORT_SYMBOL(rio_hw_get_inb_message);
+EXPORT_SYMBOL_GPL(rio_hw_get_inb_message);
=20
 /**
  * mpc85xx_rio_dbell_handler - MPC85xx doorbell interrupt handler
