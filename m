Return-Path: <sfr@canb.auug.org.au>
Date: Sun, 15 Jan 2006 16:53:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: will schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: powerpc.git tree
Message-Id: <20060115165323.20bd0df3.sfr@canb.auug.org.au>
In-Reply-To: <43C55852.2060703@vnet.ibm.com>
References: <17348.60119.801379.127209@cargo.ozlabs.ibm.com>
	<43C55852.2060703@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__15_Jan_2006_16_53_23_+1100_wJJmcBF/NEpOpbAl"
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__15_Jan_2006_16_53_23_+1100_wJJmcBF/NEpOpbAl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Wed, 11 Jan 2006 13:11:14 -0600 will schmidt <will_schmidt@vnet.ibm.com>=
 wrote:
>
> Paul Mackerras wrote:
> >=20
> > That means that anyone who is following the powerpc.git tree by doing
> > pulls periodically will need to reset their tree too.  Otherwise each
> > pull will do an unnecessary merge.
>=20
>    By reset, do you mean to delete the local tree and pull a fresh one, o=
r something fancier?

I just did a "git fetch -f powerpc" where my .git/remotes/powerpc points
at the powerpc.git tree on kernel.org.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__15_Jan_2006_16_53_23_+1100_wJJmcBF/NEpOpbAl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDyeNZFdBgD/zoJvwRAn25AJoC1UYZQomGmO5GadNZZ6lirTQ88gCdHCf7
nHgJ+6Qk4gV9eTQh+UI3Ciw=
=OrNE
-----END PGP SIGNATURE-----

--Signature=_Sun__15_Jan_2006_16_53_23_+1100_wJJmcBF/NEpOpbAl--
