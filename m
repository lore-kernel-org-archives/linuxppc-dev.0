Return-Path: <sr@denx.de>
Received: from natnoddy.rzone.de (natnoddy.rzone.de [81.169.145.166])
	by ozlabs.org (Postfix) with ESMTP id 9593068604
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Oct 2005 20:29:27 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 31 Oct 2005 11:29:13 +0200
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<200509301452.52074.sr@denx.de> <200510281758.56646.sr@denx.de>
In-Reply-To: <200510281758.56646.sr@denx.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pPeZDZMewEMK+25"
Message-Id: <200510311029.13432.sr@denx.de>
Subject: [PATCH] ppc32: Add missing initrd header on ppc440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_pPeZDZMewEMK+25
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry, but this missing header slipped though last time. Please apply.

Signed-off-by: Stefan Roese <sr@denx.de>

By the way: What is the current status of the pending 4xx patches. Are they 
going in in this 2-week merge window?

Best regards,
Stefan

--Boundary-00=_pPeZDZMewEMK+25
Content-Type: text/x-diff; charset="iso-8859-6";
	name="ppc440-initrd-header-added.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ppc440-initrd-header-added.patch"

[PATCH] ppc32: Add missing initrd header on ppc440

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit 54069303584813d4f0bafcd04bb2b7b0e9fc4693
tree 319e03ffc9097b7a8376b6e3108b4249f6d6dc0d
parent d8832f2614a9bfdb445a62a23e80f01886ae661e
author Stefan Roese <sr@denx.de> Mon, 31 Oct 2005 10:20:52 +0100
committer Stefan Roese <sr@denx.de> Mon, 31 Oct 2005 10:20:52 +0100

 arch/ppc/syslib/ibm44x_common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/syslib/ibm44x_common.c b/arch/ppc/syslib/ibm44x_common.c
index 5152c8e..6dae518 100644
--- a/arch/ppc/syslib/ibm44x_common.c
+++ b/arch/ppc/syslib/ibm44x_common.c
@@ -20,6 +20,7 @@
 #include <linux/types.h>
 #include <linux/serial.h>
 #include <linux/module.h>
+#include <linux/initrd.h>
 
 #include <asm/ibm44x.h>
 #include <asm/mmu.h>



!-------------------------------------------------------------flip-



--Boundary-00=_pPeZDZMewEMK+25--
