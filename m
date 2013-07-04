Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x236.google.com (mail-pb0-x236.google.com
 [IPv6:2607:f8b0:400e:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0BEA2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 11:08:30 +1000 (EST)
Received: by mail-pb0-f54.google.com with SMTP id ro2so668165pbb.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jul 2013 18:08:27 -0700 (PDT)
Date: Thu, 4 Jul 2013 09:08:18 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Message-ID: <20130704010818.GA16188@pek-khao-d1.corp.ad.wrs.com>
References: <20130702032447.GA26391@pek-khao-d1.corp.ad.wrs.com>
 <1372804758.8183.124@snotra>
 <20130703030044.GA25190@pek-khao-d1.corp.ad.wrs.com>
 <1372883907.8183.151@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
In-Reply-To: <1372883907.8183.151@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2013 at 03:38:27PM -0500, Scott Wood wrote:
> On 07/02/2013 10:00:44 PM, Kevin Hao wrote:
> >On Tue, Jul 02, 2013 at 05:39:18PM -0500, Scott Wood wrote:
> >> How much overhead (space and time) is this really?
> >
> >The following is the additional sections when relocatable is
> >enabled for
> >a p2020rdb board.
> >   section        size
> >  .dynsym       000007f0
> >  .dynstr       00000926
> >  .dynamic      00000080
> >  .hash         00000388
> >  .interp       00000011
> >  .rela.dyn     00215250
> >
> >The time for the relocation is about 32ms on a p2020rdb board.
>=20
> Hmm... more relocations than I expected.  What percentage is this of
> the total image size?

The size of vmlinux.bin is about 10M. The percentage of the relocation
section is about 20%. But look on the bright side of thing, all the relocat=
ion
stuff are in init section and should be discarded at runtime. :-)

Thanks,
Kevin

>=20
> -Scott

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR1MsCAAoJEJNY7TDerrFx4r4IAJqw8dCcfXEInw+PdOBm/BrF
0hwOd7Jb2oox8Hcj4RJVBBAvi+tT3d52kdaYQWrDhxckrVpPIsHVeN6XnoexnRhB
NELGpRvAjznDjhN+NhL6t744RrJI+xMFlW0s78XsDKTDj6Jv3HR6of+lXDuzm+mL
DoF85FN8LKcS92vphzyLyyRZyQUOCD1MdIoCHoHBDk5pNKJQCI9gy5YzTD9iksvt
UcTebBvzViu6Ate6k8tXM0GBtUpS/o84SXxWLPyt9R26vJW893LZkJVcuNyX2CxY
xyjIl5UcdwnY3i5Z+VL9Na57xApLKG/gRLV8gyyBMmTvJkEi2sAz+T6ZNzse5KU=
=rssN
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
