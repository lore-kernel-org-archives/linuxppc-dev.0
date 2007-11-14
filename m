Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B8B13DDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 15:11:16 +1100 (EST)
Date: Wed, 14 Nov 2007 15:11:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] cell: Convert #include of asm/of_{platform, device}.h
	into linux/of_{platform, device}.h.
Message-Id: <20071114151116.2e0b8e0e.sfr@canb.auug.org.au>
In-Reply-To: <E1Irw8I-0000b4-5e@jdl.com>
References: <1194899211.3396.15.camel@ld0161-tx32>
	<20071113120224.de390904.sfr@canb.auug.org.au>
	<E1Irw8I-0000b4-5e@jdl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__14_Nov_2007_15_11_16_+1100_tHINbkPjRCvLB6xr"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__14_Nov_2007_15_11_16_+1100_tHINbkPjRCvLB6xr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Nov 2007 07:48:50 -0600 Jon Loeliger <jdl@jdl.com> wrote:
>
> I'm assuming I can chip away at _all_ of these,
> including the ones in the drivers/ directories as well.

Knock yourself out!  :-)

> I haven't a clue who will really pick all these up.
> We could arrange for Paul to grab the arch/powerpc.
> But the rest?  Mr Morton perhaps?

Just keep in mind that some of these changes may affect Sparc and
Sparc64, so Dave Miller is you man for those.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__14_Nov_2007_15_11_16_+1100_tHINbkPjRCvLB6xr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHOnVqTgG2atn1QN8RAuqQAJ9NckjEwa3SZIrohaDQsVKAOv09KwCdG98w
Be2aJ/Ntj9SllAoHPNParB0=
=2Oof
-----END PGP SIGNATURE-----

--Signature=_Wed__14_Nov_2007_15_11_16_+1100_tHINbkPjRCvLB6xr--
