Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 79029B6FE2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2012 11:57:40 +1000 (EST)
Date: Tue, 3 Apr 2012 11:57:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] powerpc/boot: Only build board support files when
 required.
Message-Id: <20120403115735.cc214fc343786fd43a4c2fe8@canb.auug.org.au>
In-Reply-To: <20120403015508.GC9194@thor.bakeyournoodle.com>
References: <20120403005558.GA9194@thor.bakeyournoodle.com>
 <20120403114150.cbf53c999ed842b25e9932b5@canb.auug.org.au>
 <20120403015508.GC9194@thor.bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__3_Apr_2012_11_57_35_+1000_2XlSbeBbAg8sUDi+"
Cc: Frank =?UTF-8?B?U3ZlbmRzYsO4ZQ==?= <frank.svendsboe@gmail.com>,
 Wolfgang Denk <wd@denx.de>, robert.karl.berger@gmail.com,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__3_Apr_2012_11_57_35_+1000_2XlSbeBbAg8sUDi+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Tue, 3 Apr 2012 11:55:08 +1000 Tony Breeds <tony@bakeyournoodle.com> wro=
te:
>
> On Tue, Apr 03, 2012 at 11:41:50AM +1000, Stephen Rothwell wrote:
>=20
> > It is more ususal in the kernel makefiles to do something like:
> >=20
> > src-wlib-$(CONFIG_40x) +=3D 4xx.c planetcore.c
> > src-plat-$(CONFIG_40x) +=3D fixed-head.S ep405.c cuboot-hotfoot.c treeb=
oot-walnut.c \
>=20
> Gah you are right.  How about this.

Looks better to me.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__3_Apr_2012_11_57_35_+1000_2XlSbeBbAg8sUDi+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPelkPAAoJEECxmPOUX5FEi84P/1y6/KIQWMN/rKIDuky01IVB
EMbpnQzkE11reUvt6OgXG7VPuw25BBZHfYGRD65VCdpL0b8ksQyDM58BZzD9ECSX
opkDla8lH8Ci5eu0fCVmuQbiVUA/snFdDslRh8CODwDMdu2v891NxcVU/mNktS4y
F4KNBgIU14wTH8kwK+nSKQyuWQhFsmTgSmoSCuDP3qcIYVNk6I9csDK6I5/xVzTC
EHlPzIdtP1UtGD4oY1qn+/B20mkJcwaA5LUUr2iZY3lyawXQvMykDAGjjhF3GDnr
kCZWvDdM/ULUZ79fLRlZvf/LNbCtOndNhfahmyrRWVMKwqViv/eV/6t2GV0pkSZt
/hzJFroXuqGR5ndvKrXYJZhiu74zgzcPWE6CdzrB3II3GFPXbM2GMOaYmgEZLt3y
nUvrlWQbz6GmsT57HJ6gRCPtue1VhY1yLNc98Ip2J814xLu2MEakFTJEJVs6sjs7
Xzxyfofhl7YGn0Tcyn5v1tvtJBP0YAFRAN4thwTmpSlwuNnHQKul06RckPbybSS1
1xpkPgno17NIY3ipPt5hvETgNe6M90q5I2JG76SmGA92w0tcuXzMNlcNAoHpmCRK
y7/tnRZSVqhW636fbxsdi8h5eOWCF3TiUg9CRl6Wfg+39t9xldVJn2FJftG5YUWT
Gs43TraVwAkwOrIFtRYk
=9uSa
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Apr_2012_11_57_35_+1000_2XlSbeBbAg8sUDi+--
