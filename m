Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EA3D0DDF13
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 14:47:33 +1000 (EST)
Date: Tue, 23 Oct 2007 14:47:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Problems with allyesconfig kernel build
Message-Id: <20071023144722.42e37425.sfr@canb.auug.org.au>
In-Reply-To: <20071022211836.45a87a12.akpm@linux-foundation.org>
References: <20071023140231.12698d1c.sfr@canb.auug.org.au>
	<20071022211836.45a87a12.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__23_Oct_2007_14_47_22_+1000_fokIly7DYozCMA85"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, amodra@bigpond.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__23_Oct_2007_14_47_22_+1000_fokIly7DYozCMA85
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Oct 2007 21:18:36 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Tue, 23 Oct 2007 14:02:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>=20
> > This was first noted with the -mm tree, but has now migrated into Linus'
> > tree.
>=20
> Yeah, sorry, I didn't know what to do about that.  I'm not even sure which
> patch caused it.

Not your fault.

> What did we do which caused all this to start happening?

We just grew too big, probably :-(

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__23_Oct_2007_14_47_22_+1000_fokIly7DYozCMA85
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHHXzkTgG2atn1QN8RAryiAJ9GwZHv7SZiU1OIfODS1BSNmFRNyACgmvoa
rBgDiK3KB75hJP0ot+tBxtE=
=2Cu7
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Oct_2007_14_47_22_+1000_fokIly7DYozCMA85--
