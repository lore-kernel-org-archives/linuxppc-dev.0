Return-Path: <marc.leeman@gmail.com>
Received: from scorpius.homelinux.org (213.219.174.158.adslpower.by.edpnet.be
	[213.219.174.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 993A1680AC
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2005 18:31:24 +1000 (EST)
Date: Wed, 24 Aug 2005 09:54:32 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: zhonglei <zhonglei@RCS-9000.COM>
Message-ID: <20050824075432.GB14916@scorpius.homelinux.org>
References: <200508241511.AA32243824@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
In-Reply-To: <200508241511.AA32243824@RCS-9000.COM>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [gmail] unresolved symbol
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>    My mod has no error or warning during compiling.But when I "insmod hel=
lo.o" , it shows:
>    hello.o : unresolved symbol TaskStart
>    hello.o : unresolved symbol TasksLoadImage
>    hello.o : unresolved symbol TasksInitAPI
>    ...
> What's the problem?

You're trying to insert a module that depends on another
module/functionality in the kernel but which you did not insert or
compile in the kernel.

--=20
  greetz, marc
We can stick our heads between our legs and kiss our asses goodbye. It's
a saying.
	Crichton - I, E.T.
scorpius 2.6.12 #1 Thu Jun 23 21:32:03 CEST 2005 GNU/Linux

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDDCe4UQpj09NWLeERAotyAJ41FkQk2/FTIDZ1Kk8jWx/2YYJVcQCfWHcj
ilP2N362iJYc/bAj29MMVd4=
=d/aJ
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
