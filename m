Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B0EFB2C016B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 11:30:01 +1000 (EST)
Received: by mail-pa0-f42.google.com with SMTP id lj1so586103pab.29
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 18:29:59 -0700 (PDT)
Date: Thu, 26 Sep 2013 09:29:32 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 3/3] powerpc/85xx: use one kernel option for all the
 CoreNet_Generic boards
Message-ID: <20130926012932.GC9209@pek-khao-d1.corp.ad.wrs.com>
References: <1379991797-29222-1-git-send-email-haokexin@gmail.com>
 <1379991797-29222-4-git-send-email-haokexin@gmail.com>
 <1380062492.24959.123.camel@snotra.buserror.net>
 <20130925005843.GA20572@pek-khao-d1.corp.ad.wrs.com>
 <1380150683.24959.215.camel@snotra.buserror.net>
 <20130926012310.GB9209@pek-khao-d1.corp.ad.wrs.com>
 <1380158760.24959.240.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
In-Reply-To: <1380158760.24959.240.camel@snotra.buserror.net>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2013 at 08:26:00PM -0500, Scott Wood wrote:
> On Thu, 2013-09-26 at 09:23 +0800, Kevin Hao wrote:
> > On Wed, Sep 25, 2013 at 06:11:23PM -0500, Scott Wood wrote:
> > > On Wed, 2013-09-25 at 08:58 +0800, Kevin Hao wrote:
> > > > On Tue, Sep 24, 2013 at 05:41:32PM -0500, Scott Wood wrote:
> > > > > On Tue, 2013-09-24 at 11:03 +0800, Kevin Hao wrote:
> > > > > > +	  and B4 QDS boards
> > > > [...]
> > > > >=20
> > > > > Is there any difference between the 32-bit and 64-bit versions of=
 this
> > > > > config symbol, other than the help text?
> > > >=20
> > > > No. As you know some of these boards only support 32bit kernel and =
some of
> > > > them only support 64bit kernel. It will definitely cause confusion =
when using
> > > > only one kernel option for all these boards. So I divide this into =
two options
> > > > (even the same name) for 32bit and 64bit respectively.
> > >=20
> > > You could just mention in the help text which boards are 32-bit, which
> > > are 64-bit, and which can work with either.
> >=20
> > OK. How about this?
> >=20
> >  arch/powerpc/platforms/85xx/Kconfig | 26 +++++++-------------------
> >  1 file changed, 7 insertions(+), 19 deletions(-)
>=20
> Looks good.

OK. I will fold these changes into the original patch and make a new respin.

Thanks,
Kevin

>=20
> -Scott
>=20
>=20
>=20

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSQ438AAoJEJNY7TDerrFxLTcIALHWonL6wycGuvM7rKel++Vj
NMLUy+ueIFg/UWBJNO2M1SEQB18ub9z5la5v8bckFp9OicL/2IE1nwcJF7fMhP29
R6A5QlJdqruj6jqMU7uFt+xv0CYXL/GoxnXaBgryGZfbAk7GNl5emoxHLN+uP0Tk
OhWvQ5mFYj+rdCFz2ahDJPV+Qjz0vaA74uMaPsSQr6dnVRPKLvX3FV0sr623et+9
+RAY784fVftqvN4tARe/IX7kZqwlW8wp5JEmmFNke0OGP9YT+Tss6eUbEtgz0by7
yFSXcgWqR/i3mkppeJpT6yG5lFz4TR/mY8YcXqqf0+UN/hYBTP0QMLqWMSIjSog=
=WxP6
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
