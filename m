Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 02666DDDF9
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:15:03 +1100 (EST)
Date: Fri, 28 Mar 2008 16:14:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Remove CONFIG_PCI_LEGACY from some configs
Message-Id: <20080328161457.f21ec25b.sfr@canb.auug.org.au>
In-Reply-To: <6B9965AF-F6B7-427E-B1D9-68CBB7540372@kernel.crashing.org>
References: <20080327163608.81f87de2.sfr@canb.auug.org.au>
	<6B9965AF-F6B7-427E-B1D9-68CBB7540372@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__28_Mar_2008_16_14_57_+1100_ICa6r+Gy.Oe_Potb"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__28_Mar_2008_16_14_57_+1100_ICa6r+Gy.Oe_Potb
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Thu, 27 Mar 2008 07:45:06 -0500 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
> On Mar 27, 2008, at 12:36 AM, Stephen Rothwell wrote:
> > This will remove some build warnings and doesn't stop us building any
> > drivers that we were building previously with these configs.
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> Doesn't this hide issues on the defconfigs most often built for PPC?

Not sure what you mean.  It removes some deprecated interfaces from the
builds for those configs.  The only things that use those interfaces are
drivers that none of those configs built.  People can still reenable
CONFIG_PCI_LEGACY on powerpc if they want to (and allmodconfig and
allyesconfig will do that).

So, the net effect is some less warnings in our builds.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__28_Mar_2008_16_14_57_+1100_ICa6r+Gy.Oe_Potb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH7H7VTgG2atn1QN8RApkuAJ9eThzHQfKFeoGDUNkjRiadXGl8LQCfeWM1
PXNuVuYQNg+oZS2B48sgXWM=
=2da8
-----END PGP SIGNATURE-----

--Signature=_Fri__28_Mar_2008_16_14_57_+1100_ICa6r+Gy.Oe_Potb--
