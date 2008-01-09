Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3D8E8DDF4D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 17:23:32 +1100 (EST)
Date: Wed, 9 Jan 2008 17:23:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3/7] sbc8560: add support for Wind River SBC8560 in
	arch/powerpc
Message-Id: <20080109172320.177f7a3d.sfr@canb.auug.org.au>
In-Reply-To: <47845009.8070106@windriver.com>
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
	<11997159331132-git-send-email-paul.gortmaker@windriver.com>
	<11997159342128-git-send-email-paul.gortmaker@windriver.com>
	<11997159352727-git-send-email-paul.gortmaker@windriver.com>
	<20080108113219.860ac365.sfr@canb.auug.org.au>
	<47845009.8070106@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Jan_2008_17_23_20_+1100_1n=L2jgnU7xvmdiU"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_Jan_2008_17_23_20_+1100_1n=L2jgnU7xvmdiU
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Jan 2008 23:39:37 -0500 Paul Gortmaker <paul.gortmaker@windriver=
.com> wrote:
>
> No problem.  I think you will find all these issues are applicable to
> the mpc8560mds support that I based things off too.  I'd rather do
> a single patch for both boards to deal with these, rather than respin
> the sbc8560 patches again and leave the mpc8560mds behind.
> Assuming everyone else is OK with this approach.

Fine by me.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Jan_2008_17_23_20_+1100_1n=L2jgnU7xvmdiU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhGhdTgG2atn1QN8RAswwAJ9AzZXabNforQrtWy4f7WwLQCb+hQCeKZiN
N33JjTeTZurQPuCjv9SPGXw=
=W+0P
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jan_2008_17_23_20_+1100_1n=L2jgnU7xvmdiU--
