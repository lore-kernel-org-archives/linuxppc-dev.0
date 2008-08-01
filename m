Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1B1CBDDFBD
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 14:28:02 +1000 (EST)
Date: Fri, 1 Aug 2008 14:27:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH] Revert "Merge branch 'x86/iommu' of
	git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip
	into for-linus"
Message-Id: <20080801142754.8a6314fa.sfr@canb.auug.org.au>
In-Reply-To: <20080801085106E.fujita.tomonori@lab.ntt.co.jp>
References: <20080801094323.9601d87b.sfr@canb.auug.org.au>
	<20080801085106E.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__1_Aug_2008_14_27_54_+1000_qszNvBgVVH.GLi2S"
Cc: joerg.roedel@amd.com, linux-kernel@vger.kernel.org,
	jbarnes@virtuousgeek.org, davem@davemloft.net,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__1_Aug_2008_14_27_54_+1000_qszNvBgVVH.GLi2S
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Aug 2008 08:51:23 +0900 FUJITA Tomonori <fujita.tomonori@lab.ntt.=
co.jp> wrote:
>
> Ingo has a patch to fix this problem in the x86 tree:
>=20
> http://marc.info/?l=3Dlinux-kernel&m=3D121754062325903&w=3D2

Then consider this a poke (to the appropriate person) to get something
merged to fix the breakage.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__1_Aug_2008_14_27_54_+1000_qszNvBgVVH.GLi2S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiSkMoACgkQjjKRsyhoI8yagACggFN1tewSUDhrbrS2gXAidcpg
G+kAoK6AyhTIH4M2HSa8kfdfbTps5BPG
=avUC
-----END PGP SIGNATURE-----

--Signature=_Fri__1_Aug_2008_14_27_54_+1000_qszNvBgVVH.GLi2S--
