Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C229AB6F19
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2011 16:38:24 +1000 (EST)
Date: Mon, 11 Apr 2011 16:38:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc/pci: Move IO workarounds to the common
	kernel dir
Message-Id: <20110411163821.27231daf.sfr@canb.auug.org.au>
In-Reply-To: <5f157bce88237ae70829d2d6df1d792a69b7e02c.1302501428.git.michael@ellerman.id.au>
References: <3ed7c174af4ccbab67467aa80fe84bd6c6e218ee.1302501428.git.michael@ellerman.id.au>
	<5f157bce88237ae70829d2d6df1d792a69b7e02c.1302501428.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__11_Apr_2011_16_38_21_+1000_52lb/m.=ee6qQ8Zx"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__11_Apr_2011_16_38_21_+1000_52lb/m.=ee6qQ8Zx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Apr 2011 15:54:28 +1000 (EST) Benjamin Herrenschmidt <benh@kerne=
l.crashing.org> wrote:
>
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kcon=
fig
> index 220b137..44059e1 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -162,6 +162,9 @@ config PPC_INDIRECT_PIO
>  config PPC_INDIRECT_MEM
>  	def_bool n
> =20
> +config PPC_IO_WORKAROUNDS
> +	def_bool n
> +

Just "bool"

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__11_Apr_2011_16_38_21_+1000_52lb/m.=ee6qQ8Zx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNoqHdAAoJEDMEi1NhKgbsqMcH/2+o/+FB5V2F+HG3BbRdvup4
cMVEh2SZQXm0fvaRbodiRo+y/mAOwtTC++64HphXd7ZgNZX8z4fwd+H4PuUesPfA
tJC66sn+TLKTAK/XO3rLStipv7FA9rV/tT/OYItHAGImgMaVe7p/YAMAlEJ/6hVJ
YCmGFFgMXzfyceHAQ4bDl7yG/dZf+mjDl6kfNmd4jhtTsRQ6C+GCPrK21CxlVt70
qb6RaQhw8irh6WZqCh98vJx5noG/4q2I/4riDcgInK5+DOnFFw3qe3rElhavJDsz
1clS041nH9eLeX1pJ9CUNBYbH+Kwg3ZkjfQAxX3+0te0SN+Wp9TU9A4BZPXUeYo=
=yNog
-----END PGP SIGNATURE-----

--Signature=_Mon__11_Apr_2011_16_38_21_+1000_52lb/m.=ee6qQ8Zx--
