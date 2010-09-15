Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C53D11007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 15:00:56 +1000 (EST)
Date: Wed, 15 Sep 2010 15:00:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Yinghai Lu <yinghai@kernel.org>
Subject: Re: linux-next: build warnings after merge of the final tree (tip
	treee related)
Message-Id: <20100915150047.42551e34.sfr@canb.auug.org.au>
In-Reply-To: <4C8FFE76.8070801@kernel.org>
References: <20100913132721.5a02cfbc.sfr@canb.auug.org.au>
	<4C8DA517.9000603@kernel.org>
	<20100913143942.7344ada4.sfr@canb.auug.org.au>
	<4C8DDFB4.1020508@kernel.org>
	<20100914145025.977ec2a6.sfr@canb.auug.org.au>
	<4C8FFE76.8070801@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__15_Sep_2010_15_00_47_+1000_xgmT3c.opgJWyIY0"
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@elte.hu>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__15_Sep_2010_15_00_47_+1000_xgmT3c.opgJWyIY0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yinghai,

On Tue, 14 Sep 2010 16:00:06 -0700 Yinghai Lu <yinghai@kernel.org> wrote:
>
> Also, we may need to remove all extern and __init and __initdata etc in .=
h files.
>=20
> please check
>=20
> [PATCH -v3] memblock: Fix section mismatch warning
>=20
> Use __init_memblock to replace __init, and remove __init in memblock.h
>=20
> -v2: more with memblock_is_meory()
> -v3: remove __init for function declaring in memblock.h. Pointed out by S=
tephen.
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Yinghai Lu <Yinghai@kernel.org>

This version fixes all the warnings for me.  So if you put the "extern"s
back, you can add:

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__15_Sep_2010_15_00_47_+1000_xgmT3c.opgJWyIY0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMkFL/AAoJEDMEi1NhKgbsNGEH/0VnmhtHHiMEe8RzQC3K0zVK
CeeXGB7GAkaz3j24J+m2UNg6ru4iYLQkrQXy6B4ROAMbFdbYCTDhruuSAaVERpdX
jxqjDmeBfOVxuMbnmSmWP1p2x83L2d07tXraanLJXfyZmZlWurKFkByo5buo4nj3
KYumbBLJEZfRPWVd5x7L9BNsVOFw55IB6vHInDBV/+HAfCyq3QDcgIrTyqbLRcsC
yO3SzvJjjItvkI0ws6ky816MFm29y8/xEcNGfCD8cVYago06vem1XSPPOr+VV2g1
c9A2kl9RJOhNmgP2vkOcf320bXHn8XK4fqMh+ACRkuTv/QT8A0Nuv0M8E/FatvE=
=Gl3f
-----END PGP SIGNATURE-----

--Signature=_Wed__15_Sep_2010_15_00_47_+1000_xgmT3c.opgJWyIY0--
