Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18056.38224.242633.494237@cargo.ozlabs.ibm.com>
Date: Mon, 2 Jul 2007 16:04:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org,
    linuxppc-dev@ozlabs.org
Subject: Re: Please pull powerpc.git merge branch
In-Reply-To: <18056.32340.502484.171937@cargo.ozlabs.ibm.com>
References: <18056.32340.502484.171937@cargo.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

I wrote:

> Please do:
> 
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
> 
> My defconfig updates exposed some compile failures on powerpc, which
> these three commits fix.

I have added another commit with a defconfig update for the Freescale
embedded platforms, from Kumar Gala, so you'll get 4 commits when you
do the pull.

Thanks,
Paul.

 arch/powerpc/configs/mpc7448_hpc2_defconfig  |  212 +++++++-----------
 arch/powerpc/configs/mpc8272_ads_defconfig   |  293 +++++++++++++++----------
 arch/powerpc/configs/mpc8313_rdb_defconfig   |  310 +++++++++++++-------------
 arch/powerpc/configs/mpc832x_mds_defconfig   |  176 ++++++---------
 arch/powerpc/configs/mpc832x_rdb_defconfig   |  229 ++++++++-----------
 arch/powerpc/configs/mpc834x_itx_defconfig   |  265 +++++++++++-----------
 arch/powerpc/configs/mpc834x_itxgp_defconfig |  232 ++++++++++---------
 arch/powerpc/configs/mpc834x_mds_defconfig   |  195 ++++++++--------
 arch/powerpc/configs/mpc836x_mds_defconfig   |  176 ++++++---------
 arch/powerpc/configs/mpc8540_ads_defconfig   |  201 ++++++++---------
 arch/powerpc/configs/mpc8544_ds_defconfig    |  193 +++++++---------
 arch/powerpc/configs/mpc8560_ads_defconfig   |  201 ++++++++---------
 arch/powerpc/configs/mpc8568mds_defconfig    |  191 +++++++---------
 arch/powerpc/configs/mpc85xx_cds_defconfig   |  206 +++++++++--------
 arch/powerpc/configs/mpc8641_hpcn_defconfig  |  200 ++++++++---------
 arch/powerpc/configs/mpc866_ads_defconfig    |  213 +++++++++---------
 arch/powerpc/configs/mpc885_ads_defconfig    |  222 +++++++++----------
 17 files changed, 1763 insertions(+), 1952 deletions(-)

commit 795bb15e0735bd2b0015ca333fa157399b72c168
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Mon Jul 2 00:04:36 2007 -0500

    [POWERPC] Update defconfigs
    
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
