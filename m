Return-Path: <galak@somerset.sps.mot.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id EA4DA2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Nov 2004 16:27:53 +1100 (EST)
Received: from il06exr02.mot.com (il06exr02.mot.com [129.188.137.132])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id iA95TLnQ010598
	for <linuxppc-embedded@ozlabs.org>; Mon, 8 Nov 2004 22:29:21 -0700 (MST)
Received: from postal.somerset.sps.mot.com (postal.somerset.sps.mot.com
	[163.12.132.5])
	by il06exr02.mot.com (Motorola/il06exr02) with ESMTP id iA95QZud013312
	for <linuxppc-embedded@ozlabs.org>; Mon, 8 Nov 2004 23:26:37 -0600
Date: Mon, 8 Nov 2004 23:27:48 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0411082325360.13565@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Fix rheap warning
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

Here is patch that fixes a compile warning with rheap

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/arch/ppc/lib/rheap.c b/arch/ppc/lib/rheap.c
--- a/arch/ppc/lib/rheap.c	2004-11-08 22:43:52 -06:00
+++ b/arch/ppc/lib/rheap.c	2004-11-08 22:43:52 -06:00
@@ -645,6 +645,7 @@
  		return -EINVAL;

  	blk->owner = owner;
+	size = blk->size;

  	return size;
  }
