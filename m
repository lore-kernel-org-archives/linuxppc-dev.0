Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E30A3DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 10:44:04 +1100 (EST)
Date: Fri, 5 Dec 2008 10:43:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix !CONFIG_PPC_NEED_DMA_SYNC_OPS build warning
Message-Id: <20081205104349.54e93680.sfr@canb.auug.org.au>
In-Reply-To: <1228414360-9699-1-git-send-email-beckyb@kernel.crashing.org>
References: <1228414360-9699-1-git-send-email-beckyb@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__5_Dec_2008_10_43_49_+1100_p_8aivE4kdxU.JBr"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__5_Dec_2008_10_43_49_+1100_p_8aivE4kdxU.JBr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Becky,

On Thu,  4 Dec 2008 12:12:40 -0600 Becky Bruce <beckyb@kernel.crashing.org>=
 wrote:
>
> Change #define stubs of dma_sync ops to be empty static inlines
> to avoid build warning.
>=20
> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

Build tested for ppc64_defconfig.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__5_Dec_2008_10_43_49_+1100_p_8aivE4kdxU.JBr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk4azUACgkQjjKRsyhoI8zbEwCfRi8ts2Mb2Y4RxtkTZtmqJNSg
5MAAoK6iaYu3Q4V4UUlAe+1Nkb2yBtyG
=KgiT
-----END PGP SIGNATURE-----

--Signature=_Fri__5_Dec_2008_10_43_49_+1100_p_8aivE4kdxU.JBr--
