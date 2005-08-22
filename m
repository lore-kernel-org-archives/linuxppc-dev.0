Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B9C7767FBC
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Aug 2005 17:13:32 +1000 (EST)
Received: from oak (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 9F500368019
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Aug 2005 17:13:32 +1000 (EST)
Date: Mon, 22 Aug 2005 16:10:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc64-dev <linuxppc64-dev@ozlabs.org>
Message-Id: <20050822161030.4082716d.sfr@canb.auug.org.au>
In-Reply-To: <20050822160519.51d065fe.sfr@canb.auug.org.au>
References: <20050822160254.2dc59b25.sfr@canb.auug.org.au>
	<20050822160519.51d065fe.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Resent-Message-Id: <20050822165907.42385a76.sfr@canb.auug.org.au>
Subject: [PATCH 3/3] Move all the very similar files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This moves all the very similar files - either the ppc64 file included
the ppc file or they differed in simple comments.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

---

This patch is too large for the list, so it is available at
http://ozlabs.org/~sfr/0003-This-moves-all-the-very-similar-files-either-the-ppc64-file-included.txt

 include/asm-powerpc/dbdma.h        |  102 ++++++++++
 include/asm-powerpc/errno.h        |   11 +
 include/asm-powerpc/ioctl.h        |   69 +++++++
 include/asm-powerpc/ioctls.h       |  107 ++++++++++
 include/asm-powerpc/keylargo.h     |  248 ++++++++++++++++++++++++
 include/asm-powerpc/local.h        |    1
 include/asm-powerpc/macio.h        |  141 +++++++++++++
 include/asm-powerpc/namei.h        |   20 ++
 include/asm-powerpc/of_device.h    |   62 ++++++
 include/asm-powerpc/parport.h      |   18 ++
 include/asm-powerpc/percpu.h       |    1
 include/asm-powerpc/pmac_feature.h |  379 ++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/pmac_low_i2c.h |   43 ++++
 include/asm-powerpc/poll.h         |   23 ++
 include/asm-powerpc/resource.h     |    1
 include/asm-powerpc/shmparam.h     |    6 +
 include/asm-powerpc/string.h       |   32 +++
 include/asm-powerpc/unaligned.h    |   18 ++
 include/asm-powerpc/uninorth.h     |  229 ++++++++++++++++++++++
 include/asm-ppc/dbdma.h            |  102 ----------
 include/asm-ppc/errno.h            |   11 -
 include/asm-ppc/ioctl.h            |   69 -------
 include/asm-ppc/ioctls.h           |  107 ----------
 include/asm-ppc/keylargo.h         |  248 ------------------------
 include/asm-ppc/local.h            |    6 -
 include/asm-ppc/macio.h            |  141 -------------
 include/asm-ppc/namei.h            |   20 --
 include/asm-ppc/of_device.h        |   62 ------
 include/asm-ppc/parport.h          |   18 --
 include/asm-ppc/percpu.h           |    6 -
 include/asm-ppc/pmac_feature.h     |  379 ------------------------------------
 include/asm-ppc/pmac_low_i2c.h     |   43 ----
 include/asm-ppc/poll.h             |   23 --
 include/asm-ppc/resource.h         |    6 -
 include/asm-ppc/shmparam.h         |    6 -
 include/asm-ppc/string.h           |   32 ---
 include/asm-ppc/unaligned.h        |   18 --
 include/asm-ppc/uninorth.h         |  229 ----------------------
 include/asm-ppc64/dbdma.h          |    2
 include/asm-ppc64/errno.h          |   18 --
 include/asm-ppc64/ioctl.h          |   74 -------
 include/asm-ppc64/ioctls.h         |  114 -----------
 include/asm-ppc64/keylargo.h       |    2
 include/asm-ppc64/local.h          |    1
 include/asm-ppc64/macio.h          |    2
 include/asm-ppc64/namei.h          |   23 --
 include/asm-ppc64/of_device.h      |    2
 include/asm-ppc64/parport.h        |   18 --
 include/asm-ppc64/percpu.h         |    6 -
 include/asm-ppc64/pmac_feature.h   |    2
 include/asm-ppc64/pmac_low_i2c.h   |    2
 include/asm-ppc64/poll.h           |   32 ---
 include/asm-ppc64/resource.h       |    6 -
 include/asm-ppc64/shmparam.h       |   13 -
 include/asm-ppc64/string.h         |   35 ---
 include/asm-ppc64/unaligned.h      |   21 --
 include/asm-ppc64/uninorth.h       |    2
 57 files changed, 1511 insertions(+), 1901 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
