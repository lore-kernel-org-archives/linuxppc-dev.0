Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0BDC92C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 13:46:54 +1000 (EST)
Received: by mail-pa0-f48.google.com with SMTP id kp12so6186406pab.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jul 2013 20:46:52 -0700 (PDT)
Date: Wed, 10 Jul 2013 11:46:40 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/math-emu: remove the dead code in math.c
Message-ID: <20130710034640.GC361@pek-khao-d1.corp.ad.wrs.com>
References: <1373420623-24869-1-git-send-email-haokexin@gmail.com>
 <1373420623-24869-2-git-send-email-haokexin@gmail.com>
 <20130710020132.GA7491@concordia>
 <20130710022307.GB361@pek-khao-d1.corp.ad.wrs.com>
 <20130710032533.GA10374@concordia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
In-Reply-To: <20130710032533.GA10374@concordia>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2013 at 01:25:33PM +1000, Michael Ellerman wrote:
> On Wed, Jul 10, 2013 at 10:23:07AM +0800, Kevin Hao wrote:
> > On Wed, Jul 10, 2013 at 12:01:33PM +1000, Michael Ellerman wrote:
> > > On Wed, Jul 10, 2013 at 09:43:42AM +0800, Kevin Hao wrote:
> > > > The math.c is only built when CONFIG_MATH_EMULATION is enabled.
> > > > So we would never get into the case that CONFIG_MATH_EMULATION
> > > > is not defined in this file.
> > >=20
> > > Any idea why we have that there? ie. have the config symbols changed
> > > over time or was this always dead code?
> >=20
> > No idea. I tried to trace this before submitting the patch. But it has
> > been there since the begin of the git history. So I just assume that it=
 is
> > always dead code. :-)
>=20
> Yeah looks like it. Even in the git-huge tree I see it in the initial
> commit.

Thanks for the confirmation.

>=20
> You should say that in the commit message though. Otherwise it's not
> clear if you're fixing a recent breakage or not.

Indeed. I will wait a little to see if there are any other comments. Then
respin a new version to capture such info in the commit log.

Thanks,
Kevin

>=20
> cheers

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR3NkgAAoJEJNY7TDerrFxdeEIALmXEkrFbmtR63y1ElrcQDs1
L5+WOsdO9xUdjGcgu1rQJFj6nyrnZiuwcsONLsv0UebnyzDeQy4MWds5ZyNvMdH2
s6oHX3ts97bTnGgFCq8mNaCxJSS0yIR1vVDh04X9vsWNQeweJxK1DQ5AaXWutUYM
s6eTzYhkqx4Kw5CO/3ylJcXrrU1xMiWilcVwQ7WmxYyrpsoV7me3cjqrCRbwGwXK
CWFyct78GCEj6dOzH6qe3HGHQdnT/8pvC9f+fikQLlwoeDTTDrzPKvPqaizbP1ZB
ciybE8Ld8BC8UMZql5YxGrO5f8M0OeZ6uBPjAIxwPxfpSpi+VV1yiH/G7M+J4J4=
=iu3d
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
