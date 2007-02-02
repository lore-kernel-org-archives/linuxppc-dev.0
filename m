Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA09EDDE2D
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 18:35:04 +1100 (EST)
Date: Fri, 02 Feb 2007 16:34:53 +0900 (JST)
Message-Id: <200702020734.l127Ysfg013490@toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 0/11] Patches for Toshiba Cell reference set
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul-san,

This is a revised version of the patch set for Toshiba Cell reference
set (aka Celleb). It is against powerpc.git. Please apply.


Changes from our previous patch set:

[PATCH 5/11] Celleb: htab routines
* use spin_lock_irqsave() instead of spin_lock()

[PATCH 8/11] Celleb: consolidate spu management ops
* (already posted)
  fix compile error in arch/powerpc/platforms/cell/spu_priv1_mmio.h


Best regards,
Kou Ishizaki
Toshiba
