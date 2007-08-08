Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 53DBBDDEAB
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 17:47:46 +1000 (EST)
Date: Wed, 8 Aug 2007 17:47:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: geoffrey.levand@am.sony.com
Subject: Re: [patch 0/3] PS3 bugfix patches for 2.6.23
Message-Id: <20070808174740.8426f5f6.sfr@canb.auug.org.au>
In-Reply-To: <20070808171738.40d99505.sfr@canb.auug.org.au>
References: <20070808033119.833895506@am.sony.com>
	<20070808171738.40d99505.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__8_Aug_2007_17_47_40_+1000_EqV1Df+K2h9jZmwQ"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__8_Aug_2007_17_47_40_+1000_EqV1Df+K2h9jZmwQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geoff,

On Wed, 8 Aug 2007 17:17:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au>
wrote:
>
>   LD      .tmp_vmlinux1
> arch/powerpc/platforms/built-in.o: In function `of_has_vicinity':
> /home/sfr/kernels/linus/arch/powerpc/platforms/cell/spu_base.c:681:
> undefined reference to `.spu_devnode'

Ben pointed out patch "[PATCH v2] cell: move SPU affinity init to
spu_management_of_ops" to me.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__8_Aug_2007_17_47_40_+1000_EqV1Df+K2h9jZmwQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGuXUhTgG2atn1QN8RAtNeAJ92PFoZWAsZMx9XPN/bgvF15OTjFgCeLsHT
MfvIrQEHb5mKEDnreTzWnMw=
=Xzt4
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Aug_2007_17_47_40_+1000_EqV1Df+K2h9jZmwQ--
