Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 82DA4DDED3
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Apr 2008 23:06:29 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1007532pyg.27
	for <linuxppc-dev@ozlabs.org>; Sun, 06 Apr 2008 06:06:28 -0700 (PDT)
Subject: 4xx defconfig reorg
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Sun, 06 Apr 2008 08:06:21 -0500
Message-Id: <1207487181.6809.18.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: paulus@samba.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

Unless someone screams loudly and has reasons why this shouldn't go in,
the following commit should hit the 4xx next branch in the next day or
so.

josh

commit eaf997b847be3c351eb9d0107e0562035dc58095
Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date:   Sun Apr 6 08:01:21 2008 -0500

    [POWERPC] 4xx: Reorganize 4xx defconfigs
    
    Board specific defconfigs are useful, however with the ability to do
    multi-board defconfigs they aren't needed in the top level configs directory
    
    Move the 4xx board specific defconfigs to individual directories under
    arch/powerpc/configs.
    
    Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

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
 12 files changed, 0 insertions(+), 0 deletions(-)
