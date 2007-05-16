Return-Path: <krafft@de.ibm.com>
Date: Wed, 16 May 2007 02:33:21 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: cell_defconfig: disable cpufreq and pmi
Message-ID: <20070516023321.78f009f2@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_w37PHrMSx7kdHlfLK80=89Q";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: krafft@de.ibm.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_w37PHrMSx7kdHlfLK80=89Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

From: Christian Krafft <krafft@de.ibm.com>

Cpufreq using pmi is broken by a dependency issue, that
will be fixed in a seperate patch.
Bare-metal cpufreq is broken by hardware limitations.
As it was the only user, pmi is disabled as well.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux/arch/powerpc/configs/cell_defconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/powerpc/configs/cell_defconfig
+++ linux/arch/powerpc/configs/cell_defconfig
@@ -163,7 +163,6 @@ CONFIG_SPU_FS=3Dm
 CONFIG_SPU_BASE=3Dy
 CONFIG_CBE_RAS=3Dy
 CONFIG_CBE_THERM=3Dm
-CONFIG_CBE_CPUFREQ=3Dm
 CONFIG_PPC_NATIVE=3Dy
 CONFIG_UDBG_RTAS_CONSOLE=3Dy
 CONFIG_PPC_UDBG_BEAT=3Dy
@@ -172,24 +171,12 @@ CONFIG_PPC_RTAS=3Dy
 # CONFIG_RTAS_ERROR_LOGGING is not set
 CONFIG_RTAS_PROC=3Dy
 CONFIG_RTAS_FLASH=3Dy
-CONFIG_PPC_PMI=3Dm
+# CONFIG_PPC_PMI is not set
 CONFIG_MMIO_NVRAM=3Dy
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_PPC_970_NAP is not set
 CONFIG_PPC_INDIRECT_IO=3Dy
 CONFIG_GENERIC_IOMAP=3Dy
-CONFIG_CPU_FREQ=3Dy
-CONFIG_CPU_FREQ_TABLE=3Dy
-CONFIG_CPU_FREQ_DEBUG=3Dy
-CONFIG_CPU_FREQ_STAT=3Dy
-# CONFIG_CPU_FREQ_STAT_DETAILS is not set
-CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
-# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
-CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
-CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
-CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
-CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
-CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
 # CONFIG_CPU_FREQ_PMAC64 is not set
 # CONFIG_WANT_EARLY_SERIAL is not set
 CONFIG_MPIC=3Dy


--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294


--Sig_w37PHrMSx7kdHlfLK80=89Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSlFf6rqK4qDx+dcRAlt2AKCX9tpJtfCRW1uK3D0nbUTBD6DE0QCgj2ca
QDxxgaB/1yyDhTRzSpohfyM=
=grMr
-----END PGP SIGNATURE-----

--Sig_w37PHrMSx7kdHlfLK80=89Q--
