Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 8A22EDE05F
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 02:46:37 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so703506yxb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 09:46:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.64.0905131731260.772@localhost.localdomain>
References: <Pine.LNX.4.64.0905131731260.772@localhost.localdomain>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 14 May 2009 10:41:16 -0600
Message-ID: <fa686aa40905140941y742320eep5070ec9c579e9b6@mail.gmail.com>
Subject: Re: Please pull from 'merge' branch for 2.6.30
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

Here are some more commits which got missed in the last merge cycle.
I've based this on top of Kumar's pull request from yesterday to
minimize merge commits.

Note: This pull request replaces my previous pull request.  I rebased
the series since some of the commits in my previous request have
already been merged.  If you've already pulled my last request then
you don't need to pull this one.

Cheers,
g.

The following changes since commit 2e15eedffaae555085071c68cb94b9eeed2245be=
:
  Kumar Gala (1):
        powerpc/8xx: Update defconfigs

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge

Grant Likely (2):
      powerpc/boot: add simpleImage.* to clean-files list
      powerpc/virtex: Add uImage to the default images list

John Linn (1):
      powerpc/virtex: Fix duplicate level irq events.

 arch/powerpc/boot/Makefile         |    2 +-
 arch/powerpc/platforms/40x/Kconfig |    1 +
 arch/powerpc/platforms/44x/Kconfig |    1 +
 arch/powerpc/sysdev/xilinx_intc.c  |  117 ++++++++++++++++++++++++++++++++=
---
 4 files changed, 110 insertions(+), 11 deletions(-)


On Wed, May 13, 2009 at 4:31 PM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
> Just added defconfig updates for the normal FSL set of HW.
>
> - k
>
> Please pull from 'merge' branch of
>
> =A0 =A0 =A0 =A0master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.=
git merge
>
> to receive the following updates:
>
> =A0arch/powerpc/configs/83xx/asp8347_defconfig =A0 =A0 =A0 | =A0104 ++++-
> =A0arch/powerpc/configs/83xx/mpc8313_rdb_defconfig =A0 | =A0114 ++++--
> =A0arch/powerpc/configs/83xx/mpc8315_rdb_defconfig =A0 | =A0114 ++++--
> =A0arch/powerpc/configs/83xx/mpc832x_mds_defconfig =A0 | =A0107 ++++--
> =A0arch/powerpc/configs/83xx/mpc832x_rdb_defconfig =A0 | =A0113 ++++--
> =A0arch/powerpc/configs/83xx/mpc834x_itx_defconfig =A0 | =A0108 ++++--
> =A0arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig | =A0108 ++++--
> =A0arch/powerpc/configs/83xx/mpc834x_mds_defconfig =A0 | =A0103 ++++-
> =A0arch/powerpc/configs/83xx/mpc836x_mds_defconfig =A0 | =A0108 ++++--
> =A0arch/powerpc/configs/83xx/mpc836x_rdk_defconfig =A0 | =A0 96 ++++-
> =A0arch/powerpc/configs/83xx/mpc837x_mds_defconfig =A0 | =A0104 ++++-
> =A0arch/powerpc/configs/83xx/mpc837x_rdb_defconfig =A0 | =A0111 ++++--
> =A0arch/powerpc/configs/83xx/sbc834x_defconfig =A0 =A0 =A0 | =A0 96 ++++-
> =A0arch/powerpc/configs/85xx/ksi8560_defconfig =A0 =A0 =A0 | =A0 86 +++-
> =A0arch/powerpc/configs/85xx/mpc8540_ads_defconfig =A0 | =A0 82 +++-
> =A0arch/powerpc/configs/85xx/mpc8560_ads_defconfig =A0 | =A0 89 +++--
> =A0arch/powerpc/configs/85xx/mpc85xx_cds_defconfig =A0 | =A0 88 +++--
> =A0arch/powerpc/configs/85xx/sbc8548_defconfig =A0 =A0 =A0 | =A0 84 +++-
> =A0arch/powerpc/configs/85xx/sbc8560_defconfig =A0 =A0 =A0 | =A0 83 +++-
> =A0arch/powerpc/configs/85xx/socrates_defconfig =A0 =A0 =A0| =A0385 +++++=
+++++++++++------
> =A0arch/powerpc/configs/85xx/stx_gp3_defconfig =A0 =A0 =A0 | =A0105 ++++-=
-
> =A0arch/powerpc/configs/85xx/tqm8540_defconfig =A0 =A0 =A0 | =A0100 ++++-
> =A0arch/powerpc/configs/85xx/tqm8541_defconfig =A0 =A0 =A0 | =A0101 ++++-
> =A0arch/powerpc/configs/85xx/tqm8548_defconfig =A0 =A0 =A0 | =A0 64 ++-
> =A0arch/powerpc/configs/85xx/tqm8555_defconfig =A0 =A0 =A0 | =A0101 ++++-
> =A0arch/powerpc/configs/85xx/tqm8560_defconfig =A0 =A0 =A0 | =A0101 ++++-
> =A0arch/powerpc/configs/86xx/gef_ppc9a_defconfig =A0 =A0 | =A0 92 ++++-
> =A0arch/powerpc/configs/86xx/gef_sbc310_defconfig =A0 =A0| =A0 92 ++++-
> =A0arch/powerpc/configs/86xx/gef_sbc610_defconfig =A0 =A0| =A0122 +++++-
> =A0arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig =A0| =A0100 ++++-
> =A0arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig =A0| =A0211 ++++-----=
---
> =A0arch/powerpc/configs/86xx/sbc8641d_defconfig =A0 =A0 =A0| =A0114 ++++-=
-
> =A0arch/powerpc/configs/adder875_defconfig =A0 =A0 =A0 =A0 =A0 | =A0 65 +=
+-
> =A0arch/powerpc/configs/c2k_defconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0128 +++++--
> =A0arch/powerpc/configs/ep8248e_defconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 74=
 +++-
> =A0arch/powerpc/configs/ep88xc_defconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 63=
 ++-
> =A0arch/powerpc/configs/linkstation_defconfig =A0 =A0 =A0 =A0| =A0 96 +++=
+-
> =A0arch/powerpc/configs/mgcoge_defconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 74=
 +++-
> =A0arch/powerpc/configs/mgsuvd_defconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 72=
 +++-
> =A0arch/powerpc/configs/mpc7448_hpc2_defconfig =A0 =A0 =A0 | =A0 91 +++--
> =A0arch/powerpc/configs/mpc8272_ads_defconfig =A0 =A0 =A0 =A0| =A0 77 +++=
-
> =A0arch/powerpc/configs/mpc83xx_defconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0115=
 ++++--
> =A0arch/powerpc/configs/mpc866_ads_defconfig =A0 =A0 =A0 =A0 | =A0 77 +++=
-
> =A0arch/powerpc/configs/mpc86xx_defconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0211=
 ++++--------
> =A0arch/powerpc/configs/mpc885_ads_defconfig =A0 =A0 =A0 =A0 | =A0 63 ++-
> =A0arch/powerpc/configs/pq2fads_defconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 90=
 +++--
> =A0arch/powerpc/configs/prpmc2800_defconfig =A0 =A0 =A0 =A0 =A0| =A0120 +=
++++-
> =A0arch/powerpc/configs/storcenter_defconfig =A0 =A0 =A0 =A0 | =A0 71 ++-=
-
> =A0arch/powerpc/sysdev/fsl_soc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 46 --
> =A049 files changed, 3630 insertions(+), 1489 deletions(-)
>
> Anton Vorontsov (1):
> =A0 =A0 =A0powerpc/fsl_soc: Remove mpc83xx_wdt_init, again
>
> Kumar Gala (5):
> =A0 =A0 =A0powerpc/83xx: Update defconfigs
> =A0 =A0 =A0powerpc/85xx: Update defconfigs
> =A0 =A0 =A0powerpc/86xx: Update defconfigs
> =A0 =A0 =A0powerpc/embedded6xx: Update defconfigs
> =A0 =A0 =A0powerpc/8xx: Update defconfigs
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
