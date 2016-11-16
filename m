Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJzzC6bwvzDvgC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 09:52:06 +1100 (AEDT)
Message-ID: <1479336718.16599.10.camel@decadent.org.uk>
Subject: Re: [PATCH] cxl: Fix potential build failure - select ANON_INODES
From: Ben Hutchings <ben@decadent.org.uk>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 16 Nov 2016 22:51:58 +0000
In-Reply-To: <f19ce00a-68e3-1f86-94ce-2d5126ec4843@au1.ibm.com>
References: <20161116182916.GF2697@decadent.org.uk>
 <f19ce00a-68e3-1f86-94ce-2d5126ec4843@au1.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-mUPtunYrapgLw3lOk1zS"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-mUPtunYrapgLw3lOk1zS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2016-11-17 at 09:30 +1100, Andrew Donnellan wrote:
> On 17/11/16 05:29, Ben Hutchings wrote:
> > cxl calls anon_inode_get() so must select ANON_INODES.
> >=20
> > Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>=20
> Thanks for catching this.
>=20
> Is this patch still necessary once=C2=A0
> http://patchwork.ozlabs.org/patch/694415/ is applied though?

It doesn't appear to be.

Ben.

--=20
Ben Hutchings
Time is nature's way of making sure that everything doesn't happen at
once.


--=-mUPtunYrapgLw3lOk1zS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlgs4w4ACgkQ57/I7JWG
EQlIXQ/3cY4sexR1Uh3SFlpEIn6W/Rc3K0jKfinxMPxkV2CPD8FFlyapz+89u5f7
HlqUFlZ3sCNcXZb+FyDfaxYhXk4JmCzi/5mTKvroEGfvSziXHzpW2C889Wld8559
muS0NCwgJjssa9gA1bWElqXmwjhB0FbVWpRIdJl9BpKYMPPfFN+qn8EMjAuua1kU
EWelA/2IrPGCxP2kJGX1sDaxzqQGboC3EsGMH6T3uFbJVlT9mrLd+k1rTA9HsyMx
f0SQC5MCoSkyu3faH5EcznyZgTA/UTX03X42JaXlVf588exmVFGCV+KKdz2rzlLE
kTaofM36sZGv4rXbax7SUR3wp3+d/69TqqOMkJwi7nLBn/JJFssf6OsSCba6PuEt
DMtifyJc8CFxRsA4J9kqN0izMLDBrkwixeXATzP+knQR94e4UYvHmXl7NmtKeilF
he08lIguJs5HgGHRbTa8qqIxNmAmJtaF3QVjq+dO0LbqBPQxCrrbCOqikzlm5/+d
saebcJUOxO7ZkWPt71rCWBzGL/OU4J9YHSBeyj1HtS7a5/8FziDP+Kd89o3KCq5x
qTcKD2/zLB1y79DNLIpM2ijIQP/8Ki+NBa+yEvrYyeGcJIh1RcJCvBTdxc1O9I1/
ncu/qSiiJSGtYltQieBKwLtAoAFNSVWXaBbmc39EkCoigUQaIg==
=16kY
-----END PGP SIGNATURE-----

--=-mUPtunYrapgLw3lOk1zS--
