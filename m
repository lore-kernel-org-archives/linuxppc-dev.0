Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E7D5F2C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 12:31:14 +1000 (EST)
Received: by mail-pd0-f177.google.com with SMTP id y10so3947341pdj.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 19:31:11 -0700 (PDT)
Date: Tue, 24 Sep 2013 10:31:03 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc/85xx: introduce corenet_generic machine
Message-ID: <20130924023103.GA2123@pek-khao-d1.corp.ad.wrs.com>
References: <1379835750-23999-1-git-send-email-haokexin@gmail.com>
 <1379835750-23999-2-git-send-email-haokexin@gmail.com>
 <1379975638.24959.47.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
In-Reply-To: <1379975638.24959.47.camel@snotra.buserror.net>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2013 at 05:33:58PM -0500, Scott Wood wrote:
> On Sun, 2013-09-22 at 15:42 +0800, Kevin Hao wrote:
> > In the current kernel, the board files for p2041rdb, p3041ds, p4080ds,
> > p5020ds, p5040ds, t4240qds and b4qds are almost the same except the
> > machine name. So this introduces a cornet_generic machine to support
> > all these boards to avoid the code duplication.
> >=20
> > With these changes the file corenet_ds.h becomes useless. Just delete
> > it.
> >=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> > v2:
> >   - Fix the typo in subject.
> >   - Fold the original patch 2 into this one.
> >   - Change the machine name from "CORENET GENERIC" to "CORENET Generic".
>=20
> CoreNet shouldn't be allcaps either.

OK. Will change it to "CoreNet Generic".

>=20
> > diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platfor=
ms/85xx/Kconfig
> > index de2eb93..3bee943 100644
> > --- a/arch/powerpc/platforms/85xx/Kconfig
> > +++ b/arch/powerpc/platforms/85xx/Kconfig
> > @@ -228,6 +228,7 @@ config P2041_RDB
> >  	select GPIO_MPC8XXX
> >  	select HAS_RAPIDIO
> >  	select PPC_EPAPR_HV_PIC
> > +	select CORENET_GENERIC
> >  	help
> >  	  This option enables support for the P2041 RDB board
> > =20
> > @@ -241,6 +242,7 @@ config P3041_DS
> >  	select GPIO_MPC8XXX
> >  	select HAS_RAPIDIO
> >  	select PPC_EPAPR_HV_PIC
> > +	select CORENET_GENERIC
> >  	help
> >  	  This option enables support for the P3041 DS board
> > =20
> > @@ -254,6 +256,7 @@ config P4080_DS
> >  	select GPIO_MPC8XXX
> >  	select HAS_RAPIDIO
> >  	select PPC_EPAPR_HV_PIC
> > +	select CORENET_GENERIC
> >  	help
> >  	  This option enables support for the P4080 DS board
>=20
> As discussed earlier, I'd prefer if this were combined into one kconfig
> option.  The help text can list boards that are known to work with it.

OK, will do.

Thanks,
Kevin
>=20
> -Scott
>=20
>=20
>=20

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSQPlnAAoJEJNY7TDerrFx1MUIAMI7VE0RsTpPJLV2KPHEoOLU
7lXJSc/aCeqaTLv7d9RPyaPCw81o2Ece71bdaPVSgTKzWXDZ1/aNYlx1EEPxVQqs
7TA8wrPtGN1CtIzN8OAj6OlZyzAL0PP/2g/4FLJKJ9loxF8aeHeTluAoXna+Q9Su
Mc95iMBS2TrKsU3zdYlJWLPuMyOIuTvF9IgSzxboPRi3SU3a+DF52fFIFoaFruug
lJz9dSeyN1bdlEHJoLBu4auiWp9Kj6PjncRYUXcOEIN4Nl84xkPb4Iegbl9CuV5b
wqkmRWPX7dbSJ1RdolMmRgjddvSEopB4OEW4sf/CYGfLaJ+ZuzfdQE/r9svf1CQ=
=IfRr
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
