Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B18EFDDF29
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 16:11:53 +1000 (EST)
Date: Fri, 20 Jul 2007 16:11:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] of_detach_node()'s device node argument cannot be const
Message-Id: <20070720161145.2ff6860c.sfr@canb.auug.org.au>
In-Reply-To: <11849111183072-git-send-email-segher@kernel.crashing.org>
References: <11849111183072-git-send-email-segher@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__20_Jul_2007_16_11_45_+1000_TS+km8Uq.cigqQkU"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__20_Jul_2007_16_11_45_+1000_TS+km8Uq.cigqQkU
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Jul 2007 07:58:38 +0200 Segher Boessenkool <segher@kernel.crashi=
ng.org> wrote:
>
> ...since it modifies it (when it sets the OF_DETACHED flag).

http://patchwork.ozlabs.org/linuxppc/patch?q=3DStephen%20Rothwell&id=3D12212

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__20_Jul_2007_16_11_45_+1000_TS+km8Uq.cigqQkU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGoFIrTgG2atn1QN8RAscGAJ4lLwRJXXlMQM/NP5vLIcTKcM9+8gCeMR7a
cLzQNtHKP9GbpK44IUAc14k=
=vr8+
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Jul_2007_16_11_45_+1000_TS+km8Uq.cigqQkU--
