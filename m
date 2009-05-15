Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37BE7DE073
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 14:46:35 +1000 (EST)
Subject: Re: Please pull from 'merge' branch for 2.6.30
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40905140941y742320eep5070ec9c579e9b6@mail.gmail.com>
References: <Pine.LNX.4.64.0905131731260.772@localhost.localdomain>
	<fa686aa40905140941y742320eep5070ec9c579e9b6@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 15 May 2009 14:20:59 +1000
Message-Id: <1242361259.22331.2.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-05-14 at 10:41 -0600, Grant Likely wrote:
> Hi Ben,
> 
> Here are some more commits which got missed in the last merge cycle.
> I've based this on top of Kumar's pull request from yesterday to
> minimize merge commits.
> 
> Note: This pull request replaces my previous pull request.  I rebased
> the series since some of the commits in my previous request have
> already been merged.  If you've already pulled my last request then
> you don't need to pull this one.

What branch ? I don't see them in either your merge or next branch...

Cheers,
Ben.

> Cheers,
> g.
> 
> The following changes since commit 2e15eedffaae555085071c68cb94b9eeed2245be:
>   Kumar Gala (1):
>         powerpc/8xx: Update defconfigs
> 
> are available in the git repository at:
> 
>   git://git.secretlab.ca/git/linux-2.6 merge
> 
> Grant Likely (2):
>       powerpc/boot: add simpleImage.* to clean-files list
>       powerpc/virtex: Add uImage to the default images list
> 
> John Linn (1):
>       powerpc/virtex: Fix duplicate level irq events.
> 
>  arch/powerpc/boot/Makefile         |    2 +-
>  arch/powerpc/platforms/40x/Kconfig |    1 +
>  arch/powerpc/platforms/44x/Kconfig |    1 +
>  arch/powerpc/sysdev/xilinx_intc.c  |  117 ++++++++++++++++++++++++++++++++---
>  4 files changed, 110 insertions(+), 11 deletions(-)
> 
> 
> On Wed, May 13, 2009 at 4:31 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
> > Just added defconfig updates for the normal FSL set of HW.
> >
> > - k
> >
> > Please pull from 'merge' branch of
> >
> >        master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge
> >
> > to receive the following updates:
> >
> >  arch/powerpc/configs/83xx/asp8347_defconfig       |  104 ++++-
> >  arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |  114 ++++--
> >  arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  114 ++++--
> >  arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |  107 ++++--
> >  arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |  113 ++++--
> >  arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |  108 ++++--
> >  arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |  108 ++++--
> >  arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |  103 ++++-
> >  arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |  108 ++++--
> >  arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |   96 ++++-
> >  arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |  104 ++++-
> >  arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |  111 ++++--
> >  arch/powerpc/configs/83xx/sbc834x_defconfig       |   96 ++++-
> >  arch/powerpc/configs/85xx/ksi8560_defconfig       |   86 +++-
> >  arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |   82 +++-
> >  arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |   89 +++--
> >  arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |   88 +++--
> >  arch/powerpc/configs/85xx/sbc8548_defconfig       |   84 +++-
> >  arch/powerpc/configs/85xx/sbc8560_defconfig       |   83 +++-
> >  arch/powerpc/configs/85xx/socrates_defconfig      |  385 ++++++++++++++++------
> >  arch/powerpc/configs/85xx/stx_gp3_defconfig       |  105 ++++--
> >  arch/powerpc/configs/85xx/tqm8540_defconfig       |  100 ++++-
> >  arch/powerpc/configs/85xx/tqm8541_defconfig       |  101 ++++-
> >  arch/powerpc/configs/85xx/tqm8548_defconfig       |   64 ++-
> >  arch/powerpc/configs/85xx/tqm8555_defconfig       |  101 ++++-
> >  arch/powerpc/configs/85xx/tqm8560_defconfig       |  101 ++++-
> >  arch/powerpc/configs/86xx/gef_ppc9a_defconfig     |   92 ++++-
> >  arch/powerpc/configs/86xx/gef_sbc310_defconfig    |   92 ++++-
> >  arch/powerpc/configs/86xx/gef_sbc610_defconfig    |  122 +++++-
> >  arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |  100 ++++-
> >  arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |  211 ++++--------
> >  arch/powerpc/configs/86xx/sbc8641d_defconfig      |  114 ++++--
> >  arch/powerpc/configs/adder875_defconfig           |   65 ++-
> >  arch/powerpc/configs/c2k_defconfig                |  128 +++++--
> >  arch/powerpc/configs/ep8248e_defconfig            |   74 +++-
> >  arch/powerpc/configs/ep88xc_defconfig             |   63 ++-
> >  arch/powerpc/configs/linkstation_defconfig        |   96 ++++-
> >  arch/powerpc/configs/mgcoge_defconfig             |   74 +++-
> >  arch/powerpc/configs/mgsuvd_defconfig             |   72 +++-
> >  arch/powerpc/configs/mpc7448_hpc2_defconfig       |   91 +++--
> >  arch/powerpc/configs/mpc8272_ads_defconfig        |   77 +++-
> >  arch/powerpc/configs/mpc83xx_defconfig            |  115 ++++--
> >  arch/powerpc/configs/mpc866_ads_defconfig         |   77 +++-
> >  arch/powerpc/configs/mpc86xx_defconfig            |  211 ++++--------
> >  arch/powerpc/configs/mpc885_ads_defconfig         |   63 ++-
> >  arch/powerpc/configs/pq2fads_defconfig            |   90 +++--
> >  arch/powerpc/configs/prpmc2800_defconfig          |  120 +++++-
> >  arch/powerpc/configs/storcenter_defconfig         |   71 ++--
> >  arch/powerpc/sysdev/fsl_soc.c                     |   46 --
> >  49 files changed, 3630 insertions(+), 1489 deletions(-)
> >
> > Anton Vorontsov (1):
> >      powerpc/fsl_soc: Remove mpc83xx_wdt_init, again
> >
> > Kumar Gala (5):
> >      powerpc/83xx: Update defconfigs
> >      powerpc/85xx: Update defconfigs
> >      powerpc/86xx: Update defconfigs
> >      powerpc/embedded6xx: Update defconfigs
> >      powerpc/8xx: Update defconfigs
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> 
> 
> 
