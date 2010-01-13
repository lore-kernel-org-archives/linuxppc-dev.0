Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 933E0B7CB2
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 01:27:11 +1100 (EST)
Date: Thu, 14 Jan 2010 01:27:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/1] powerpc/iseries: Initialise on-stack completion
Message-Id: <20100114012705.d3a65d02.sfr@canb.auug.org.au>
In-Reply-To: <d44faed85b5e101743bcb1a5e8a0df8487830654.1263366655.git.michael@ellerman.id.au>
References: <d44faed85b5e101743bcb1a5e8a0df8487830654.1263366655.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__14_Jan_2010_01_27_05_+1100_yoRTDBPr.7._31Kq"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__14_Jan_2010_01_27_05_+1100_yoRTDBPr.7._31Kq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, 13 Jan 2010 18:10:56 +1100 (EST) Michael Ellerman <michael@ellerman=
.id.au> wrote:
>
> get_viotape_info() declares a vio_waitevent on the stack, which
> contains a completion, but never initialises the completion.
>=20
> I have no idea how this ever worked, and on recent kernels it causes
> an oops in handle_tape_event() when we access the non-initialised
> completion.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

*blush*

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__14_Jan_2010_01_27_05_+1100_yoRTDBPr.7._31Kq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktN2DkACgkQjjKRsyhoI8xVKgCaAy94z9lIc8vugN2+COFzd0XN
qMkAnibczyCsfSOptpfGxCb54Pl7K9v5
=ZRwV
-----END PGP SIGNATURE-----

--Signature=_Thu__14_Jan_2010_01_27_05_+1100_yoRTDBPr.7._31Kq--
