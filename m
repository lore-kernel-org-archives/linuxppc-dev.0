Return-Path: <marc.leeman@ieee.org>
Received: from scorpius.homelinux.org (131-112.a2f.dsl.net4all.net
	[81.89.112.131]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E41E167A64
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2005 01:35:54 +1100 (EST)
Date: Thu, 3 Mar 2005 14:13:37 +0100
From: Marc Leeman <marc.leeman@gmail.com>
To: Joerg Dorchain <joerg@dorchain.net>
Message-ID: <20050303131337.GB15433@scorpius.homelinux.org>
References: <20050303124435.GA24233@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
In-Reply-To: <20050303124435.GA24233@Redstar.dorchain.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: GCC4 fun.
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> scheduling while atomic: swapper/0x00000002/0
> Call trace:
>  [c0007620] dump_stack+0x18/0x28
>  [c01de704] schedule+0x678/0x67c
>  [c0004500] syscall_exit_work+0x108/0x10c
>  [c02a97b4] proc_root_init+0x168/0x174
>  [ff847288] 0xff847288
>  [c02945e8] start_kernel+0x144/0x170
>  [00003a30] 0x3a30

We have something similar with PPC 8245, I was planning to have a look
at it, but didn't get round to it. Since our system is crunching numbers
since yesterday evening without fault, I guess it's not that serious...

--=20
  greetz, marc
Aeryn died so you could live John. She would want you to keep fighting.
	D'Argo - Season of Death
scorpius 2.6.11 #1 Wed Mar 2 16:38:38 CET 2005 GNU/Linux

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCJw2BUQpj09NWLeERApVkAJ9kQ/zwmWbiZ05aKsdax4RA5wpWzQCgkzfz
S5u2i9eMWXs4VNbFdZExeeg=
=ZwYy
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
