Return-Path: <krafft@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34E1DDDFF6
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 04:28:21 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id m1DHSGHj025328
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 17:28:16 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m1DHSGe12195668
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 18:28:16 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m1DHSGA0025468
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 18:28:16 +0100
Date: Wed, 13 Feb 2008 18:28:00 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [Patch 0/2] add check_legacy_ioport calls to prevent oops
Message-ID: <20080213182800.5c6940a8@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SZZ6uCqtwy11xHhoEwyju4+";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: parabelboi@bopserverein.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_/SZZ6uCqtwy11xHhoEwyju4+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

the following two patches prevent kernel from crashing on powerpc.
The surrounding ifdefs will be obsolete, if check_legacy_ioport becomes
generic code.


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

--Sig_/SZZ6uCqtwy11xHhoEwyju4+
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFHsyiw6rqK4qDx+dcRAoIvAJ9w1s5v2gHg0k1qrA5RQ3E9rUKABgCaAzCx
lrEY306uD08TWw5tv2aOvUI=
=U3qV
-----END PGP SIGNATURE-----

--Sig_/SZZ6uCqtwy11xHhoEwyju4+--
