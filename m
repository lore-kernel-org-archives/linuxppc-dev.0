Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 23 Aug 2005 17:31:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <20050823173142.4f620d75.sfr@canb.auug.org.au>
In-Reply-To: <1124775707.5159.92.camel@gaston>
References: <20050822141235.GA7110@austin.ibm.com>
	<0F51EC83-8969-4083-B0D7-9343D075B635@freescale.com>
	<1124775707.5159.92.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__23_Aug_2005_17_31_42_+1000_RcD+blDwotFvUZ2J"
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH 3/3] Move all the very similar files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__23_Aug_2005_17_31_42_+1000_RcD+blDwotFvUZ2J
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Aug 2005 15:41:47 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> Most of the ones that are in include/asm* are there because drivers
> outside of arch/* use them.

Indeed.  Here is the result of grepping for all of the .h files in patch 3 =
(minus the
obvious noncontentious ones like errno.h ...):

asm/dbdma.h
-----------------------------------------------------------
arch/ppc/platforms/pmac_feature.c:#include <asm/dbdma.h>
arch/ppc64/kernel/pmac_feature.c:#include <asm/dbdma.h>
drivers/block/swim3.c:#include <asm/dbdma.h>
drivers/ide/ppc/pmac.c:#include <asm/dbdma.h>
drivers/media/video/planb.c:#include <asm/dbdma.h>
drivers/media/video/planb.h:#include <asm/dbdma.h>
drivers/net/bmac.c:#include <asm/dbdma.h>
drivers/net/mace.c:#include <asm/dbdma.h>
drivers/scsi/mac53c94.c:#include <asm/dbdma.h>
drivers/scsi/mesh.c:#include <asm/dbdma.h>
drivers/serial/pmac_zilog.c:#include <asm/dbdma.h>
sound/oss/dmasound/dmasound_awacs.c:#include <asm/dbdma.h>
sound/ppc/pmac.h:#include <asm/dbdma.h>
-----------------------------------------------------------
asm/keylargo.h
-----------------------------------------------------------
arch/ppc/platforms/pmac_cpufreq.c:#include <asm/keylargo.h>
arch/ppc/platforms/pmac_feature.c:#include <asm/keylargo.h>
arch/ppc/platforms/pmac_low_i2c.c:#include <asm/keylargo.h>
arch/ppc/platforms/pmac_smp.c:#include <asm/keylargo.h>
arch/ppc64/kernel/pmac_feature.c:#include <asm/keylargo.h>
arch/ppc64/kernel/pmac_low_i2c.c:#include <asm/keylargo.h>
arch/ppc64/kernel/pmac_smp.c:#include <asm/keylargo.h>
drivers/macintosh/mediabay.c:#include <asm/keylargo.h>
-----------------------------------------------------------
asm/macio.h
-----------------------------------------------------------
drivers/macintosh/macio_asic.c:#include <asm/macio.h>
drivers/macintosh/macio_sysfs.c:#include <asm/macio.h>
drivers/macintosh/therm_pm72.c:#include <asm/macio.h>
drivers/macintosh/therm_windtunnel.c:#include <asm/macio.h>
drivers/net/bmac.c:#include <asm/macio.h>
drivers/net/mace.c:#include <asm/macio.h>
drivers/scsi/mac53c94.c:#include <asm/macio.h>
drivers/scsi/mesh.c:#include <asm/macio.h>
drivers/serial/pmac_zilog.c:#include <asm/macio.h>
include/asm-powerpc/pmac_feature.h:#include <asm/macio.h>
-----------------------------------------------------------
asm/of_device.h
-----------------------------------------------------------
arch/ppc/platforms/pmac_setup.c:#include <asm/of_device.h>
arch/ppc/syslib/of_device.c:#include <asm/of_device.h>
arch/ppc64/kernel/maple_setup.c:#include <asm/of_device.h>
arch/ppc64/kernel/of_device.c:#include <asm/of_device.h>
arch/ppc64/kernel/pmac_setup.c:#include <asm/of_device.h>
drivers/macintosh/therm_adt746x.c:#include <asm/of_device.h>
drivers/macintosh/therm_pm72.c:#include <asm/of_device.h>
drivers/macintosh/therm_windtunnel.c:#include <asm/of_device.h>
drivers/video/platinumfb.c:#include <asm/of_device.h>
include/asm-powerpc/macio.h:#include <asm/of_device.h>
-----------------------------------------------------------
asm/parport.h
-----------------------------------------------------------
drivers/parport/ChangeLog:	* parport_pc.c (parport_pc_init): Moved from asm=
/parport.h.
drivers/parport/parport_pc.c:#include <asm/parport.h>
drivers/parport/parport_pc.c:/* This is called by parport_pc_find_nonpci_po=
rts (in asm/parport.h) */
drivers/parport/parport_pc.c:	/* ISA ports and whatever (see asm/parport.h)=
. */
-----------------------------------------------------------
asm/pmac_feature.h
-----------------------------------------------------------
arch/ppc/kernel/ppc_ksyms.c:#include <asm/pmac_feature.h>
arch/ppc/kernel/setup.c:#include <asm/pmac_feature.h>
arch/ppc/platforms/pmac_cpufreq.c:#include <asm/pmac_feature.h>
arch/ppc/platforms/pmac_feature.c:#include <asm/pmac_feature.h>
arch/ppc/platforms/pmac_pci.c:#include <asm/pmac_feature.h>
arch/ppc/platforms/pmac_pic.c:#include <asm/pmac_feature.h>
arch/ppc/platforms/pmac_setup.c:#include <asm/pmac_feature.h>
arch/ppc/platforms/pmac_smp.c:#include <asm/pmac_feature.h>
arch/ppc/xmon/start.c:#include <asm/pmac_feature.h>
arch/ppc64/kernel/bpa_iommu.c:#include <asm/pmac_feature.h>
arch/ppc64/kernel/pci_direct_iommu.c:#include <asm/pmac_feature.h>
arch/ppc64/kernel/pmac_feature.c:#include <asm/pmac_feature.h>
arch/ppc64/kernel/pmac_pci.c:#include <asm/pmac_feature.h>
arch/ppc64/kernel/pmac_setup.c:#include <asm/pmac_feature.h>
arch/ppc64/kernel/pmac_smp.c:#include <asm/pmac_feature.h>
arch/ppc64/kernel/udbg.c:#include <asm/pmac_feature.h>
drivers/block/swim3.c:#include <asm/pmac_feature.h>
drivers/char/agp/uninorth-agp.c:#include <asm/pmac_feature.h>
drivers/i2c/busses/i2c-keywest.c:#include <asm/pmac_feature.h>
drivers/ide/ppc/pmac.c:#include <asm/pmac_feature.h>
drivers/ieee1394/ohci1394.c:#include <asm/pmac_feature.h>
drivers/macintosh/adbhid.c:#include <asm/pmac_feature.h>
drivers/macintosh/macio_asic.c:#include <asm/pmac_feature.h>
drivers/macintosh/mediabay.c:#include <asm/pmac_feature.h>
drivers/macintosh/smu.c:#include <asm/pmac_feature.h>
drivers/macintosh/via-pmu.c:#include <asm/pmac_feature.h>
drivers/net/bmac.c:#include <asm/pmac_feature.h>
drivers/net/sungem.c:#include <asm/pmac_feature.h>
drivers/net/wireless/airport.c:#include <asm/pmac_feature.h>
drivers/scsi/mesh.c:#include <asm/pmac_feature.h>
drivers/serial/pmac_zilog.c:#include <asm/pmac_feature.h>
drivers/usb/host/ohci-pci.c:#include <asm/pmac_feature.h>
drivers/video/aty/aty128fb.c:#include <asm/pmac_feature.h>
drivers/video/aty/radeon_pm.c:#include <asm/pmac_feature.h>
sound/oss/dmasound/dmasound_awacs.c:#include <asm/pmac_feature.h>
sound/ppc/pmac.c:#include <asm/pmac_feature.h>
sound/ppc/toonie.c:#include <asm/pmac_feature.h>
sound/ppc/tumbler.c:#include <asm/pmac_feature.h>
-----------------------------------------------------------
asm/pmac_low_i2c.h
-----------------------------------------------------------
arch/ppc/platforms/pmac_feature.c:#include <asm/pmac_low_i2c.h>
arch/ppc/platforms/pmac_low_i2c.c:#include <asm/pmac_low_i2c.h>
arch/ppc64/kernel/pmac_feature.c:#include <asm/pmac_low_i2c.h>
arch/ppc64/kernel/pmac_low_i2c.c:#include <asm/pmac_low_i2c.h>
arch/ppc64/kernel/pmac_smp.c:#include <asm/pmac_low_i2c.h>
drivers/i2c/busses/i2c-keywest.c:#include <asm/pmac_low_i2c.h>
-----------------------------------------------------------
asm/uninorth.h
-----------------------------------------------------------
arch/ppc/platforms/pmac_feature.c:#include <asm/uninorth.h>
arch/ppc/platforms/pmac_low_i2c.c:#include <asm/uninorth.h>
arch/ppc64/kernel/pmac_feature.c:#include <asm/uninorth.h>
arch/ppc64/kernel/pmac_low_i2c.c:#include <asm/uninorth.h>
drivers/char/agp/uninorth-agp.c:#include <asm/uninorth.h>
-----------------------------------------------------------

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__23_Aug_2005_17_31_42_+1000_RcD+blDwotFvUZ2J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDCtDeFdBgD/zoJvwRApkSAJ4pD6Mq5Sl0AMjYEqIomikVRClaywCfY779
pNLzy0DeUoC4pCfvAyAohc0=
=6NVQ
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Aug_2005_17_31_42_+1000_RcD+blDwotFvUZ2J--
