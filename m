Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2BDA1DDEE9
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 03:51:32 +1100 (EST)
Date: Tue, 15 Jan 2008 11:01:52 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: Please pull pasemi.git for-2.6.25 branch
Message-ID: <20080115170152.GA25749@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Please pull from 'for-2.6.25' branch of

  master.kernel.org:/pub/scm/linux/kernel/git/olof/k.org.git for-2.6.25

to receive the following updates:

 arch/powerpc/configs/pasemi_defconfig       |    4 
 arch/powerpc/platforms/pasemi/Kconfig       |    9 -
 arch/powerpc/platforms/pasemi/Makefile      |    1 
 arch/powerpc/platforms/pasemi/electra_ide.c |   96 ------------------
 arch/powerpc/platforms/pasemi/idle.c        |    5 
 arch/powerpc/platforms/pasemi/setup.c       |   12 --
 drivers/ata/Kconfig                         |   12 ++
 drivers/ata/Makefile                        |    1 
 drivers/ata/pata_of_platform.c              |  114 ++++++++++++++++++++++
 drivers/ata/pata_platform.c                 |  144 ++++++++++++++++------------
 include/linux/pata_platform.h               |    9 +
 11 files changed, 227 insertions(+), 180 deletions(-)

Anton Vorontsov (2):
      libata: pata_platform: make probe and remove functions device type neutral
      libata: pata_of_platform: OF-Platform PATA device driver

Grant Likely (1):
      [POWERPC] pasemi: Use machine_*_initcall() hooks in platform code

Olof Johansson (2):
      [POWERPC] pasemi: Fix NMI handling check
      [POWERPC] pasemi: Move electra-ide to pata_of_platform


Thanks,

Olof
