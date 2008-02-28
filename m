Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2EF18DDF31
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 03:46:07 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1SGjpUG007730
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:45:51 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1SGjpjG245914
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:45:51 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1SGjoUt023343
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:45:51 -0500
Date: Thu, 28 Feb 2008 10:44:13 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull 'for-2.6.25' branch of 4xx tree
Message-ID: <20080228104413.0fead537@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.25

to pick up a few fixes for .25.  This includes Stephen's hwicap rework
that was done to address the comments that came up during review.

thx,
josh

Josh Boyer (1):
      [POWERPC] 4xx: Use correct board info structure in cuboot wrappers

Stefan Roese (2):
      [POWERPC] 4xx: Fix Haleakala PCIe compatibility problem in dts
      [POWERPC] 4xx: Fix L1 cache size in katmai DTS

Stephen Neuendorffer (1):
      [POWERPC] Xilinx: hwicap cleanup

Valentine Barshak (1):
      [POWERPC] 44x: add missing define TARGET_4xx and TARGET_440GX to cuboot-ta

 arch/powerpc/boot/cuboot-bamboo.c          |    1 +
 arch/powerpc/boot/cuboot-ebony.c           |    1 +
 arch/powerpc/boot/cuboot-katmai.c          |    1 +
 arch/powerpc/boot/cuboot-taishan.c         |    2 +
 arch/powerpc/boot/cuboot-warp.c            |    1 +
 arch/powerpc/boot/dts/haleakala.dts        |    2 +-
 arch/powerpc/boot/dts/katmai.dts           |   58 ++++++------
 drivers/char/xilinx_hwicap/buffer_icap.c   |   80 ++++++++--------
 drivers/char/xilinx_hwicap/fifo_icap.c     |   60 ++++++------
 drivers/char/xilinx_hwicap/xilinx_hwicap.c |  138 +++++++++++++---------------
 drivers/char/xilinx_hwicap/xilinx_hwicap.h |   24 +++---
 11 files changed, 180 insertions(+), 188 deletions(-)
