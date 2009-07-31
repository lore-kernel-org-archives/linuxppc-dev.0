Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 24E4DB7BAF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 22:50:20 +1000 (EST)
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94301DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 22:50:19 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6VCmRwo012292
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 06:48:27 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6VCoFRa214940
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 06:50:15 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6VCoF9O008829
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 06:50:15 -0600
Date: Fri, 31 Jul 2009 08:50:11 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20090731125011.GI10244@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

A few changes from Stefan for 460 and Kilauea boards.

Thanks,
josh

The following changes since commit 8984d7d529d50d11ebd840d69ce61ab0bf4ffcab:
  Benjamin Herrenschmidt (1):
        powerpc: Remaining 64-bit Book3E support

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Stefan Roese (5):
      powerpc: Add AMCC 460EX/460GT Rev. B support to cputable.c
      powerpc/44x: Add NAND support to Canyonlands dts
      powerpc/40x: Update Kilauea dts to support NAND, RTC and HWMON
      powerpc/44x: Update Canyonlands defconfig to support NOR, NAND and RTC
      powerpc/40x: Update kilauea defconfig to support NAND, RTC and HWMON

 arch/powerpc/boot/dts/canyonlands.dts          |   49 +++-
 arch/powerpc/boot/dts/kilauea.dts              |   44 +++-
 arch/powerpc/configs/40x/kilauea_defconfig     |  298 +++++++++++++++++---
 arch/powerpc/configs/44x/canyonlands_defconfig |  350 ++++++++++++++++++++----
 arch/powerpc/kernel/cputable.c                 |   30 ++-
 5 files changed, 658 insertions(+), 113 deletions(-)
