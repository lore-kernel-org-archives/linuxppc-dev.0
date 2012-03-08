Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 04965B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 14:02:16 +1100 (EST)
Date: Thu, 8 Mar 2012 14:02:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Remove the main legacy iSerie platform code
Message-Id: <20120308140207.03f2ea6256fcd20f36431c10@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__8_Mar_2012_14_02_07_+1100_781nsm6tPzTjpM43"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__8_Mar_2012_14_02_07_+1100_781nsm6tPzTjpM43
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/Makefile                   |    1 -
 arch/powerpc/platforms/iseries/Makefile           |    9 -
 arch/powerpc/platforms/iseries/call_hpt.h         |  102 --
 arch/powerpc/platforms/iseries/call_pci.h         |  309 -----
 arch/powerpc/platforms/iseries/call_sm.h          |   37 -
 arch/powerpc/platforms/iseries/dt.c               |  643 -----------
 arch/powerpc/platforms/iseries/exception.S        |  311 -----
 arch/powerpc/platforms/iseries/exception.h        |   58 -
 arch/powerpc/platforms/iseries/htab.c             |  257 -----
 arch/powerpc/platforms/iseries/hvcall.S           |   94 --
 arch/powerpc/platforms/iseries/hvlog.c            |   35 -
 arch/powerpc/platforms/iseries/hvlpconfig.c       |   39 -
 arch/powerpc/platforms/iseries/iommu.c            |  260 -----
 arch/powerpc/platforms/iseries/ipl_parms.h        |   68 --
 arch/powerpc/platforms/iseries/irq.c              |  400 -------
 arch/powerpc/platforms/iseries/irq.h              |   13 -
 arch/powerpc/platforms/iseries/it_exp_vpd_panel.h |   51 -
 arch/powerpc/platforms/iseries/it_lp_naca.h       |   80 --
 arch/powerpc/platforms/iseries/ksyms.c            |   21 -
 arch/powerpc/platforms/iseries/lpardata.c         |  318 -----
 arch/powerpc/platforms/iseries/lpevents.c         |  341 ------
 arch/powerpc/platforms/iseries/main_store.h       |  165 ---
 arch/powerpc/platforms/iseries/mf.c               | 1275 -----------------=
----
 arch/powerpc/platforms/iseries/misc.S             |   26 -
 arch/powerpc/platforms/iseries/naca.h             |   24 -
 arch/powerpc/platforms/iseries/pci.c              |  919 ---------------
 arch/powerpc/platforms/iseries/pci.h              |   58 -
 arch/powerpc/platforms/iseries/proc.c             |  120 --
 arch/powerpc/platforms/iseries/processor_vpd.h    |   85 --
 arch/powerpc/platforms/iseries/release_data.h     |   63 -
 arch/powerpc/platforms/iseries/setup.c            |  722 ------------
 arch/powerpc/platforms/iseries/setup.h            |   27 -
 arch/powerpc/platforms/iseries/smp.c              |   88 --
 arch/powerpc/platforms/iseries/spcomm_area.h      |   34 -
 arch/powerpc/platforms/iseries/vio.c              |  556 ---------
 arch/powerpc/platforms/iseries/viopath.c          |  677 -----------
 arch/powerpc/platforms/iseries/vpd_areas.h        |   88 --
 37 files changed, 0 insertions(+), 8374 deletions(-)
 delete mode 100644 arch/powerpc/platforms/iseries/Makefile
 delete mode 100644 arch/powerpc/platforms/iseries/call_hpt.h
 delete mode 100644 arch/powerpc/platforms/iseries/call_pci.h
 delete mode 100644 arch/powerpc/platforms/iseries/call_sm.h
 delete mode 100644 arch/powerpc/platforms/iseries/dt.c
 delete mode 100644 arch/powerpc/platforms/iseries/exception.S
 delete mode 100644 arch/powerpc/platforms/iseries/exception.h
 delete mode 100644 arch/powerpc/platforms/iseries/htab.c
 delete mode 100644 arch/powerpc/platforms/iseries/hvcall.S
 delete mode 100644 arch/powerpc/platforms/iseries/hvlog.c
 delete mode 100644 arch/powerpc/platforms/iseries/hvlpconfig.c
 delete mode 100644 arch/powerpc/platforms/iseries/iommu.c
 delete mode 100644 arch/powerpc/platforms/iseries/ipl_parms.h
 delete mode 100644 arch/powerpc/platforms/iseries/irq.c
 delete mode 100644 arch/powerpc/platforms/iseries/irq.h
 delete mode 100644 arch/powerpc/platforms/iseries/it_exp_vpd_panel.h
 delete mode 100644 arch/powerpc/platforms/iseries/it_lp_naca.h
 delete mode 100644 arch/powerpc/platforms/iseries/ksyms.c
 delete mode 100644 arch/powerpc/platforms/iseries/lpardata.c
 delete mode 100644 arch/powerpc/platforms/iseries/lpevents.c
 delete mode 100644 arch/powerpc/platforms/iseries/main_store.h
 delete mode 100644 arch/powerpc/platforms/iseries/mf.c
 delete mode 100644 arch/powerpc/platforms/iseries/misc.S
 delete mode 100644 arch/powerpc/platforms/iseries/naca.h
 delete mode 100644 arch/powerpc/platforms/iseries/pci.c
 delete mode 100644 arch/powerpc/platforms/iseries/pci.h
 delete mode 100644 arch/powerpc/platforms/iseries/proc.c
 delete mode 100644 arch/powerpc/platforms/iseries/processor_vpd.h
 delete mode 100644 arch/powerpc/platforms/iseries/release_data.h
 delete mode 100644 arch/powerpc/platforms/iseries/setup.c
 delete mode 100644 arch/powerpc/platforms/iseries/setup.h
 delete mode 100644 arch/powerpc/platforms/iseries/smp.c
 delete mode 100644 arch/powerpc/platforms/iseries/spcomm_area.h
 delete mode 100644 arch/powerpc/platforms/iseries/vio.c
 delete mode 100644 arch/powerpc/platforms/iseries/viopath.c
 delete mode 100644 arch/powerpc/platforms/iseries/vpd_areas.h

This is a git style diff (so does not contain the old contents of the
deleted files).

diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makef=
ile
index 2635a22..879b4a4 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_FSL_SOC_BOOKE)	+=3D 85xx/
 obj-$(CONFIG_PPC_86xx)		+=3D 86xx/
 obj-$(CONFIG_PPC_POWERNV)	+=3D powernv/
 obj-$(CONFIG_PPC_PSERIES)	+=3D pseries/
-obj-$(CONFIG_PPC_ISERIES)	+=3D iseries/
 obj-$(CONFIG_PPC_MAPLE)		+=3D maple/
 obj-$(CONFIG_PPC_PASEMI)	+=3D pasemi/
 obj-$(CONFIG_PPC_CELL)		+=3D cell/
diff --git a/arch/powerpc/platforms/iseries/Makefile b/arch/powerpc/platfor=
ms/iseries/Makefile
deleted file mode 100644
index a7602b1..0000000
diff --git a/arch/powerpc/platforms/iseries/call_hpt.h b/arch/powerpc/platf=
orms/iseries/call_hpt.h
deleted file mode 100644
index 8d95fe4b..0000000
diff --git a/arch/powerpc/platforms/iseries/call_pci.h b/arch/powerpc/platf=
orms/iseries/call_pci.h
deleted file mode 100644
index dbdf698..0000000
diff --git a/arch/powerpc/platforms/iseries/call_sm.h b/arch/powerpc/platfo=
rms/iseries/call_sm.h
deleted file mode 100644
index c7e2516..0000000
diff --git a/arch/powerpc/platforms/iseries/dt.c b/arch/powerpc/platforms/i=
series/dt.c
deleted file mode 100644
index f0491cc..0000000
diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/plat=
forms/iseries/exception.S
deleted file mode 100644
index f519ee1..0000000
diff --git a/arch/powerpc/platforms/iseries/exception.h b/arch/powerpc/plat=
forms/iseries/exception.h
deleted file mode 100644
index 50271b5..0000000
diff --git a/arch/powerpc/platforms/iseries/htab.c b/arch/powerpc/platforms=
/iseries/htab.c
deleted file mode 100644
index 3ae66ab..0000000
diff --git a/arch/powerpc/platforms/iseries/hvcall.S b/arch/powerpc/platfor=
ms/iseries/hvcall.S
deleted file mode 100644
index 07ae6ad..0000000
diff --git a/arch/powerpc/platforms/iseries/hvlog.c b/arch/powerpc/platform=
s/iseries/hvlog.c
deleted file mode 100644
index f476d71..0000000
diff --git a/arch/powerpc/platforms/iseries/hvlpconfig.c b/arch/powerpc/pla=
tforms/iseries/hvlpconfig.c
deleted file mode 100644
index f62a0c5..0000000
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platform=
s/iseries/iommu.c
deleted file mode 100644
index 2f3d911..0000000
diff --git a/arch/powerpc/platforms/iseries/ipl_parms.h b/arch/powerpc/plat=
forms/iseries/ipl_parms.h
deleted file mode 100644
index 83e4ca4..0000000
diff --git a/arch/powerpc/platforms/iseries/irq.c b/arch/powerpc/platforms/=
iseries/irq.c
deleted file mode 100644
index b210345..0000000
diff --git a/arch/powerpc/platforms/iseries/irq.h b/arch/powerpc/platforms/=
iseries/irq.h
deleted file mode 100644
index a1c2360..0000000
diff --git a/arch/powerpc/platforms/iseries/it_exp_vpd_panel.h b/arch/power=
pc/platforms/iseries/it_exp_vpd_panel.h
deleted file mode 100644
index 6de9097..0000000
diff --git a/arch/powerpc/platforms/iseries/it_lp_naca.h b/arch/powerpc/pla=
tforms/iseries/it_lp_naca.h
deleted file mode 100644
index cf6dcf6..0000000
diff --git a/arch/powerpc/platforms/iseries/ksyms.c b/arch/powerpc/platform=
s/iseries/ksyms.c
deleted file mode 100644
index 997e234..0000000
diff --git a/arch/powerpc/platforms/iseries/lpardata.c b/arch/powerpc/platf=
orms/iseries/lpardata.c
deleted file mode 100644
index 00e0ec8..0000000
diff --git a/arch/powerpc/platforms/iseries/lpevents.c b/arch/powerpc/platf=
orms/iseries/lpevents.c
deleted file mode 100644
index 202e227..0000000
diff --git a/arch/powerpc/platforms/iseries/main_store.h b/arch/powerpc/pla=
tforms/iseries/main_store.h
deleted file mode 100644
index 1a7a3f5..0000000
diff --git a/arch/powerpc/platforms/iseries/mf.c b/arch/powerpc/platforms/i=
series/mf.c
deleted file mode 100644
index 254c1fc..0000000
diff --git a/arch/powerpc/platforms/iseries/misc.S b/arch/powerpc/platforms=
/iseries/misc.S
deleted file mode 100644
index 2c6ff0f..0000000
diff --git a/arch/powerpc/platforms/iseries/naca.h b/arch/powerpc/platforms=
/iseries/naca.h
deleted file mode 100644
index f01708e..0000000
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/=
iseries/pci.c
deleted file mode 100644
index c754128..0000000
diff --git a/arch/powerpc/platforms/iseries/pci.h b/arch/powerpc/platforms/=
iseries/pci.h
deleted file mode 100644
index d9cf974..0000000
diff --git a/arch/powerpc/platforms/iseries/proc.c b/arch/powerpc/platforms=
/iseries/proc.c
deleted file mode 100644
index 0676368..0000000
diff --git a/arch/powerpc/platforms/iseries/processor_vpd.h b/arch/powerpc/=
platforms/iseries/processor_vpd.h
deleted file mode 100644
index 7ac5d0d..0000000
diff --git a/arch/powerpc/platforms/iseries/release_data.h b/arch/powerpc/p=
latforms/iseries/release_data.h
deleted file mode 100644
index 6ad7d84..0000000
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platform=
s/iseries/setup.c
deleted file mode 100644
index 8fc6258..0000000
diff --git a/arch/powerpc/platforms/iseries/setup.h b/arch/powerpc/platform=
s/iseries/setup.h
deleted file mode 100644
index 729754b..0000000
diff --git a/arch/powerpc/platforms/iseries/smp.c b/arch/powerpc/platforms/=
iseries/smp.c
deleted file mode 100644
index 02df49f..0000000
diff --git a/arch/powerpc/platforms/iseries/spcomm_area.h b/arch/powerpc/pl=
atforms/iseries/spcomm_area.h
deleted file mode 100644
index 598b7c1..0000000
diff --git a/arch/powerpc/platforms/iseries/vio.c b/arch/powerpc/platforms/=
iseries/vio.c
deleted file mode 100644
index 04be62d..0000000
diff --git a/arch/powerpc/platforms/iseries/viopath.c b/arch/powerpc/platfo=
rms/iseries/viopath.c
deleted file mode 100644
index 40dad08..0000000
diff --git a/arch/powerpc/platforms/iseries/vpd_areas.h b/arch/powerpc/plat=
forms/iseries/vpd_areas.h
deleted file mode 100644
index feb001f..0000000
--=20
1.7.9.1

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__8_Mar_2012_14_02_07_+1100_781nsm6tPzTjpM43
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPWCEvAAoJEECxmPOUX5FEbOsP/j2wX+YBbAGvavc6NFnhrSMv
SHUUWI2RYMyaTrKROIIPwpSSlcZrp56Hn6ETbzz8UuKnvvkPjHiBtEHh73JQyugU
MhyYPuyiToTCphfGffPvyOHFj8bF2VBYEWGqZuxC5dHx7lBnc0YsbkOrjZIdXiyt
U3rtBn3JigrMaIib8TP/eE6TamIFJ2WpYvJrUcPfwejwv1v3dBunyFZ2N/yWVEYc
xzLwt1dX+TkVsQxvf6U9HC4NoIWSsEWpNcQcof/buqVNJ61IC4u3DEnxMUlysW35
lTQol+VT3Uhw+Z9d3Y1m5Vs98Cyss+TDabBAY8S9VKagkEj0pk6M/zehZ3cTdWXk
ciwDUNOmXmsQoMy29bCafOYHLzQC5p+hWDAL+MvXIr85tRNLZV9kzym4ZE4QTOpa
A2OkNv9sG/+3PlnupFcfQhSv1ZwQIZnxubnGrZ6qDr9xzyOYa1OOknn5gGMQs8Uw
ldh1lS+HF4I6HwYLpxSwcf9e90D+L/IfO27f2b2s9BEBmCOpaNxeWoTcrM4coXTV
faqIeRN6j68A3X4aJQnenWyxd4wpyHooVZ4h75VImr7y/11+Te2EAtNW93ACUVHR
8lPOjsz02yTapjV/CxZxEqgYNs802xKn7L096iUAel6nSeF2oPt6jcdInkRC+9Lt
TxMbqXeVc3t2rtbb9ujI
=yMDT
-----END PGP SIGNATURE-----

--Signature=_Thu__8_Mar_2012_14_02_07_+1100_781nsm6tPzTjpM43--
