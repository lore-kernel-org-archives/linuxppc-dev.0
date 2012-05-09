Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 288A6B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 14:03:56 +1000 (EST)
Date: Wed, 9 May 2012 14:03:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix compile fail in hugetlb cmdline parsing
Message-Id: <20120509140346.29a2940e18748df49051f599@canb.auug.org.au>
In-Reply-To: <1336532658.1714.15.camel@pasglop>
References: <1336401142-18733-1-git-send-email-paul.gortmaker@windriver.com>
 <878vh3cncz.fsf@rustcorp.com.au> <1336532658.1714.15.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__9_May_2012_14_03_46_+1000_3Iji2BOBoHRC8OrQ"
Cc: Jim Cromie <jim.cromie@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Baron <jbaron@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
 Paul Gortmaker <paul.gortmaker@windriver.com>, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__9_May_2012_14_03_46_+1000_3Iji2BOBoHRC8OrQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Wed, 09 May 2012 13:04:18 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> On Tue, 2012-05-08 at 13:53 +0930, Rusty Russell wrote:
> > On Mon,  7 May 2012 10:32:22 -0400, Paul Gortmaker <paul.gortmaker@wind=
river.com> wrote:
> > > Commit 9fb48c744ba6a4bf58b666f4e6fdac3008ea1bd4
> > >=20
> > >     "params: add 3rd arg to option handler callback signature"
> > >=20
> > > added an extra arg to the function, but didn't catch all the use
> > > cases needing it, causing this compile fail in mpc85xx_defconfig:
> > >=20
> > >  arch/powerpc/mm/hugetlbpage.c:316:4: error: passing argument 7 of
> > >  'parse_args' from incompatible pointer type [-Werror]
> > >=20
> > >  include/linux/moduleparam.h:317:12: note: expected
> > > 	 'int (*)(char *, char *, const char *)' but argument is of type
> > > 	 'int (*)(char *, char *)'
> > >=20
> > > This function has no need to printk out the "doing" value, so
> > > just add the arg as an "unused".
> > >=20
> > > Cc: Rusty Russell <rusty@rustcorp.com.au>
> > > Cc: Jim Cromie <jim.cromie@gmail.com>
> > > Cc: Jason Baron <jbaron@redhat.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Becky Bruce <beckyb@kernel.crashing.org>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> >=20
> > Acked-by: Rusty Russell <rusty@rustcorp.com.au>
>=20
> This is for -next right ? IE. I don't seem to have the faulty commit
> in my tree so I can't carry the fix for now.... or am I missing
> something ?

This patch has been added to the driver-core tree which contains the
faulty commit ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__9_May_2012_14_03_46_+1000_3Iji2BOBoHRC8OrQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPqeyiAAoJEECxmPOUX5FEFVEP/2ewVYva3bC2/AQZRZZduRgb
+9snbwFrqGRlRPTjt0H6YqyAo8AFfMnPeG5cCZNyG2dSwiIYg8zzY/Nr9kSoIBph
tmV6jRRjN1OA3RdbXDVj0VFiGzFE0sJMRIw6TfzzPzXs2AGz+FoR712KjWMtsDKU
nX3fC9+GDRwerXANlIaG94gMOzQ99U8MmqQMRleBbZz2sINo3NyFsf3fL9WTRqdB
uMjTGfU6UeTGclqgRN+aA/bmSSzhKQjU5JqZhVb/TeQdtueIubjGXKgVyd3LZXvU
z/UgSmtT9yWDHbHmaICGgb31ShC88wj8HbfPRxGYYPlcDJ7dZB512Y7kKknBjeBF
+yw1LOlhPlqy/17LQkOmaX8FSXaQtLxPXLKypuBSi9Wqs0wCfPqgSzCxGPxevIRb
/JSbcQIQU9VuF2OY2vh+cMBdxfNs0X+70fMTqsZVMUfGew/1lhbGMTlZigKuHftS
K4/43gVYVeeHUtTqgZGyddZMfA7Jn4URvH6svLKEE8JrU17cVkj3CnBIP2CihIm0
5O/W60egfcOR89ZfnnLdLktrYcDajtX+vMJKm3OMt5ctDRZRGom55aYLs50cgwfW
+iTqGf79YhSkjU796Ykf+2iCpd5O7GfxvsTDwklTR8oukQWbDn1uBs+GUFnD/K8B
nFg+wE7phGmQzrh6TJnb
=F6nY
-----END PGP SIGNATURE-----

--Signature=_Wed__9_May_2012_14_03_46_+1000_3Iji2BOBoHRC8OrQ--
