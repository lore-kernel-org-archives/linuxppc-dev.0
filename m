Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 002A4B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 02:58:43 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6QGujYP030339
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2010 10:56:45 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6QGwKTg011372
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2010 10:58:21 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6QGwHnY022014
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2010 10:58:17 -0600
Date: Mon, 26 Jul 2010 12:58:16 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20100726165816.GA10698@zod.rchland.ibm.com>
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

A few small fixes for 4xx.  Please pull.

josh

The following changes since commit cccd23428347251713b643d4bc5edb610308fd49:

  powerpc: Removing dead CONFIG_SMP_750 (2010-07-09 11:28:38 +1000)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Christian Dietrich (1):
      Remove REDWOOD_[456] config options and conditional code

Lee Nipper (1):
      powerpc/40x: Distinguish AMCC PowerPC 405EX and 405EXr correctly

Stefan Roese (1):
      powerpc/44x: Fix UART2/3 interrupt assignment in PPC460EX/GT dts files

 arch/powerpc/boot/dts/canyonlands.dts |    4 +-
 arch/powerpc/boot/dts/glacier.dts     |    4 +-
 arch/powerpc/kernel/cputable.c        |  118 +++++++++++++++++++++++++++++++--
 arch/powerpc/platforms/40x/Kconfig    |   16 -----
 drivers/mtd/maps/Kconfig              |    2 +-
 drivers/mtd/maps/redwood.c            |   43 ------------
 drivers/net/Kconfig                   |    2 +-
 drivers/net/smc91x.h                  |   37 ----------
 8 files changed, 117 insertions(+), 109 deletions(-)
