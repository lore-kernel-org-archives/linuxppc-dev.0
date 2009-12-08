Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] powerpc: Reduce differences between pseries and
	ppc64 defconfigs
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20091207034714.GC3421@kryten>
References: <20091207034509.GA3421@kryten> <20091207034555.GB3421@kryten>
	<20091207034714.GC3421@kryten>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-iwfOONgY8KbtCYDknTo7"
Date: Tue, 08 Dec 2009 12:27:21 +1100
Message-ID: <1260235641.4668.1.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-iwfOONgY8KbtCYDknTo7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-12-07 at 14:47 +1100, Anton Blanchard wrote:
> The pseries and ppc64 defconfigs have drifted apart over the years. Reduc=
e
> some of the differences while still keeping the idea that the ppc64 defco=
nfig
> is cross platform but enables fewer features than pseries, eg:
>=20
> - NR_CPUS is lower
> - No NUMA support

Hmm, most of the modern 64 bit platforms are NUMA aren't they? Just a
thought.

cheers


--=-iwfOONgY8KbtCYDknTo7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksdq3UACgkQdSjSd0sB4dLL/ACfdifOCb3woZDn6Aws4szk+nU6
FLIAoLV6ogDPKrTCCjzoIgGsgfqKH45v
=vbZQ
-----END PGP SIGNATURE-----

--=-iwfOONgY8KbtCYDknTo7--
