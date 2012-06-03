Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 09DE7B6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jun 2012 12:28:59 +1000 (EST)
Date: Sun, 3 Jun 2012 12:28:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Fix size of st_nlink on 64bit
Message-Id: <20120603122850.3c5142767e429f34eb8a921e@canb.auug.org.au>
In-Reply-To: <20120602213452.66ba4cbb@kryten>
References: <20120602213452.66ba4cbb@kryten>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Sun__3_Jun_2012_12_28_50_+1000_woiBprM3m9tS6IhH"
Cc: michael@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sun__3_Jun_2012_12_28_50_+1000_woiBprM3m9tS6IhH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Sat, 2 Jun 2012 21:34:52 +1000 Anton Blanchard <anton@samba.org> wrote:
>
> commit e57f93cc53b7 (powerpc: get rid of nlink_t uses, switch to
> explicitly-sized type) changed the size of st_nlink on ppc64 from
> a long to a short, resulting in boot failures.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>

Would this affect my (early user mode) boot problems reported yesterday;

/init: 71: mknod: Permission denied
/init: 88: mknod: Permission denied
/init: 88: mknod: Permission denied

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Sun__3_Jun_2012_12_28_50_+1000_woiBprM3m9tS6IhH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPysviAAoJEECxmPOUX5FEPIgP/0/U8Xpy3vaHHm0d77waUJ9f
NG/iWoj86rIHmzZJ0AGsTL1eziWMbW29HjKJiAZRMYGBmS93ZaalpytItyHnOZuY
2L1hoTaUVHeUjFVFk3dvxGeHax9DLaqAHOERhI57hu4Y5rZEiqXWqzzqChdpqe2z
1+w5Ti+gsS9aOccgfowQ/9jzcvcY2qpvqwtW+ZvrW2nBpd3Zksfx+tvOZr0UnWzX
ONQN12WhCq2bQdoW+sHqn+DP5HyYS0bIcQQJ5x9ucWW9izgqPcIKvo4fwewJtfpB
LpcTpI2W/ulbw/5Xs5cS4riaIuVOBPuXQCezrjAYXluM7PBoFcTEMwZYMcrlcMQ7
eYWLa8U9gc+PNgZpQLSmN3Ija8RlwroMdzcnKmL/IEQN4EHf25MLVaDK6SWv4alz
yq3uAoCGAE57ZAZw9iYRu8EBWtxlz0/JXY5/q+cBa+Cw/2NHYW8TPNgzcTIOHLj5
e+RychGnQU6DZK+yo1R0qGsqUZUs9TvZCN/++yE3SdDxwUFUzhAUw/Ub/l7oZZK1
QDV8GvXZsIT5iRW17ZleEv82uvjL6T6r6SGLMLDDkJDL1pYt2VVp4/S0K3LgVK3o
epsHM4xW0H6lWk318ied6QCSJrvu87bRHvJXFumbt3lJjSEfsvRgNJkbw075Q7ig
te4dNHSnSCixknt6zaEU
=Fs7L
-----END PGP SIGNATURE-----

--Signature=_Sun__3_Jun_2012_12_28_50_+1000_woiBprM3m9tS6IhH--
