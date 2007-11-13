Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D9E8FDDE47
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 16:23:39 +1100 (EST)
Date: Tue, 13 Nov 2007 16:23:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: Merge pci_process_bridge_OF_ranges()
Message-Id: <20071113162341.31d9d09b.sfr@canb.auug.org.au>
In-Reply-To: <20071113044432.F1389DDE2E@ozlabs.org>
References: <20071113044432.F1389DDE2E@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__13_Nov_2007_16_23_41_+1100_HSufeiUQMX4/RDtu"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__13_Nov_2007_16_23_41_+1100_HSufeiUQMX4/RDtu
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Nov 2007 15:43:51 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> Tested on a few pSeries, PowerMac G5, and a 32 bits PowerMacs and
> a BriQ. Please let me know if it misbehaves anywhere else.

It seems to work fine on my legacy iSeries (iseries_defconfig and
ppc64_defconfig), though I only have one PCI device.

Due to another patch I have, I changed pci_io_size to be a
reasource_size_t on 64 bit as well which should be a noop as it was
unsigned long.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__13_Nov_2007_16_23_41_+1100_HSufeiUQMX4/RDtu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHOTTiTgG2atn1QN8RAuOtAJ9HLCW/1I0HUQgc2v0jzVoJ06+VVQCgktMB
OhZGWxGQbWKdeH1pxMjU7uc=
=BgeV
-----END PGP SIGNATURE-----

--Signature=_Tue__13_Nov_2007_16_23_41_+1100_HSufeiUQMX4/RDtu--
