Return-Path: <marc.leeman@gmail.com>
Received: from scorpius.homelinux.org (unknown [213.219.165.150])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A18767B74
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 06:19:47 +1000 (EST)
Date: Wed, 19 Jul 2006 22:19:41 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
Message-ID: <20060719201941.GW5219@scorpius.homelinux.org>
References: <4879B0C6C249214CBE7AB04453F84E4D050B55@zch01exm20.fsl.freescale.net>
	<4856A73A-BB23-4850-A697-1CE7C385DE42@kernel.crashing.org>
	<1E6652B1-3126-4B69-BE9D-8DCE8DCACE7C@embeddedalley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KG+zyBxh8BrwB1om"
In-Reply-To: <1E6652B1-3126-4B69-BE9D-8DCE8DCACE7C@embeddedalley.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--KG+zyBxh8BrwB1om
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I agree.  The customers of board ports I've done over the years
> are always eager to get these into the public sources.  It just
> seems we run out of time during the pressure of trying to get
> the products done, and they just issue them on CDs or for
> download afterward.

For our boards, I am somewhat more eager to get our port in U-Boot than
in the Linux kernel for a number of reasons.

First; it is always interesting to see how other ppl handle simular
problems during boot up.

Secondly; U-Boot is used to set configuration options at bootup, e.g.
for multi purpose pins. Having your changes (to registers), fixes or
silicon bugs might help ppl and avoid them to look for a silicon bug
workaround.

If I submit a port of our board to U-Boot, clearly comment the changes
(e.g. enable GPIO on pin X while setting registers); I hope that some
ppl can use it. Next to this, Wolfgang is doing a *very* good job of
keeping his tree clean and giving good pointers to problems and clean up
strategies that serve us all.

Having my changes for our boards that are very specific since they are
connected to FPGAs would IMHO serve little purpose in the Linux kernel:
there is very limited access to the hardware and it would only serve to
clutter the kernel with an exponentionally growing number of ports that
most ppl will never use. I think (even though using ARCH and
CROSS_COMPILE during compilation limits the audience); the target
audience between U-Boot and the Linux kernel is slightly different.

Though I do agree that there is a gap: it would be nice to have some
place to submit the kernel patches; possibly not included in the main
tree; just to see how other ppl are tackling the same problem and
avoiding re-doing the same work for the nth time (e.g. writing some
communciation protocol where there are a number of references of ppl
haveing done them, but no real code).

--=20
  greetz, marc
Aeryn died so you could live John. She would want you to keep fighting.
	D'Argo - Season of Death
scorpius.homelinux.org 2.6.17 #2 PREEMPT Thu Jun 22 07:18:33 CEST 2006 GNU/=
Linux

--KG+zyBxh8BrwB1om
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEvpPdUQpj09NWLeERArDtAKC6ZHm1h4xCF4frNhtKfgprrCZJhwCgu1Zc
7w22fal4UqKW1b+ClMgaWcA=
=FRco
-----END PGP SIGNATURE-----

--KG+zyBxh8BrwB1om--
