Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1FCA4B70A2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Aug 2010 22:12:53 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7NBvUKx022079
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Aug 2010 07:57:30 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7NCCmhD1687766
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Aug 2010 08:12:48 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7NCClva024307
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Aug 2010 09:12:48 -0300
Date: Mon, 23 Aug 2010 08:12:46 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'merge' branch of 4xx tree
Message-ID: <20100823121246.GA13295@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

The changes from Dave for 47x (with minor fix), and a device tree update
for the 460ex SATA driver that has been merged upstream now.  Please
pull.

josh

The following changes since commit
e32e78c5ee8aadef020fbaecbe6fb741ed9029fd:

  powerpc: fix build with make 3.82 (2010-08-09 14:14:05 +1000)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git
merge

Dave Kleikamp (4):
      powerpc/47x: Make sure mcsr is cleared before enabling machine
check interrupts
      powerpc/47x: Remove redundant line from cputable.c
      powerpc/4xx: Index interrupt stacks by physical cpu
      powerpc/47x: Add an isync before the tlbivax instruction

Rupjyoti Sarmah (1):
      powerpc/4xx: Device tree update for the 460ex DWC SATA

 arch/powerpc/boot/dts/canyonlands.dts |    8 ++++++++
 arch/powerpc/kernel/cputable.c        |    1 -
 arch/powerpc/kernel/head_44x.S        |    4 ++++
 arch/powerpc/kernel/irq.c             |   16 +++++++++-------
 arch/powerpc/kernel/setup_32.c        |    9 +++++----
 arch/powerpc/mm/tlb_nohash_low.S      |    1 +
 6 files changed, 27 insertions(+), 12 deletions(-)
