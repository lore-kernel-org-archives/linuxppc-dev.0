Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18264.39946.115015.191506@cargo.ozlabs.ibm.com>
Date: Fri, 7 Dec 2007 12:04:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

I have added another commit to my powerpc.git tree merge branch, so
please do:

git pull \
master.kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git merge

(the mirroring seems to be slow today).

The diffstat and log below reflect the new commit plus the 4 in my
last pull request.

Thanks,
Paul.

 arch/powerpc/configs/bamboo_defconfig            |   22 +-
 arch/powerpc/configs/cell_defconfig              |  176 ++++++++++--------
 arch/powerpc/configs/celleb_defconfig            |  170 +++++++++--------
 arch/powerpc/configs/chrp32_defconfig            |  163 +++++++++--------
 arch/powerpc/configs/ebony_defconfig             |   25 +--
 arch/powerpc/configs/ep88xc_defconfig            |   92 +++++----
 arch/powerpc/configs/g5_defconfig                |  150 ++++++++-------
 arch/powerpc/configs/holly_defconfig             |  136 +++++++-------
 arch/powerpc/configs/iseries_defconfig           |  123 ++++++------
 arch/powerpc/configs/kilauea_defconfig           |   79 +++-----
 arch/powerpc/configs/linkstation_defconfig       |  152 ++++++++-------
 arch/powerpc/configs/lite5200_defconfig          |  119 ++++++------
 arch/powerpc/configs/maple_defconfig             |  126 ++++++-------
 arch/powerpc/configs/mpc7448_hpc2_defconfig      |  137 +++++++-------
 arch/powerpc/configs/mpc8272_ads_defconfig       |  106 ++++++-----
 arch/powerpc/configs/mpc8313_rdb_defconfig       |  173 +++++++++---------
 arch/powerpc/configs/mpc832x_mds_defconfig       |  155 ++++++++--------
 arch/powerpc/configs/mpc832x_rdb_defconfig       |  167 ++++++++---------
 arch/powerpc/configs/mpc834x_itx_defconfig       |  156 ++++++++--------
 arch/powerpc/configs/mpc834x_itxgp_defconfig     |  161 +++++++++-------
 arch/powerpc/configs/mpc834x_mds_defconfig       |  149 +++++++--------
 arch/powerpc/configs/mpc836x_mds_defconfig       |  155 ++++++++--------
 arch/powerpc/configs/mpc8540_ads_defconfig       |  101 +++++-----
 arch/powerpc/configs/mpc8544_ds_defconfig        |  130 +++++++------
 arch/powerpc/configs/mpc8560_ads_defconfig       |  104 +++++------
 arch/powerpc/configs/mpc8568mds_defconfig        |  161 ++++++++--------
 arch/powerpc/configs/mpc8572_ds_defconfig        |  130 +++++++------
 arch/powerpc/configs/mpc85xx_cds_defconfig       |  126 ++++++-------
 arch/powerpc/configs/mpc8610_hpcd_defconfig      |  114 +++++-------
 arch/powerpc/configs/mpc8641_hpcn_defconfig      |  131 +++++++------
 arch/powerpc/configs/mpc866_ads_defconfig        |  107 +++++------
 arch/powerpc/configs/mpc885_ads_defconfig        |   98 +++++-----
 arch/powerpc/configs/pasemi_defconfig            |    8 +
 arch/powerpc/configs/pmac32_defconfig            |  217 ++++++++++++++--------
 arch/powerpc/configs/ppc64_defconfig             |    9 +
 arch/powerpc/configs/pq2fads_defconfig           |  148 +++++++++------
 arch/powerpc/configs/prpmc2800_defconfig         |  150 ++++++++-------
 arch/powerpc/configs/ps3_defconfig               |  177 +++++++++---------
 arch/powerpc/configs/pseries_defconfig           |  156 +++++++++-------
 arch/powerpc/configs/sequoia_defconfig           |  111 ++++++-----
 arch/powerpc/configs/walnut_defconfig            |   22 +-
 arch/powerpc/kernel/process.c                    |    2 
 arch/ppc/platforms/4xx/xparameters/xparameters.h |    8 +
 arch/ppc/syslib/virtex_devices.c                 |    8 -
 include/asm-powerpc/time.h                       |    8 -
 45 files changed, 2662 insertions(+), 2456 deletions(-)

Geoff Levand (1):
      [POWERPC] PS3: Update ps3_defconfig

Grant Likely (1):
      [POWERPC] virtex bug fix: Use canonical value for AC97 interrupt xparams

Paul Mackerras (1):
      [POWERPC] Update defconfigs

Stephen Rothwell (1):
      [POWERPC] Update iseries_defconfig

Tony Breeds (1):
      [POWERPC] Fix hardware IRQ time accounting problem.
