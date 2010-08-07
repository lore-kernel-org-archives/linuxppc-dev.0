Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CC693B70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Aug 2010 10:01:29 +1000 (EST)
Date: Sat, 7 Aug 2010 10:01:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: fix i8042 module build error
Message-Id: <20100807100123.886d3a1e.sfr@canb.auug.org.au>
In-Reply-To: <20100806183839.32149.6238.stgit@angua>
References: <20100806183839.32149.6238.stgit@angua>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__7_Aug_2010_10_01_23_+1000_h7yU75tYK415Jix7"
Cc: martyn.welch@ge.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sat__7_Aug_2010_10_01_23_+1000_h7yU75tYK415Jix7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Fri, 06 Aug 2010 12:42:12 -0600 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> of_i8042_{kbd,aux}_irq needs to be exported
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>=20
> Stephen and Ben, this fixes up the build error in linux-next.  If you pre=
fer,
> I can stuff this patch into my next-powerpc branch.  Ben, I've got other
> commits in that branch that I'll be sending to you early next week anyway.

This failure also exists in Linus' tree, so the earlier this goes to
Linus the better.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__7_Aug_2010_10_01_23_+1000_h7yU75tYK415Jix7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMXKJTAAoJEDMEi1NhKgbsrzwH/1ZVxTjt9f3v9ETaRAEmLDro
fw0rdgvEOmJvEhteuNiSugY4zZddc45uy9yssPOV8sZHmzOiGFzoyFOaGPzE7jZU
c+o917LCUysUaGNuLk9j1tX4lY2jjMMGUpHbivAvUdaZEdZ8YKVzx5w4o7r/tP1K
7Ate55zuCY+4NS39knWWkblgtn500jIFC1GDXiMO0YcCRUkTGmiVFowJ7hm49771
aYmDzjaOO9HQUM/l6G4HKvnwjxaC8sCL+xOE59aDh9a1bDuTV365kn67ZutREUGi
hO5MY9WK1esh30xO/30wUVcX7xo9PHZo/RJHULRKF1hOtpP/Ps6ZTjqQfAgXObE=
=5LVf
-----END PGP SIGNATURE-----

--Signature=_Sat__7_Aug_2010_10_01_23_+1000_h7yU75tYK415Jix7--
