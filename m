Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7172CB7D0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Feb 2010 00:03:31 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1CCv9Z3006871
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2010 05:57:09 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1CD38pd034354
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2010 06:03:10 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1CD37XW004510
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2010 06:03:07 -0700
Date: Fri, 12 Feb 2010 08:02:56 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20100212130256.GD16178@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Some updates for various boards from Stefan.  I don't have anything else at
the moment, so I thought I'd get this rolled into your tree now.

josh

The following changes since commit b919ee827e048826786fd7e889a2b04f63382fe6:
  Anton Blanchard (1):
        powerpc: Only print clockevent settings once

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Stefan Roese (6):
      powerpc/44x: Fix L2-cache support for 460GT
      powerpc/44x: Add MTD support (NOR FLASH) to Katmai dts
      powerpc/44x: Update Arches dts
      powerpc/44x: Update Glacier dts
      powerpc/44x: Add MTD support to katmai defconfig
      powerpc/40x: Add support for PPC40x boards with > 512MB SDRAM

 arch/powerpc/boot/dts/arches.dts          |   12 ++++
 arch/powerpc/boot/dts/glacier.dts         |   76 ++++++++++++++++++++---
 arch/powerpc/boot/dts/katmai.dts          |   71 ++++++++++++++++------
 arch/powerpc/configs/44x/katmai_defconfig |   94 +++++++++++++++++++++++++++--
 arch/powerpc/mm/40x_mmu.c                 |    4 +-
 arch/powerpc/sysdev/ppc4xx_soc.c          |    3 +-
 6 files changed, 224 insertions(+), 36 deletions(-)
