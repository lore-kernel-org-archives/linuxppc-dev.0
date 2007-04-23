Return-Path: <krafft@de.ibm.com>
Date: Mon, 23 Apr 2007 20:22:37 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 2/2] powerpc: pmi probe device by device-type
Message-ID: <20070423202237.0725075a@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_Ia2Wf+Sc.Pg1bOKqfHh.h4T;
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

--Sig_Ia2Wf+Sc.Pg1bOKqfHh.h4T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

From: Christian Krafft <krafft@de.ibm.com>
At the moment the pmi device driver is probing for devices with
a given type and a given name. As there may be devices of
the same type but with a different name, probing should be
done also for device type only.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: sdk3/arch/powerpc/sysdev/pmi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- sdk3.orig/arch/powerpc/sysdev/pmi.c
+++ sdk3/arch/powerpc/sysdev/pmi.c
@@ -103,6 +103,7 @@ out:
=20
 static struct of_device_id pmi_match[] =3D {
 	{ .type =3D "ibm,pmi", .name =3D "ibm,pmi" },
+	{ .type =3D "ibm,pmi" },
 	{},
 };
=20


--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Johann Weihen
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294


--Sig_Ia2Wf+Sc.Pg1bOKqfHh.h4T
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGLPlt6rqK4qDx+dcRAg7JAJ91FUf/EF6W5tRZd6eclDbYkiK4sQCg3eLE
kQa1toly1P6g3K/NUG45nfs=
=AqvC
-----END PGP SIGNATURE-----

--Sig_Ia2Wf+Sc.Pg1bOKqfHh.h4T--
