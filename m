Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C5574DDE9D
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:27:59 +1100 (EST)
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m0PLK1at019562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 16:20:02 -0500
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0PLK0wt018547
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 16:20:01 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0PLK0Jb108504
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 14:20:00 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0PLK0wD024810
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 14:20:00 -0700
Date: Fri, 25 Jan 2008 15:19:18 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull 'for-2.6.25' branch of 4xx tree
Message-ID: <20080125151918.731bf71e@zod.rchland.ibm.com>
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

to pick up a few more patches for 4xx that should go in for 2.6.25.
Mostly self explanatory in the changelogs.  The diffstat is mostly from
the PIKA Warp board patches that Sean worked quite hard on.

thx,
josh

David Gibson (1):
      [POWERPC] Enable RTC for Ebony and Walnut (v2)

Roel Kluin (1):
      [POWERPC] 4xx: logical/bitand typo in powerpc/boot/4xx.c

Sean MacLennan (5):
      [POWERPC] 4xx: Add PowerPC 440EP Rev C
      [POWERPC] 4xx: PIKA Warp base platform
      [POWERPC] 4xx: PIKA Warp DTS
      [POWERPC] 4xx: PIKA Warp bootwrapper
      [POWERPC] 4xx: PIKA Warp defconfig

Stefan Roese (2):
      [POWERPC] 4xx: Add 405EXr to cputable
      [POWERPC] 4xx: Add AMCC Haleakala (405EXr) dts

 arch/powerpc/Kconfig                   |    2 +-
 arch/powerpc/boot/4xx.c                |    2 +-
 arch/powerpc/boot/Makefile             |    4 +-
 arch/powerpc/boot/cuboot-warp.c        |   39 ++
 arch/powerpc/boot/dts/ebony.dts        |    5 +-
 arch/powerpc/boot/dts/haleakala.dts    |  274 +++++++++
 arch/powerpc/boot/dts/walnut.dts       |    5 +-
 arch/powerpc/boot/dts/warp.dts         |  239 +++++++
 arch/powerpc/configs/warp_defconfig    | 1057 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c         |   28 +-
 arch/powerpc/platforms/40x/walnut.c    |    1 +
 arch/powerpc/platforms/44x/Kconfig     |   15 +
 arch/powerpc/platforms/44x/Makefile    |    2 +
 arch/powerpc/platforms/44x/ebony.c     |    2 +
 arch/powerpc/platforms/44x/warp-nand.c |  105 ++++
 arch/powerpc/platforms/44x/warp.c      |  153 +++++
 arch/powerpc/platforms/Kconfig         |    6 +
 arch/powerpc/sysdev/Makefile           |    1 +
 arch/powerpc/sysdev/of_rtc.c           |   59 ++
 include/asm-powerpc/of_platform.h      |    2 +
 20 files changed, 1992 insertions(+), 9 deletions(-)
