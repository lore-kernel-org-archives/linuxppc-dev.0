Return-Path: <dgibson@ozlabs.org>
Date: Tue, 3 Apr 2012 11:00:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Boyer <jwboyer@gmail.com>, Wolfgang Denk <wd@denx.de>,
 robert.karl.berger@gmail.com,
 Frank =?iso-8859-1?Q?Svendsb=F8e?= <frank.svendsboe@gmail.com>
Subject: Re: [PATCH] powerpc/boot: Only build board support files when
 required.
Message-ID: <20120403010002.GE7481@truffala.fritz.box>
References: <20120403005558.GA9194@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
In-Reply-To: <20120403005558.GA9194@thor.bakeyournoodle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 10:55:59AM +1000, Tony Breeds wrote:
> Currently we build all board files regardless of the final zImage
> target.  This is sub-optimal (in terms on compilation) and leads to
> problems in one platform needlessly causing failures for other
> platforms.

Um.. I believe the one platform breaking another is actually working
as intended.  I think Paulus did it this way to stop people breaking
platforms other than the one they were working on without realising
it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk96S5IACgkQaILKxv3ab8YfowCbB2j4lUjoi2LfrOrLkEWXCvwD
XMEAoIEXXSbnztdMAk7MKzPYo8zoULp3
=blf5
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
