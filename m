Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9FA82B7119
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Feb 2011 01:55:18 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p1FEbCQf021562
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Feb 2011 09:37:14 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3257D728042
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Feb 2011 09:55:13 -0500 (EST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p1FEtCWf182948
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Feb 2011 09:55:12 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p1FEtACK001401
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Feb 2011 07:55:11 -0700
Date: Tue, 15 Feb 2011 09:54:45 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20110215145445.GA2847@zod.rchland.ibm.com>
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

Please pull the 'next' branch of the 4xx tree.  These commits have been
sitting there for a while and I wanted to get them into your branch
before tackling the latest round of 476 stuff from Shaggy.

josh

The following changes since commit 5d7d8072edc11080a7cf6cc37c9f4e61ca1e93c9:

  powerpc/pseries: Fix build of topology stuff without CONFIG_NUMA (2011-01-12 10:56:29 +1100)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Dave Kleikamp (2):
      powerpc/476: define specific cpu table entry DD2 core
      powerpc/476: Workaround for PLB6 hang

Rupjyoti Sarmah (1):
      powerpc/44x: PHY fixup for USB on canyonlands board

Tirumala Marri (1):
      powerpc/44x: Add USB DWC DTS entry to Canyonlands board

 arch/powerpc/boot/dts/canyonlands.dts      |   24 +++++
 arch/powerpc/include/asm/cputable.h        |    3 +-
 arch/powerpc/kernel/cputable.c             |   22 ++++-
 arch/powerpc/mm/tlb_nohash_low.S           |   35 +++++++
 arch/powerpc/platforms/44x/44x.h           |    4 +
 arch/powerpc/platforms/44x/Kconfig         |    1 -
 arch/powerpc/platforms/44x/Makefile        |    1 +
 arch/powerpc/platforms/44x/canyonlands.c   |  134 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/ppc44x_simple.c |    1 -
 9 files changed, 218 insertions(+), 7 deletions(-)
 create mode 100644 arch/powerpc/platforms/44x/canyonlands.c
