Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EBA2DDE18
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 22:41:33 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8KCfUIo029292
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 08:41:30 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8KCfUiG474578
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 06:41:30 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8KCfUOc032399
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 06:41:30 -0600
Date: Thu, 20 Sep 2007 07:41:28 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull from 'for-2.6.24' branch of 4xx tree
Message-ID: <20070920074128.6a90ebc2@weaponx.rchland.ibm.com>
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

Please pull from

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc.git for-2.6.24

to receive the following updates:

David Gibson (1):
      [POWERPC] Cleanups for physmap_of.c (v2)

Hollis Blanchard (1):
      [POWERPC] 4xx: Implement udbg_getc() for 440

Josh Boyer (5):
      [POWERPC] cuimage for Bamboo board
      [POWERPC] Make partitions optional in physmap_of
      [POWERPC] 4xx: Convert Walnut flash mappings to new binding
      [POWERPC] 4xx: Convert Seqouia flash mappings to new binding
      [POWERPC] Update PowerPC 4xx entry in MAINTAINERS

Valentine Barshak (3):
      [POWERPC] Add 64-bit resources support to pci_iomap
      [POWERPC] 4xx: Fix Bamboo MAL0 dts entry.
      [POWERPC] 4xx: Fix Sequoia MAL0 and EMAC dts entries.

 MAINTAINERS                            |    3 +
 arch/powerpc/boot/44x.h                |    2 +-
 arch/powerpc/boot/Makefile             |    4 +-
 arch/powerpc/boot/bamboo.c             |    8 +-
 arch/powerpc/boot/cuboot-bamboo.c      |   30 +++++
 arch/powerpc/boot/dts/bamboo.dts       |    2 +-
 arch/powerpc/boot/dts/sequoia.dts      |   46 +++++--
 arch/powerpc/boot/dts/walnut.dts       |   17 ++-
 arch/powerpc/boot/treeboot-bamboo.c    |   22 +++-
 arch/powerpc/configs/sequoia_defconfig |   91 +++++++++++++-
 arch/powerpc/kernel/iomap.c            |    4 +-
 arch/powerpc/kernel/udbg_16550.c       |   11 ++
 drivers/mtd/maps/physmap_of.c          |  222 ++++++++++++++------------------
 13 files changed, 304 insertions(+), 158 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-bamboo.c
