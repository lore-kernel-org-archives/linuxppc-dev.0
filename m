Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E20D7DDF0F
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 17:34:11 +1000 (EST)
Date: Sat, 28 Jun 2008 17:34:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 01/12] pata_mpc52xx: use linux/of_platform.h instead of asm
Message-Id: <20080628173404.aa2309b4.sfr@canb.auug.org.au>
In-Reply-To: <fa686aa40806272231s69a895afv61877729acbac7fb@mail.gmail.com>
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
	<48648AA2.2020204@garzik.org>
	<fa686aa40806272231s69a895afv61877729acbac7fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__28_Jun_2008_17_34_04_+1000_87fD+G+3xy=oUoY."
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Tejun Heo <htejun@gmail.com>,
	Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__28_Jun_2008_17_34_04_+1000_87fD+G+3xy=oUoY.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jun 2008 22:31:54 -0700 "Grant Likely" <grant.likely@secretlab.c=
a> wrote:
>
> On Thu, Jun 26, 2008 at 11:37 PM, Jeff Garzik <jeff@garzik.org> wrote:
> > Stephen Rothwell wrote:
> >>
> >> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >> ---
> >>  drivers/ata/pata_mpc52xx.c |    2 +-
> >
> > ACK.  send it via an arch tree
>=20
> I'll pick it up.

Thanks, Grant.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__28_Jun_2008_17_34_04_+1000_87fD+G+3xy=oUoY.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhl6WwACgkQTgG2atn1QN8+8QCfe/QxWofrJr6aBX5ToxL1tKEH
KzQAn0gRkzRx2ghl0uR0m297OvkPc0Jt
=wY5i
-----END PGP SIGNATURE-----

--Signature=_Sat__28_Jun_2008_17_34_04_+1000_87fD+G+3xy=oUoY.--
