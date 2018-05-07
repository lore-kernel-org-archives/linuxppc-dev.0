Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fqpm6Z2GzF1S1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 03:48:16 +1000 (AEST)
Date: Mon, 7 May 2018 19:47:33 +0200
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
 linux-kernel@vger.kernel.org,
 Benjamin Gilbert <benjamin.gilbert@coreos.com>,
 "Robin H. Johnson" <robbat2@gentoo.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 0/4] powerpc: wii_defconfig updates
Message-ID: <20180507174733.GB32665@latitude>
References: <20180507142019.32669-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
In-Reply-To: <20180507142019.32669-1-j.neuschaefer@gmx.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I forgot to CC the right set of people/mailing lists on the cover
letter. Sorry. Here it is:

On Mon, May 07, 2018 at 04:20:15PM +0200, Jonathan Neusch=C3=A4fer wrote:
> v1: https://www.spinics.net/lists/kernel/msg2790389.html
>     https://www.spinics.net/lists/kernel/msg2790385.html
>=20
> In the previous version of patch 2, I forgot to set CONFIG_NEW_LEDS and
> CONFIG_LEDS_TRIGGERS, so the more specific LED-related options weren't
> actually enabled, due to Kconfig dependencies. This is now fixed.
>=20
> I took the opportunity of a v2 to add two more patches that I wanted to
> send anyway. The SDHCIs in the Wii are currently unusable due to bugs/
> problems in the flipper-pic/hlwd-pic drivers, but I know how to fix
> those, and will send patches.
>=20
> Jonathan Neusch=C3=A4fer (4):
>   powerpc: wii_defconfig: Disable Ethernet driver support code
>   powerpc: wii_defconfig: Enable GPIO-related options
>   powerpc: wii_defconfig: Enable Wii SDHCI driver
>   powerpc: wii_defconfig: Disable BCMA support
>=20
>  arch/powerpc/configs/wii_defconfig | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> --=20
> 2.17.0
>=20

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJa8JEsAAoJEAgwRJqO81/bpY4QAKvB4XdQdzV2LswTM9PbQt2a
tkwSsa8zAJa6QWDZDp7wgZ1RMRZPhB/ZIrmDZ3S+6pApFpiv9JFSddsvtGkHvarY
j5o/P8TxKkdaGVbUslHCc5L8UUW/8EpPxo0aExi9U6vmvXpFjDY93RZJiXPb/PWs
/Q53GQuv2CRL9C41QhU/ZevZO5Nt0zdUVInmVuSbvL7fXMjC7E7UJPC97H9NU2ZL
DguxpG7yAhoQ4RNsH7bv254g+ZYHXRFKJzKEvhj/2cVnv3bOExLTnHmWJ/D4LjIC
GY/n1IzreL9YS7JHlx5bbOQ8R1SSpw1HJV8UNyDxiHzycIO8quUCr5TbqDnGL+nz
DHFpxHl4M1Dof6UmMW7uHZaDKjZwwSlJy+4DlE0sbFYYMg2PUZEwjNh5zOYHMB7z
sliFV18JgRPfsyc8GkfhDk/6SZz+F0zYvA1/lty0WT9dyGavj+GoulAvy3ybqqHM
8FL9SxdVXEMh47Dt7tzEgOh8p1HI9Xb+jY4uUmPTeTdRJ05r6zwJ5ySwmb6A8zHh
/viX64JfW2/pMqiQJZnahwQqVt3fe/xJPfV6uXVLeOIgfHAWB6AREQ0WwJhWfZll
eOof5HkLg0nOvKiofArh+a3IOebcrHjM2aY+GqIM1kZ19ALECYm+DCXpnnhkwbwe
/xfaDiBv7yjkLAj5gAuV
=DszJ
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
