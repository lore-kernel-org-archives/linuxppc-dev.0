Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc: Add support for Wind River SBC8641D board
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080411100541.e45b92f4.sfr@canb.auug.org.au>
References: <1207869739-19892-1-git-send-email-paul.gortmaker@windriver.com>
	<0006b107cbf99a968352d9369a8e26304d4bf13a.1207868891.git.paul.gortmaker@windriver.com>
	<20080411100541.e45b92f4.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1LhjtOuxhtSHyJn/uh49"
Date: Fri, 11 Apr 2008 10:38:43 +1000
Message-Id: <1207874323.7477.1.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-1LhjtOuxhtSHyJn/uh49
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-04-11 at 10:05 +1000, Stephen Rothwell wrote:
> Hi Paul,
>=20
> Just a couple of comments.
>=20
> On Thu, 10 Apr 2008 19:22:17 -0400 Paul Gortmaker <paul.gortmaker@windriv=
er.com> wrote:
> >
> > +++ b/arch/powerpc/platforms/86xx/sbc8641d.c
> > +#undef DEBUG
> > +
> > +#ifdef DEBUG
> > +#define DBG(fmt...) do { printk(KERN_ERR fmt); } while(0)
>                                    ^^^^^^^^
> Not KERN_DEBUG?  Also, if you include linux/kernel.h you can use pr_debug=
() instead.

s/Also, if you include/Please include/

We don't need more hand-rolled debug macros :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-1LhjtOuxhtSHyJn/uh49
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH/rMTdSjSd0sB4dIRAo9kAKCBw48Kb1geNTaNCYgCwag5cYzSXACbBzo/
EKw/8SG2bSbGqIJ6gyqfJyE=
=yAr5
-----END PGP SIGNATURE-----

--=-1LhjtOuxhtSHyJn/uh49--
