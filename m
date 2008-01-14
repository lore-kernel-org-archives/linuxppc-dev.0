Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2A610DDF0E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 09:54:39 +1100 (EST)
Date: Tue, 15 Jan 2008 09:54:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [DTC PATCH] libfdt: Add ft_get_next_node(), ft_get_next_prop(),
	and ft_getprop_offset().
Message-Id: <20080115095434.5470b4a7.sfr@canb.auug.org.au>
In-Reply-To: <478BE5D1.9080300@freescale.com>
References: <20080114163004.GA27880@ld0162-tx32.am.freescale.net>
	<20080115093149.39a1d703.sfr@canb.auug.org.au>
	<478BE5D1.9080300@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_Jan_2008_09_54_34_+1100_BUQb7mWOM5fgQAZe"
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_Jan_2008_09_54_34_+1100_BUQb7mWOM5fgQAZe
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Jan 2008 16:44:33 -0600 Scott Wood <scottwood@freescale.com> wro=
te:
>
> Stephen Rothwell wrote:
> >> +++ b/libfdt/libfdt.h
> >=20
> >> +#define FDT_ERR_BADDEPTH	8
> >=20
> > Wouldn't it have been less intrusive to just use the next error number
> > rather than inserting this here?
>=20
> Yes, but then either the order in errtable[] wouldn't match the order in=
=20
> the header file, or the error type grouping would be broken.
>=20
> If we want to maintain such a grouping, we should probably leave some=20
> number space between the groups.

OK.

> "pointer to a string" could be interpreted as "char *", not "char **".

Yeah, it has always been a bit ambiguous.

> I'll fix the others; thanks for pointing them out.

No worries.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_Jan_2008_09_54_34_+1100_BUQb7mWOM5fgQAZe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHi+guTgG2atn1QN8RAjlYAJ4ufyArcBAb/OOSkOTAttoM7+++BQCcCtNO
ltWu14fkdQpr01xgfpK5KV4=
=GpmE
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Jan_2008_09_54_34_+1100_BUQb7mWOM5fgQAZe--
