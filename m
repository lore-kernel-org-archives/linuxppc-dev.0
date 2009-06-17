Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9A090B725D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 23:23:45 +1000 (EST)
Date: Wed, 17 Jun 2009 23:23:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][Resend 2][BUILD FAILURE 04/04] Next June 04:PPC64
	randconfig [drivers/net/ucc_geth.o]
Message-Id: <20090617232341.c4543ff2.sfr@canb.auug.org.au>
In-Reply-To: <6E26D0A1-0FE5-4179-9DA8-FDF0E3D417DA@kernel.crashing.org>
References: <20090611033705.20842.75501.sendpatchset@subratamodak.linux.ibm.com>
	<1245048719.5239.10.camel@subratamodak.linux.ibm.com>
	<1245243097.4870.3.camel@subratamodak.linux.ibm.com>
	<6E26D0A1-0FE5-4179-9DA8-FDF0E3D417DA@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__17_Jun_2009_23_23_41_+1000_.izVW4hEBDoJIIBE"
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, netdev@vger.kernel.org,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>,
	Nathan Lynch <ntl@pobox.com>, Tony,
	Li Yang <leoli@freescale.com>, subrata@linux.vnet.ibm.com,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__17_Jun_2009_23_23_41_+1000_.izVW4hEBDoJIIBE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Wed, 17 Jun 2009 08:07:47 -0500 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
>=20
> I'm confused by the proposed fix as we already have *mdio & *ph =20
> defined in this function:

Which tree are you looking at?  Linus' tree, and linux-next, do not have
those local variables ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__17_Jun_2009_23_23_41_+1000_.izVW4hEBDoJIIBE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko47l0ACgkQjjKRsyhoI8z1OgCgqkPf9dXeSPtNV2LlDOCBzfGn
VaUAoJedD4+E4MU3dN11tRAzwqt/7AxN
=Cphp
-----END PGP SIGNATURE-----

--Signature=_Wed__17_Jun_2009_23_23_41_+1000_.izVW4hEBDoJIIBE--
