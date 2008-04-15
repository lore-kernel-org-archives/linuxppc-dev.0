Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC5B5DE2CE
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 01:30:31 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3FFSJ4v027551
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 11:28:19 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3FFUObG145340
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 09:30:26 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3FFUKaI030819
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 09:30:20 -0600
Date: Tue, 15 Apr 2008 10:27:04 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull 'for-2.6.26' branch of 4xx tree
Message-ID: <20080415102704.39511160@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.26

to pick up some additional patches for 4xx.  This contains the
defconfig reorg, some EMAC patches from Valentine that have been
outstanding for a while, and a new idle loop patch.

josh

Jerone Young (1):
      [POWERPC] 4xx: Add idle wait support for 44x platforms

Josh Boyer (2):
      [POWERPC] 4xx: Reorganize 4xx defconfigs
      [POWERPC] 4xx: Add ppc40x_defconfig

Valentine Barshak (2):
      [POWERPC] ibm_newemac: PowerPC 440GX EMAC PHY clock workaround
      [POWERPC] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock workaround

 arch/powerpc/configs/{ => 40x}/ep405_defconfig     |    0 
 arch/powerpc/configs/{ => 40x}/kilauea_defconfig   |    0 
 arch/powerpc/configs/{ => 40x}/makalu_defconfig    |    0 
 arch/powerpc/configs/{ => 40x}/walnut_defconfig    |    0 
 arch/powerpc/configs/{ => 44x}/bamboo_defconfig    |    0 
 .../configs/{ => 44x}/canyonlands_defconfig        |    0 
 arch/powerpc/configs/{ => 44x}/ebony_defconfig     |    0 
 arch/powerpc/configs/{ => 44x}/katmai_defconfig    |    0 
 arch/powerpc/configs/{ => 44x}/rainier_defconfig   |    0 
 arch/powerpc/configs/{ => 44x}/sequoia_defconfig   |    0 
 arch/powerpc/configs/{ => 44x}/taishan_defconfig   |    0 
 arch/powerpc/configs/{ => 44x}/warp_defconfig      |    0 
 .../configs/{walnut_defconfig => ppc40x_defconfig} |   31 ++++++---
 arch/powerpc/platforms/44x/Makefile                |    2 +-
 arch/powerpc/platforms/44x/idle.c                  |   67 ++++++++++++++++++++
 drivers/net/ibm_newemac/core.c                     |   48 +++++++++++++-
 drivers/net/ibm_newemac/core.h                     |   14 +++-
 17 files changed, 145 insertions(+), 17 deletions(-)
 rename arch/powerpc/configs/{ => 40x}/ep405_defconfig (100%)
 rename arch/powerpc/configs/{ => 40x}/kilauea_defconfig (100%)
 rename arch/powerpc/configs/{ => 40x}/makalu_defconfig (100%)
 copy arch/powerpc/configs/{ => 40x}/walnut_defconfig (100%)
 rename arch/powerpc/configs/{ => 44x}/bamboo_defconfig (100%)
 rename arch/powerpc/configs/{ => 44x}/canyonlands_defconfig (100%)
 rename arch/powerpc/configs/{ => 44x}/ebony_defconfig (100%)
 rename arch/powerpc/configs/{ => 44x}/katmai_defconfig (100%)
 rename arch/powerpc/configs/{ => 44x}/rainier_defconfig (100%)
 rename arch/powerpc/configs/{ => 44x}/sequoia_defconfig (100%)
 rename arch/powerpc/configs/{ => 44x}/taishan_defconfig (100%)
 rename arch/powerpc/configs/{ => 44x}/warp_defconfig (100%)
 rename arch/powerpc/configs/{walnut_defconfig => ppc40x_defconfig} (97%)
 create mode 100644 arch/powerpc/platforms/44x/idle.c
