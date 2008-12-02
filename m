Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DD1D7DDDEE
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 10:25:15 +1100 (EST)
Date: Wed, 3 Dec 2008 10:25:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nicolas Palix <npalix@diku.dk>
Subject: Re: [PATCH linux-next] powerpc/powermac: Add missing of_node_put
Message-Id: <20081203102508.ce955781.sfr@canb.auug.org.au>
In-Reply-To: <20081203101901.4f317425.sfr@canb.auug.org.au>
References: <200812021445.18670.npalix@diku.dk>
	<20081203101901.4f317425.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__3_Dec_2008_10_25_08_+1100_fqL4vZ/Yw__adOxl"
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Julia Lawall <julia@diku.dk>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__3_Dec_2008_10_25_08_+1100_fqL4vZ/Yw__adOxl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Wed, 3 Dec 2008 10:19:01 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> I think this particular patch is also required against Linus' kernel (not
> just linux-next).

In fact, I think all these patches can apply to Linus' current tree.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__3_Dec_2008_10_25_08_+1100_fqL4vZ/Yw__adOxl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk1w9QACgkQjjKRsyhoI8w4AgCgqkCoalI22aHYYEelOXPU/+to
erIAnjJkpc5f8aUUu7crYn6O2la0MIj0
=vrfJ
-----END PGP SIGNATURE-----

--Signature=_Wed__3_Dec_2008_10_25_08_+1100_fqL4vZ/Yw__adOxl--
