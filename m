Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Sun, 6 Feb 2005 12:57:34 +0100
References: <20050204072254.GA17565@austin.ibm.com>
	<20050205184647.GA17417@austin.ibm.com>
	<20050206032645.GA18845@austin.ibm.com>
In-Reply-To: <20050206032645.GA18845@austin.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Boundary-02=_0YgBCOfG9h2gYcV";
	charset="iso-8859-15"
Message-Id: <200502061257.40798.arnd@arndb.de>
Cc: akpm@osdl.org, trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, hpa@zytor.com
Subject: Re: [PATCH] PPC/PPC64: Abstract cpu_feature checks.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Boundary-02=_0YgBCOfG9h2gYcV
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnndag 06 Februar 2005 04:26, Olof Johansson wrote:
>=20
> Abstract most manual mask checks of cpu_features with cpu_has_feature()
> =A0
Just to get back to the point of consistant naming: In case we do the
other proposed changes as well, is everyone happy with the following
function names?

cpu_has_feature(CPU_FTR_X)	cur_cpu_spec->cpu_features & CPU_FTR_X
cpu_feature_possible(CPU_FTR_X)	CPU_FTR_POSSIBLE_MASK & CPU_FTR_X

fw_has_feature(FW_FEATURE_X)	cur_cpu_spec->fw_features & FW_FTR_X

platform_is(PLATFORM_X)		systemcfg->platform =3D=3D PLATFORM_X
platform_possible(PLATFORM_X)	PLATFORM_POSSIBLE_MASK & PLATFORM_X
platform_compatible(PLATFORM_X)	systemcfg->platform & PLATFORM_X


It's not as consistant as I'd like it to be, but it's the best I could
come up with.

	Arnd <><

--Boundary-02=_0YgBCOfG9h2gYcV
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCBgY05t5GS2LDRf4RAnO4AJ4xhr2vU8CdfRIqHoy+BndYSudGkwCfe/fA
bBX9FXaAJz2WLOEbGGzGyyM=
=dfoX
-----END PGP SIGNATURE-----

--Boundary-02=_0YgBCOfG9h2gYcV--
