Return-Path: <sfr@canb.auug.org.au>
Received: from calzone.tip.net.au (calzone.tip.net.au
 [IPv6:2402:b800:7003:1::15])
 by ozlabs.org (Postfix) with ESMTP id BAEC0B702A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 21:17:58 +1100 (EST)
Date: Tue, 20 Dec 2011 21:17:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: bill4carson@gmail.com
Subject: Re: [PATCH] Copy machine descriptor after probe succeed
Message-Id: <20111220211751.7dcff65ecfb1c5eaf022070d@canb.auug.org.au>
In-Reply-To: <1324372127-8552-2-git-send-email-bill4carson@gmail.com>
References: <1324372127-8552-1-git-send-email-bill4carson@gmail.com>
 <1324372127-8552-2-git-send-email-bill4carson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__20_Dec_2011_21_17_51_+1100_IfPnRlY40bBl6jvM"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__20_Dec_2011_21_17_51_+1100_IfPnRlY40bBl6jvM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bill,

On Tue, 20 Dec 2011 17:08:47 +0800 bill4carson@gmail.com wrote:
>
> From: Bill Carson <bill4carson@gmail.com>
>=20
> It make more sense to copy machine descriptor AFTER machine probe return
> succeed.

Some of the platform's probe routines modify the ppc_md structure and so
assume that it is has been popluated before the probe routine is called.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__20_Dec_2011_21_17_51_+1100_IfPnRlY40bBl6jvM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO8GDPAAoJEECxmPOUX5FE8QUP/Rh2x/+r+PZ2GmZ08IH4Gnh+
R5zOSEI9HFos7npzNdTeAdIQzDY+MtL6OtQRlUPxnTvDQx7Sz9mk4RG409O3kNbw
2rJ+2Tg9ApTMl7Xhde/ZFbbOKCpmNbZwBG3rtjsDCasf0GKZIamU6h8Iyqj3KOVz
J8+yQ6sk0DggTgBRvMUdqv6dFFmMkYQtga3Q8bIN9xrYtbaM5m2hL+X1UgIpV7pb
I8020Mlc+ZDa7VF/OwzarBglp1UC0be5LIN0UpSFKf4k4wO6JQYm9L6NG+JCeVQ0
Zay1CHI9iBD4vusRiSDfvF5w+jQ98dI0FeI+ugJeRhgKTD1BPI4RIweQdByMjPZA
xcnISdrSv0zm2EcqAH15SENeSz3U919/5KQ4jGZ4H2VEt0vp+VcBDB9x0x6/W63A
vTHz8ZwgjbwPda8BvMNxbDS5IyLsHKIjkA/19SDmW1CodS0nZpBa4icBBvB4+t79
f1ghMq93YavjHePmRf5fi8s8NsbiXfYtgPMjflIjf6L7ZSJPSvgF+0xheczNRPgZ
LZ4mXOobkd01cOQoowmxXZpu3x+sEZWb+wm7qN1SHXvtqpib7rcaJdQHredbfEa4
gPIzS+XtuPPLxCOEQJKraG8D6xOavbGZR2SCEE7blLfzKyzna9fCDiqBRKt/S4ts
0Xy3IIVIuaIaJDQ/Z3K1
=B9Vs
-----END PGP SIGNATURE-----

--Signature=_Tue__20_Dec_2011_21_17_51_+1100_IfPnRlY40bBl6jvM--
