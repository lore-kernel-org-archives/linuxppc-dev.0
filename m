Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6388ADDEC1
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 10:42:08 +1100 (EST)
Date: Fri, 11 Jan 2008 10:41:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH V3] [POWERPC] Add common clock setting routine
	mpc52xx_psc_set_clkdiv()
Message-Id: <20080111104151.58820b7a.sfr@canb.auug.org.au>
In-Reply-To: <fa686aa40801100701q7454d8d0o8542ce9cc10f3bfb@mail.gmail.com>
References: <20080110052629.8853.52821.stgit@trillian.secretlab.ca>
	<20080110181316.1213f273.sfr@canb.auug.org.au>
	<fa686aa40801100701q7454d8d0o8542ce9cc10f3bfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__11_Jan_2008_10_41_51_+1100_+8E1IwAfVFs2JO9S"
Cc: linuxppc-dev@ozlabs.org, dragos.carp@toptica.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__11_Jan_2008_10_41_51_+1100_+8E1IwAfVFs2JO9S
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jan 2008 08:01:09 -0700 "Grant Likely" <grant.likely@secretlab.c=
a> wrote:
>
> On 1/10/08, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi Grant,
> >
> > On Wed, 09 Jan 2008 22:26:30 -0700 Grant Likely <grant.likely@secretlab=
.ca> wrote:
> > >
> > > +mpc52xx_map_common_devices(void)
> > >  {
> >
> > > +     /* Clock Distribution Module, used by PSC clock setting functio=
n */
> > > +     np =3D of_find_matching_node(NULL, mpc52xx_cdm_ids);
> >
> > What happens if we find no node?
>=20
> Both of_iomap and of_put fail gracefully if np is NULL.  IIRC that was
> done on purpose so this exact thing could be done.
>=20
> Users of mpc52xx_cdm (and the others done in this style) all check for
> mpc52xx_cdm being NULL before dereferencing.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__11_Jan_2008_10_41_51_+1100_+8E1IwAfVFs2JO9S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhq1ETgG2atn1QN8RAnfjAJ97AdsRkvXQoYWa9B1Hi8FKka76YACfbstO
GMCzDOySgdealyN4Fth+kZo=
=Gp1P
-----END PGP SIGNATURE-----

--Signature=_Fri__11_Jan_2008_10_41_51_+1100_+8E1IwAfVFs2JO9S--
