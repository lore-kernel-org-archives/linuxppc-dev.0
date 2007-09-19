Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7400EDDE2B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 16:56:42 +1000 (EST)
Date: Wed, 19 Sep 2007 16:56:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: travis@sgi.com
Subject: Re: [PATCH 1/1] ppc64: Convert cpu_sibling_map to a per_cpu data
	array ppc64 v2
Message-Id: <20070919165623.8a59f4dd.sfr@canb.auug.org.au>
In-Reply-To: <20070917183507.506104000@sgi.com>
References: <20070917183507.332345000@sgi.com>
	<20070917183507.506104000@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__19_Sep_2007_16_56_23_+1000_I.2xQApTY_b1iczd"
Cc: linux-mm@kvack.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__19_Sep_2007_16_56_23_+1000_I.2xQApTY_b1iczd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Mon, 17 Sep 2007 11:35:08 -0700 travis@sgi.com wrote:
>
> v2:=20
>=20
> This patch applies after:
>=20
> 	convert-cpu_sibling_map-to-a-per_cpu-data-array-ppc64.patch
>=20
> and should fix the "reference cpu_sibling_map before setup_per_cpu_areas()
> has been called" problem.  In addtion, the cpu_sibiling_map macro has been
> removed [this was missed in my original submission.]

This one make it work, thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__19_Sep_2007_16_56_23_+1000_I.2xQApTY_b1iczd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG8MggTgG2atn1QN8RAg/qAJ4+XjXxXxwprLwXZuKNOD0jdLARgACdG056
Ai/YzTQTgEZk3/c/IlVva5w=
=vBAz
-----END PGP SIGNATURE-----

--Signature=_Wed__19_Sep_2007_16_56_23_+1000_I.2xQApTY_b1iczd--
