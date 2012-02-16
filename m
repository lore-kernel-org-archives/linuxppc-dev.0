Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 068261007D6
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 13:14:47 +1100 (EST)
Date: Thu, 16 Feb 2012 13:14:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Build fail in hugetlbpage.c with linux-next and mpc85xx_defconfig
Message-Id: <20120216131438.12149a2218f8fe4e7e46d83e@canb.auug.org.au>
In-Reply-To: <20120216111513.918494b07a5331eabe3d32ac@canb.auug.org.au>
References: <14174.1329347321@neuling.org>
 <20120216111513.918494b07a5331eabe3d32ac@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__16_Feb_2012_13_14_38_+1100_AfalFEsfqRczIY8x"
Cc: Michael Neuling <mikey@neuling.org>, Pawel Moll <pawel.moll@arm.com>,
 linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
 McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__16_Feb_2012_13_14_38_+1100_AfalFEsfqRczIY8x
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rusty,

On Thu, 16 Feb 2012 11:15:13 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> This was broken by commit b8076966e8e1 ("params: <level>_initcall-like
> kernel parameters") from the rr tree which changed the parse_args() API w=
ithout fixing all
> the callers ....

I have reverted the above commit (and the following fix one) for today.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__16_Feb_2012_13_14_38_+1100_AfalFEsfqRczIY8x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPPGaOAAoJEECxmPOUX5FE0gkP/2GHxozEHNP1IwLtOEwrVlYr
AEICalZIaLbcj8Tm5jZb0CtBmQjZGPgIAUSVlrd9e8yhKQDG37vSN0JnHf/GFpS1
Xy1YGkLWsrNwn+f0xXNKLFmCqj2CpZRQa5F37Dr2+9ojuX1XmeRq53bCu1dXD6ZE
WJMEVshXHNpgKgmfybwTcO2vDbm20TQs8wIDvVGeFuauze+1Q9wk1STZiwDLKFAp
rp3sI4hwal531S0RA5diRBBsqLnZ8xedbCxQarqVhO1UV3tTtfucMsw1zygykCcU
XmlMD2vLDVbagCkUk2JKYpRPZQwitgLsvtzQAqxK1weKUolfzU9mVhXC2KejgufO
G8AQTTUzA/X8fSHcQAH7VvdikaI1ML67gMgcuqBuS+ir6By17Kl0/qmQZ6Fzmms1
xLC28RXjsyaIFXFrSMg7wloZH+fi6yTL+iOuaxlQFhcajt4ATeRoVECgJio580Nl
4sKrXruuSh4g441sbO35o41D5KozvDdWiw4Gz0m0H5H5ezxqyIFU/VUIEGfnEUqh
YqVLcRrfzqdEmu0JvpjoASTeh6dHQWgs/lKzgAXKWH0ijUcZbJ+2QmnegIQadEtJ
/1b/Lv1v8ih91vBV2vlct6Cq08sZC29J23I0nPK/EI8LOorkWTyYKRrYVMlCutnK
pswQ8MSj5haE3NPVrwQx
=I1nu
-----END PGP SIGNATURE-----

--Signature=_Thu__16_Feb_2012_13_14_38_+1100_AfalFEsfqRczIY8x--
