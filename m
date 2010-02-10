Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 10 Feb 2010 21:32:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4 1/3] i2c-mpc: use __devinit[data] for initialization
	functions and data
Message-Id: <20100210213203.48a9105e.sfr@canb.auug.org.au>
In-Reply-To: <4B7285D5.9060008@grandegger.com>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com>
	<fa686aa41002090941je3e4fdqbecf2616a8b90e42@mail.gmail.com>
	<4B7285D5.9060008@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__10_Feb_2010_21_32_03_+1100_6qbkzAYoAYI.ZWNt"
Cc: Devicetree-discuss@lists.ozlabs.org, Linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>, Linuxppc-dev@lists.ozlabs.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__10_Feb_2010_21_32_03_+1100_6qbkzAYoAYI.ZWNt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

On Wed, 10 Feb 2010 11:09:25 +0100 Wolfgang Grandegger <wg@grandegger.com> =
wrote:
>
> > __devinitdata goes at the end, immediately before the '=3D'.  Ditto
> > throughout the file.
>=20
> This made a difference and revealed section mismatches. "const" seems to
> be incompatible with "__devinitdata".

Maybe try no "const" and "__devinitconst" (I am not sure if both will
work).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__10_Feb_2010_21_32_03_+1100_6qbkzAYoAYI.ZWNt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktyiyMACgkQjjKRsyhoI8wgYwCfdC8zV3yrfw6+w0HGXS0vTJmO
RbkAnj1FBCqDMZeJ11SxrZaFI3U9gdDj
=YwsP
-----END PGP SIGNATURE-----

--Signature=_Wed__10_Feb_2010_21_32_03_+1100_6qbkzAYoAYI.ZWNt--
