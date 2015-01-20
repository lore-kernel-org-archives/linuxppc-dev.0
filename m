Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB7291A0C2A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 18:06:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Update all configs using savedefconfig
Date: Tue, 20 Jan 2015 18:05:58 +1100
Message-Id: <1421737558-14756-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It looks like it's ~4 years since we updated some of these, so do a bulk
update.

Verified that the before and after generated configs are exactly the
same.

Which begs the question why update them? The answer is that it can be
confusing when the stored defconfig drifts too far from the generated
result.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/40x/acadia_defconfig         |  21 +-
 arch/powerpc/configs/40x/ep405_defconfig          |  18 +-
 arch/powerpc/configs/40x/kilauea_defconfig        |  27 +-
 arch/powerpc/configs/40x/klondike_defconfig       |   4 -
 arch/powerpc/configs/40x/makalu_defconfig         |  20 +-
 arch/powerpc/configs/40x/obs600_defconfig         |  13 +-
 arch/powerpc/configs/40x/virtex_defconfig         |  21 +-
 arch/powerpc/configs/40x/walnut_defconfig         |  18 +-
 arch/powerpc/configs/44x/akebono_defconfig        |   7 -
 arch/powerpc/configs/44x/arches_defconfig         |  23 +-
 arch/powerpc/configs/44x/bamboo_defconfig         |  15 +-
 arch/powerpc/configs/44x/bluestone_defconfig      |  16 +-
 arch/powerpc/configs/44x/canyonlands_defconfig    |  26 +-
 arch/powerpc/configs/44x/currituck_defconfig      |  13 +-
 arch/powerpc/configs/44x/ebony_defconfig          |  17 +-
 arch/powerpc/configs/44x/eiger_defconfig          |  26 +-
 arch/powerpc/configs/44x/icon_defconfig           |  20 --
 arch/powerpc/configs/44x/iss476-smp_defconfig     |  16 +-
 arch/powerpc/configs/44x/katmai_defconfig         |  15 -
 arch/powerpc/configs/44x/rainier_defconfig        |  15 +-
 arch/powerpc/configs/44x/redwood_defconfig        |  26 +-
 arch/powerpc/configs/44x/sam440ep_defconfig       |  19 +-
 arch/powerpc/configs/44x/sequoia_defconfig        |  21 +-
 arch/powerpc/configs/44x/taishan_defconfig        |  16 +-
 arch/powerpc/configs/44x/virtex5_defconfig        |  21 +-
 arch/powerpc/configs/44x/warp_defconfig           |  23 +-
 arch/powerpc/configs/52xx/cm5200_defconfig        |  19 +-
 arch/powerpc/configs/52xx/lite5200b_defconfig     |  20 +-
 arch/powerpc/configs/52xx/motionpro_defconfig     |  22 +-
 arch/powerpc/configs/52xx/pcm030_defconfig        |  21 +-
 arch/powerpc/configs/52xx/tqm5200_defconfig       |  22 +-
 arch/powerpc/configs/83xx/asp8347_defconfig       |  22 +-
 arch/powerpc/configs/83xx/kmeter1_defconfig       |   4 -
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |  25 +-
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  22 +-
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |  21 +-
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |  23 +-
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |  20 +-
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |  20 +-
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |  23 +-
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |  22 +-
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |  16 +-
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |  15 +-
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |  17 +-
 arch/powerpc/configs/83xx/sbc834x_defconfig       |  16 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig      |  16 +-
 arch/powerpc/configs/85xx/kmp204x_defconfig       |   3 -
 arch/powerpc/configs/85xx/ksi8560_defconfig       |  17 +-
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |  19 +-
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |  19 +-
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |  21 +-
 arch/powerpc/configs/85xx/ppa8548_defconfig       |  62 ++--
 arch/powerpc/configs/85xx/sbc8548_defconfig       |  40 +--
 arch/powerpc/configs/85xx/socrates_defconfig      |  24 +-
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |  15 +-
 arch/powerpc/configs/85xx/tqm8540_defconfig       |  17 +-
 arch/powerpc/configs/85xx/tqm8541_defconfig       |  17 +-
 arch/powerpc/configs/85xx/tqm8548_defconfig       |  22 +-
 arch/powerpc/configs/85xx/tqm8555_defconfig       |  17 +-
 arch/powerpc/configs/85xx/tqm8560_defconfig       |  17 +-
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   |  34 +--
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig     |  36 +--
 arch/powerpc/configs/86xx/gef_sbc310_defconfig    |  35 +--
 arch/powerpc/configs/86xx/gef_sbc610_defconfig    |  53 +---
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |  32 +-
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |  33 +-
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |  54 +---
 arch/powerpc/configs/adder875_defconfig           |  27 +-
 arch/powerpc/configs/amigaone_defconfig           |  36 +--
 arch/powerpc/configs/c2k_defconfig                |  82 ++---
 arch/powerpc/configs/cell_defconfig               |  30 +-
 arch/powerpc/configs/celleb_defconfig             |  21 +-
 arch/powerpc/configs/chrp32_defconfig             |  37 +--
 arch/powerpc/configs/corenet32_smp_defconfig      |  19 +-
 arch/powerpc/configs/corenet64_smp_defconfig      |   1 -
 arch/powerpc/configs/ep8248e_defconfig            |  17 +-
 arch/powerpc/configs/ep88xc_defconfig             |  29 +-
 arch/powerpc/configs/g5_defconfig                 |  60 +---
 arch/powerpc/configs/gamecube_defconfig           |  15 +-
 arch/powerpc/configs/holly_defconfig              |  15 +-
 arch/powerpc/configs/linkstation_defconfig        |  28 +-
 arch/powerpc/configs/maple_defconfig              |  26 +-
 arch/powerpc/configs/mgcoge_defconfig             |  12 +-
 arch/powerpc/configs/mpc512x_defconfig            |   2 -
 arch/powerpc/configs/mpc5200_defconfig            |  18 +-
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |  18 +-
 arch/powerpc/configs/mpc8272_ads_defconfig        |  24 +-
 arch/powerpc/configs/mpc83xx_defconfig            |   7 -
 arch/powerpc/configs/mpc85xx_defconfig            |  58 +---
 arch/powerpc/configs/mpc85xx_smp_defconfig        |  62 +---
 arch/powerpc/configs/mpc866_ads_defconfig         |  22 +-
 arch/powerpc/configs/mpc86xx_defconfig            |  39 +--
 arch/powerpc/configs/mpc885_ads_defconfig         |  29 +-
 arch/powerpc/configs/mvme5100_defconfig           |   9 -
 arch/powerpc/configs/pasemi_defconfig             |   3 -
 arch/powerpc/configs/pmac32_defconfig             |  65 +---
 arch/powerpc/configs/ppc40x_defconfig             |  17 +-
 arch/powerpc/configs/ppc44x_defconfig             |  14 -
 arch/powerpc/configs/ppc64_defconfig              |  12 +-
 arch/powerpc/configs/ppc64e_defconfig             |   4 -
 arch/powerpc/configs/ppc6xx_defconfig             | 348 ++++++++--------------
 arch/powerpc/configs/pq2fads_defconfig            |  28 +-
 arch/powerpc/configs/ps3_defconfig                |  16 +-
 arch/powerpc/configs/pseries_defconfig            |  12 +-
 arch/powerpc/configs/pseries_le_defconfig         |  14 +-
 arch/powerpc/configs/storcenter_defconfig         |  12 +-
 arch/powerpc/configs/tqm8xx_defconfig             |  32 +-
 arch/powerpc/configs/wii_defconfig                |  18 +-
 108 files changed, 581 insertions(+), 2207 deletions(-)

260K patch stripped.

If anyone wants to see the actual patch let me know.

cheers
