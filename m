Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BEB1FB6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Jan 2010 03:13:44 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o04G5oD0014978
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jan 2010 09:05:50 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o04GDbZ9246394
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jan 2010 09:13:39 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o04GDYMZ023484
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jan 2010 09:13:35 -0700
Date: Mon, 4 Jan 2010 11:13:30 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'merge' branch of 4xx tree
Message-ID: <20100104161330.GE6229@zod.rchland.ibm.com>
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

Below are some simple defconfig updates for 4xx for 2.6.33.  Please pull them
before you send the next batch to Linus.

Thanks,
josh

The following changes since commit 95cd34b42b43c0ed5a89a764e023189bfe7b1530:
  Albert Herranz (1):
        powerpc/gc/wii: Remove get_irq_desc()

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git merge

Josh Boyer (2):
      powerpc/44x: Update PowerPC 44x board defconfigs
      powerpc/40x: Update the PowerPC 40x board defconfigs

 arch/powerpc/configs/40x/acadia_defconfig      |  241 ++++++++++++++-----
 arch/powerpc/configs/40x/ep405_defconfig       |  307 ++++++++++++++++++------
 arch/powerpc/configs/40x/hcu4_defconfig        |  256 +++++++++++++++-----
 arch/powerpc/configs/40x/kilauea_defconfig     |  140 ++++++++---
 arch/powerpc/configs/40x/makalu_defconfig      |  190 ++++++++++-----
 arch/powerpc/configs/40x/walnut_defconfig      |  257 +++++++++++++++-----
 arch/powerpc/configs/44x/arches_defconfig      |  135 ++++++++---
 arch/powerpc/configs/44x/bamboo_defconfig      |  255 +++++++++++++++-----
 arch/powerpc/configs/44x/canyonlands_defconfig |  141 ++++++++---
 arch/powerpc/configs/44x/ebony_defconfig       |  258 +++++++++++++++-----
 arch/powerpc/configs/44x/eiger_defconfig       |  128 +++++++---
 arch/powerpc/configs/44x/katmai_defconfig      |  253 +++++++++++++++-----
 arch/powerpc/configs/44x/rainier_defconfig     |  254 +++++++++++++++-----
 arch/powerpc/configs/44x/redwood_defconfig     |  274 +++++++++++++++------
 arch/powerpc/configs/44x/sam440ep_defconfig    |  284 +++++++++++++++-------
 arch/powerpc/configs/44x/sequoia_defconfig     |  202 +++++++++++-----
 arch/powerpc/configs/44x/taishan_defconfig     |  258 +++++++++++++++-----
 arch/powerpc/configs/44x/warp_defconfig        |  228 ++++++++++++------
 arch/powerpc/configs/ppc40x_defconfig          |  292 ++++++++++++++++-------
 arch/powerpc/configs/ppc44x_defconfig          |  309 +++++++++++++++++-------
 20 files changed, 3391 insertions(+), 1271 deletions(-)
