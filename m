Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Wed, 17 Aug 2005 13:05:29 +0200
References: <20050805174705.731ffa05.sfr@canb.auug.org.au>
	<8DC89F16-0704-484A-9216-D94F3EE90CA4@freescale.com>
In-Reply-To: <8DC89F16-0704-484A-9216-D94F3EE90CA4@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3975808.MQXZzC26Z0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200508171305.30833.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] 1/2 Start header file merger (Was: Re: Beginning Merger
	Patch)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart3975808.MQXZzC26Z0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Middeweken 17 August 2005 07:39, Kumar Gala wrote:
>  =20
> For example, there is a fair amount of headers that are specific to =20
> platform support code.  It's probably the case that alot of that =20
> should move into the proper platform directory.

I have identified a list of files that are included only from files
in a single directory (after the platform merge) or not included at
all.=20
See the end of this mail.

> Now your makefile hackery seems perfectly reasonable if we want to go =20
> that way instead of explicitly including files like Jon's original =20
> patch does.  I dont have any strong feelings one way or the other. =20
> The makefile hackery seems less intrusive since we dont have to =20
> duplicate files in both places.  I'd like to see if we can come to =20
> some consensus on this since it directly impacts future patches that =20
> we are working on to merge more files and move them into include/asm-=20
> powerpc/

I vote for doing it with the Makefile hacks. The advantage I see in this
is that it is obvious from the file in each of the directories which files
are already merged and which ones still need to be worked on.

	Arnd <><

+++ ./bseip.h 0 +++
+++ ./gt64260.h 0 +++
+++ ./hdreg.h 0 +++
+++ ./md.h 0 +++
+++ ./ans-lcd.h 1 +++
=2E/drivers/macintosh/ans-lcd.c:#include <asm/ans-lcd.h>
+++ ./gt64260_defs.h 1 +++
=2E/include/asm-ppc/gt64260.h:#include <asm/gt64260_defs.h>
+++ ./hawk_defs.h 1 +++
=2E/include/asm-ppc/hawk.h:#include <asm/hawk_defs.h>
+++ ./iSeries/HvCallSm.h 1 +++
=2E/arch/ppc64/kernel/iSeries_setup.c:#include <asm/iSeries/HvCallSm.h>
+++ ./iSeries/HvReleaseData.h 1 +++
=2E/arch/ppc64/kernel/LparData.c:#include <asm/iSeries/HvReleaseData.h>
+++ ./iSeries/ItIplParmsReal.h 1 +++
=2E/arch/ppc64/kernel/LparData.c:#include <asm/iSeries/ItIplParmsReal.h>
+++ ./iSeries/ItSpCommArea.h 1 +++
=2E/arch/ppc64/kernel/LparData.c:#include <asm/iSeries/ItSpCommArea.h>
+++ ./iSeries/iSeries_io.h 1 +++
=2E/include/asm-ppc64/io.h:#include <asm/iSeries/iSeries_io.h>
+++ ./ibm403.h 1 +++
=2E/arch/ppc/platforms/4xx/oak.h:#include <asm/ibm403.h>
+++ ./m8260_pci.h 1 +++
=2E/arch/ppc/syslib/m82xx_pci.h:#include <asm/m8260_pci.h>
+++ ./mk48t59.h 1 +++
=2E/arch/ppc/platforms/prep_setup.c:#include <asm/mk48t59.h>
+++ ./ppc32.h 1 +++
=2E/arch/ppc64/kernel/signal32.c:#include <asm/ppc32.h>
+++ ./raven.h 1 +++
=2E/arch/ppc/platforms/prep_setup.c:#include <asm/raven.h>
+++ ./gg2.h 2 +++
=2E/arch/ppc/platforms/chrp_pci.c:#include <asm/gg2.h>
=2E/arch/ppc/platforms/chrp_setup.c:#include <asm/gg2.h>
+++ ./harrier.h 2 +++
=2E/arch/ppc/platforms/prpmc800.c:#include <asm/harrier.h>
=2E/arch/ppc/syslib/harrier.c:#include <asm/harrier.h>
+++ ./iSeries/IoHriMainStore.h 2 +++
=2E/arch/ppc64/kernel/iSeries_proc.c:#include <asm/iSeries/IoHriMainStore.h>
=2E/arch/ppc64/kernel/iSeries_setup.c:#include <asm/iSeries/IoHriMainStore.=
h>
+++ ./iSeries/ItVpdAreas.h 2 +++
=2E/arch/ppc64/kernel/LparData.c:#include <asm/iSeries/ItVpdAreas.h>
=2E/arch/ppc64/kernel/iSeries_setup.c:#include <asm/iSeries/ItVpdAreas.h>
+++ ./iSeries/LparMap.h 2 +++
=2E/arch/ppc64/kernel/LparData.c:#include <asm/iSeries/LparMap.h>
=2E/arch/ppc64/kernel/iSeries_setup.c:#include <asm/iSeries/LparMap.h>
+++ ./imalloc.h 2 +++
=2E/arch/ppc64/mm/imalloc.c:#include <asm/imalloc.h>
=2E/arch/ppc64/mm/init.c:#include <asm/imalloc.h>
+++ ./ppc4xx_dma.h 2 +++
=2E/arch/ppc/syslib/ppc4xx_dma.c:#include <asm/ppc4xx_dma.h>
=2E/arch/ppc/syslib/ppc4xx_sgdma.c:#include <asm/ppc4xx_dma.h>
+++ ./xparameters.h 2 +++
=2E/arch/ppc/platforms/4xx/virtex-ii_pro.h:#include <asm/xparameters.h>
=2E/arch/ppc/syslib/xilinx_pic.c:#include <asm/xparameters.h>
+++ ./iSeries/HvCallHpt.h 3 +++
=2E/arch/ppc64/kernel/iSeries_htab.c:#include <asm/iSeries/HvCallHpt.h>
=2E/arch/ppc64/kernel/iSeries_setup.c:#include <asm/iSeries/HvCallHpt.h>
=2E/arch/ppc64/kernel/process.c:#include <asm/iSeries/HvCallHpt.h>
+++ ./iSeries/IoHriProcessorVpd.h 3 +++
=2E/arch/ppc64/kernel/LparData.c:#include <asm/iSeries/IoHriProcessorVpd.h>
=2E/arch/ppc64/kernel/iSeries_proc.c:#include <asm/iSeries/IoHriProcessorVp=
d.h>
=2E/arch/ppc64/kernel/iSeries_setup.c:#include <asm/iSeries/IoHriProcessorV=
pd.h>
+++ ./iSeries/ItExtVpdPanel.h 3 +++
=2E/arch/ppc64/kernel/LparData.c:#include <asm/iSeries/ItExtVpdPanel.h>
=2E/arch/ppc64/kernel/lparcfg.c:#include <asm/iSeries/ItExtVpdPanel.h>
=2E/arch/ppc64/kernel/viopath.c:#include <asm/iSeries/ItExtVpdPanel.h>
+++ ./iSeries/iSeries_irq.h 3 +++
=2E/arch/ppc64/kernel/iSeries_irq.c:#include <asm/iSeries/iSeries_irq.h>
=2E/arch/ppc64/kernel/iSeries_pci.c:#include <asm/iSeries/iSeries_irq.h>
=2E/arch/ppc64/kernel/iSeries_setup.c:#include <asm/iSeries/iSeries_irq.h>
+++ ./ipic.h 3 +++
=2E/arch/ppc/platforms/83xx/mpc834x_sys.c:#include <asm/ipic.h>
=2E/arch/ppc/syslib/ipic.c:#include <asm/ipic.h>
=2E/arch/ppc/syslib/ipic.h:#include <asm/ipic.h>
+++ ./xics.h 3 +++
=2E/arch/ppc64/kernel/pSeries_setup.c:#include <asm/xics.h>
=2E/arch/ppc64/kernel/pSeries_smp.c:#include <asm/xics.h>
=2E/arch/ppc64/kernel/xics.c:#include <asm/xics.h>
+++ ./plpar_wrappers.h 4 +++
=2E/arch/ppc64/kernel/pSeries_iommu.c:#include <asm/plpar_wrappers.h>
=2E/arch/ppc64/kernel/pSeries_lpar.c:#include <asm/plpar_wrappers.h>
=2E/arch/ppc64/kernel/pSeries_setup.c:#include <asm/plpar_wrappers.h>
=2E/arch/ppc64/kernel/pSeries_smp.c:#include <asm/plpar_wrappers.h>
+++ ./prep_nvram.h 4 +++
=2E/arch/ppc/platforms/lopec.c:#include <asm/prep_nvram.h>
=2E/arch/ppc/platforms/pplus.c:#include <asm/prep_nvram.h>
=2E/arch/ppc/platforms/prep_setup.c:#include <asm/prep_nvram.h>
=2E/arch/ppc/syslib/prep_nvram.c:#include <asm/prep_nvram.h>
+++ ./hawk.h 5 +++
=2E/arch/ppc/platforms/mcpn765.c:#include <asm/hawk.h>
=2E/arch/ppc/platforms/mvme5100.c:#include <asm/hawk.h>
=2E/arch/ppc/platforms/pplus.c:#include <asm/hawk.h>
=2E/arch/ppc/platforms/prpmc750.c:#include <asm/hawk.h>
=2E/arch/ppc/syslib/hawk_common.c:#include <asm/hawk.h>
+++ ./hvconsole.h 5 +++
=2E/arch/ppc64/kernel/hvconsole.c:#include <asm/hvconsole.h>
=2E/drivers/char/hvc_console.c:#include <asm/hvconsole.h>
=2E/drivers/char/hvcs.c:#include <asm/hvconsole.h>
=2E/drivers/char/hvsi.c:#include <asm/hvconsole.h>
=2E/drivers/char/hvc_vio.c:#include <asm/hvconsole.h>
+++ ./pSeries_reconfig.h 5 +++
=2E/arch/ppc64/kernel/pSeries_iommu.c:#include <asm/pSeries_reconfig.h>
=2E/arch/ppc64/kernel/pSeries_reconfig.c:#include <asm/pSeries_reconfig.h>
=2E/arch/ppc64/kernel/pSeries_smp.c:#include <asm/pSeries_reconfig.h>
=2E/arch/ppc64/kernel/pci_dn.c:#include <asm/pSeries_reconfig.h>
=2E/arch/ppc64/kernel/prom.c:#include <asm/pSeries_reconfig.h>
+++ ./ibm_ocp_pci.h 6 +++
=2E/arch/ppc/platforms/4xx/ash.c:#include <asm/ibm_ocp_pci.h>
=2E/arch/ppc/platforms/4xx/bubinga.c:#include <asm/ibm_ocp_pci.h>
=2E/arch/ppc/platforms/4xx/ep405.c:#include <asm/ibm_ocp_pci.h>
=2E/arch/ppc/platforms/4xx/sycamore.c:#include <asm/ibm_ocp_pci.h>
=2E/arch/ppc/platforms/4xx/walnut.c:#include <asm/ibm_ocp_pci.h>
=2E/arch/ppc/syslib/ppc405_pci.c:#include <asm/ibm_ocp_pci.h>
+++ ./mv64x60_defs.h 6 +++
=2E/arch/ppc/boot/simple/misc-chestnut.c:#include <asm/mv64x60_defs.h>
=2E/arch/ppc/boot/simple/misc-ev64260.c:#include <asm/mv64x60_defs.h>
=2E/arch/ppc/boot/simple/misc-katana.c:#include <asm/mv64x60_defs.h>
=2E/arch/ppc/boot/simple/misc-mv64x60.c:#include <asm/mv64x60_defs.h>
=2E/arch/ppc/boot/simple/mv64x60_tty.c:#include <asm/mv64x60_defs.h>
=2E/include/asm-ppc/mv64x60.h:#include <asm/mv64x60_defs.h>
+++ ./iSeries/HvCallXm.h 7 +++
=2E/arch/ppc64/kernel/iSeries_iommu.c:#include <asm/iSeries/HvCallXm.h>
=2E/arch/ppc64/kernel/iSeries_irq.c:#include <asm/iSeries/HvCallXm.h>
=2E/arch/ppc64/kernel/iSeries_pci.c:#include <asm/iSeries/HvCallXm.h>
=2E/arch/ppc64/kernel/iSeries_proc.c:#include <asm/iSeries/HvCallXm.h>
=2E/arch/ppc64/kernel/iSeries_setup.c:#include <asm/iSeries/HvCallXm.h>
=2E/arch/ppc64/kernel/vio.c:#include <asm/iSeries/HvCallXm.h>
=2E/arch/ppc64/kernel/time.c:#include <asm/iSeries/HvCallXm.h>
+++ ./ibm405.h 7 +++
=2E/arch/ppc/platforms/4xx/ibm405ep.h:#include <asm/ibm405.h>
=2E/arch/ppc/platforms/4xx/ibm405gp.h:#include <asm/ibm405.h>
=2E/arch/ppc/platforms/4xx/ibm405gpr.h:#include <asm/ibm405.h>
=2E/arch/ppc/platforms/4xx/ibmnp405h.h:#include <asm/ibm405.h>
=2E/arch/ppc/platforms/4xx/ibmstb4.h:#include <asm/ibm405.h>
=2E/arch/ppc/platforms/4xx/ibmstbx25.h:#include <asm/ibm405.h>
=2E/arch/ppc/platforms/4xx/virtex-ii_pro.h:#include <asm/ibm405.h>
+++ ./lppaca.h 7 +++
=2E/arch/ppc64/kernel/LparData.c:#include <asm/lppaca.h>
=2E/arch/ppc64/kernel/asm-offsets.c:#include <asm/lppaca.h>
=2E/arch/ppc64/kernel/iSeries_proc.c:#include <asm/lppaca.h>
=2E/arch/ppc64/kernel/lparcfg.c:#include <asm/lppaca.h>
=2E/arch/ppc64/kernel/pacaData.c:#include <asm/lppaca.h>
=2E/arch/ppc64/kernel/sysfs.c:#include <asm/lppaca.h>
=2E/include/asm-ppc64/paca.h:#include <asm/lppaca.h>
+++ ./iSeries/ItLpQueue.h 8 +++
=2E/arch/ppc64/kernel/ItLpQueue.c:#include <asm/iSeries/ItLpQueue.h>
=2E/arch/ppc64/kernel/LparData.c:#include <asm/iSeries/ItLpQueue.h>
=2E/arch/ppc64/kernel/iSeries_proc.c:#include <asm/iSeries/ItLpQueue.h>
=2E/arch/ppc64/kernel/iSeries_setup.c:#include <asm/iSeries/ItLpQueue.h>
=2E/arch/ppc64/kernel/irq.c:#include <asm/iSeries/ItLpQueue.h>
=2E/arch/ppc64/kernel/mf.c:#include <asm/iSeries/ItLpQueue.h>
=2E/arch/ppc64/kernel/pacaData.c:#include <asm/iSeries/ItLpQueue.h>
=2E/arch/ppc64/kernel/time.c:#include <asm/iSeries/ItLpQueue.h>
+++ ./immap_85xx.h 8 +++
=2E/arch/ppc/platforms/85xx/mpc8540_ads.c:#include <asm/immap_85xx.h>
=2E/arch/ppc/platforms/85xx/mpc8560_ads.c:#include <asm/immap_85xx.h>
=2E/arch/ppc/platforms/85xx/mpc85xx_ads_common.c:#include <asm/immap_85xx.h>
=2E/arch/ppc/platforms/85xx/mpc85xx_cds_common.c:#include <asm/immap_85xx.h>
=2E/arch/ppc/platforms/85xx/sbc8560.c:#include <asm/immap_85xx.h>
=2E/arch/ppc/platforms/85xx/sbc85xx.c:#include <asm/immap_85xx.h>
=2E/arch/ppc/platforms/85xx/stx_gp3.c:#include <asm/immap_85xx.h>
=2E/arch/ppc/syslib/ppc85xx_setup.c:#include <asm/immap_85xx.h>

--nextPart3975808.MQXZzC26Z0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDAxn65t5GS2LDRf4RAs7OAJ44DShiwOs5Ex6DxtLIYFQX1VBPnQCdFxkf
916SUspdXRDnCAEjL0akkZQ=
=+vnx
-----END PGP SIGNATURE-----

--nextPart3975808.MQXZzC26Z0--
