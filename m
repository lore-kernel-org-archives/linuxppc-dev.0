Return-Path: <arnd@arndb.de>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com",
	Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 58CDF67A46
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Feb 2005 06:15:43 +1100 (EST)
Received: from e31.co.us.ibm.com (e31.esmtp.ibm.com [9.14.4.129])
	by pokfb.esmtp.ibm.com (8.12.10/8.12.10) with ESMTP id j14J76gB029242
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Feb 2005 14:07:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: olof@austin.ibm.com (Olof Johansson)
Date: Fri, 4 Feb 2005 19:57:06 +0100
References: <20050204072254.GA17565@austin.ibm.com>
	<200502041336.59892.arnd@arndb.de>
	<20050204183514.GB17586@austin.ibm.com>
In-Reply-To: <20050204183514.GB17586@austin.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Boundary-02=_CW8ACUJ5uRR8DhR";
	charset="iso-8859-15"
Message-Id: <200502041957.06979.arnd@arndb.de>
Cc: akpm@osdl.org, trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, hpa@zytor.com,
	linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Boundary-02=_CW8ACUJ5uRR8DhR
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freedag 04 Februar 2005 19:35, Olof Johansson wrote:
> pSeries will need all cpus enabled since we have them all on various
> machines, etc. I guess Powermac/Maple could benefit from it.

Even on pSeries, we already have CONFIG_POWER4_ONLY, which could be
used to optimize away some of the checks at compile time.

I think it makes sense to extend this a bit to look more like the CPU
selection on i386 or s390 where can set the oldest CPU you want to
support. This also fits nicely with the gcc -mcpu=3D options.

> In the end it depends on how hairy the implementation would get vs=20
> performance improvement.

=46ortunately, that optimization should be easy to do on top of your
patch, so we don't have to decide now.

	Arnd <><

--Boundary-02=_CW8ACUJ5uRR8DhR
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCA8WC5t5GS2LDRf4RAmGxAJ9zivMYwnsLAzVCEqkcRSgd9eT4yQCaA/fo
N87nLOWitDYUyyYJD/hrNBA=
=i9zW
-----END PGP SIGNATURE-----

--Boundary-02=_CW8ACUJ5uRR8DhR--
