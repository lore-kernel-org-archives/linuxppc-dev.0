Return-Path: <monstr@monstr.eu>
Message-ID: <4B712458.9080205@monstr.eu>
Date: Tue, 09 Feb 2010 10:01:12 +0100
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/3] OF Device tree merge patches
References: <20100203185753.26862.6818.stgit@angua>
In-Reply-To: <20100203185753.26862.6818.stgit@angua>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

Grant Likely wrote:
> Hi everyone.  Here are a few patches that I've got sitting in my
> test-devicetree branch, but I haven't posted for review yet.  Please
> take a look and let me know if they are okay.  Once I've collected
> acks I'll move them over to my next-devicetree branch.

I am not able applied these patches on Linus head but I have tested your 
test-devicetree branch and I haven't found any problem for Microblaze, 
that's why you can add my ACK for Microblaze part

Acked-by: Michal Simek <monstr@monstr.eu>

BTW: I am testing Stephen's next tree every day that's why if you add 
that patches to next-tree you can look at 
http://www.monstr.eu/wiki/doku.php?id=log:log
to see if is any problem on Microblaze or not.

Thanks,
Michal



> 
> Thanks,
> g.
> 
> ---
> 
> Grant Likely (3):
>       of/flattree: merge early_init_dt_scan_memory() common code
>       of: add 'of_' prefix to machine_is_compatible()
>       microblaze: remove early_init_dt_scan_cpus() and phyp_dump_*()
> 
> 
>  arch/microblaze/include/asm/prom.h            |    4 
>  arch/microblaze/kernel/prom.c                 |  284 -------------------------
>  arch/powerpc/include/asm/prom.h               |    4 
>  arch/powerpc/kernel/pci_64.c                  |    2 
>  arch/powerpc/kernel/prom.c                    |  149 ++-----------
>  arch/powerpc/platforms/85xx/xes_mpc85xx.c     |    4 
>  arch/powerpc/platforms/cell/cbe_powerbutton.c |    2 
>  arch/powerpc/platforms/cell/ras.c             |    2 
>  arch/powerpc/platforms/pasemi/cpufreq.c       |    4 
>  arch/powerpc/platforms/powermac/cpufreq_32.c  |   14 +
>  arch/powerpc/platforms/powermac/cpufreq_64.c  |   14 +
>  arch/powerpc/platforms/powermac/feature.c     |    2 
>  arch/powerpc/platforms/powermac/smp.c         |   12 +
>  arch/powerpc/platforms/powermac/time.c        |    8 -
>  arch/powerpc/platforms/powermac/udbg_scc.c    |    6 -
>  arch/powerpc/sysdev/grackle.c                 |    4 
>  arch/sparc/kernel/prom_common.c               |   12 -
>  drivers/char/hvc_beat.c                       |    2 
>  drivers/gpu/drm/radeon/radeon_combios.c       |   44 ++--
>  drivers/macintosh/adb.c                       |    4 
>  drivers/macintosh/therm_pm72.c                |    8 -
>  drivers/macintosh/therm_windtunnel.c          |    2 
>  drivers/macintosh/via-pmu-backlight.c         |    8 -
>  drivers/macintosh/via-pmu.c                   |    8 -
>  drivers/macintosh/windfarm_core.c             |    6 -
>  drivers/macintosh/windfarm_cpufreq_clamp.c    |    6 -
>  drivers/macintosh/windfarm_lm75_sensor.c      |    6 -
>  drivers/macintosh/windfarm_max6690_sensor.c   |    6 -
>  drivers/macintosh/windfarm_pm112.c            |    2 
>  drivers/macintosh/windfarm_pm121.c            |    2 
>  drivers/macintosh/windfarm_pm81.c             |    4 
>  drivers/macintosh/windfarm_pm91.c             |    2 
>  drivers/macintosh/windfarm_smu_sensors.c      |    6 -
>  drivers/net/mace.c                            |    2 
>  drivers/of/Kconfig                            |    4 
>  drivers/of/base.c                             |   98 ++++++++-
>  drivers/of/fdt.c                              |   50 ++++
>  drivers/serial/pmac_zilog.c                   |    6 -
>  drivers/video/aty/aty128fb.c                  |   14 +
>  drivers/video/aty/atyfb_base.c                |    8 -
>  drivers/video/aty/radeon_backlight.c          |    6 -
>  include/linux/of.h                            |    6 +
>  include/linux/of_fdt.h                        |    5 
>  sound/ppc/awacs.c                             |   24 +-
>  sound/ppc/burgundy.c                          |    4 
>  sound/ppc/pmac.c                              |   18 +-
>  sound/soc/fsl/efika-audio-fabric.c            |    2 
>  sound/soc/fsl/pcm030-audio-fabric.c           |    2 
>  48 files changed, 317 insertions(+), 575 deletions(-)
> 


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
