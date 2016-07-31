Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2CS52ZfSzDqP7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 16:37:07 +1000 (AEST)
Date: Sun, 31 Jul 2016 08:36:56 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Darren Stevens <darren@stevens-zone.net>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 luigi burdo <intermediadc@hotmail.com>,
 Julian Margetson <runaway@candw.ms>, Steven Jeffery <sajeffer@gmail.com>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>,
 "matthew@a-eon.biz" <matthew@a-eon.biz>,
 Kevin Saunders <kfs1971@gmail.com>, Lyle Hazelwood <lylehaze@gmail.com>,
 EntwicklerX <mail@entwickler-x.de>, "xray@relec.ch" <xray@relec.ch>,
 Steve-David Marguet <steve@esdeem.ch>, George Sokianos <walkero@gmail.com>,
 Sinan =?utf-8?Q?G=C3=BCrkan?= <sinan.amigaone@gmail.com>,
 Mike <michael.heltne@gmail.com>, Thomas Ferreira <macsociety@me.com>,
 Christian Zigotzky <info@xenosoft.de>, "pjs@pjsa.net" <pjs@pjsa.net>,
 Ben Cato Malkenes <ben.cato@gmail.com>
Subject: Re: [pasemi] problem with i2c-pasemi
Message-ID: <20160731063656.GA1606@katana>
References: <aed83bc1-e574-1a9f-de58-480c9164865c@xenosoft.de>
 <2d94a278-d1d8-b484-e9ca-aedf18051e1a@xenosoft.de>
 <a84c2b93-4dac-9148-9ae2-0824491d1f50@xenosoft.de>
 <ae855392-570c-e125-b71f-2d5bf0c33eef@xenosoft.de>
 <d869fc32-ba80-529e-06dd-481ecf533642@xenosoft.de>
 <8b0682d3-866a-31dd-f01b-3510f84307dc@xenosoft.de>
 <2847029a-e3a4-8099-b72f-89d5731baaed@xenosoft.de>
 <6ebc8c6f-ffee-ab4e-1ce1-bc29bf08569d@xenosoft.de>
 <20160730182012.GA1608@katana>
 <ae704d42-5b75-29c4-ac64-0302435c2f35@xenosoft.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
In-Reply-To: <ae704d42-5b75-29c4-ac64-0302435c2f35@xenosoft.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>     00:1c.2 SMBus: PA Semi, Inc PWRficient SMBus Controller (rev 01)
>        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Interrupt: pin A routed to IRQ 72
>        Region 0: I/O ports at 7f0280 [size=3D64]
>=20
> SMbus Controllers
> The CPU provides 3 SMbus controllers, and these are used to connect up
> various SMbus and I2C devices. The number of SMbusses is expanded to 7 vi=
a a
> 1:4 multiplexer on SMbus 1.

Can you send the output of 'i2cdetect -l' (you need i2c-tools for that).
I assume the multiplexed bus occupies the bus number the above bus 1c.2
wants to have. This was present all the time, my recent change only made
it visible.


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXnZyIAAoJEBQN5MwUoCm2GfQP/R1z06Zzx7V2aI9XYBdlOw0w
9hR3HTCDYyVS/D2iW8l+EeFoWlbRqADNdoCouS3k/I+4LQ3a8uTolqMKYQaNnkog
CPCbFlsYEh0IrMdEh/F0A1BD7mVVeNfgEoyzRuwEpzU6kCAyf/KMKQvNFnX5AzG4
P+nkgAG/lCCqXr0M5gwHIqPxvZrgdb2Gd7OZ3qPmgxPGiyZTq9W+lbd4rTW3I9WG
cKkwlDmnlkpAMSMhuvJ0qzD3Si5xT3DvJGJ49A+YMiCcsPvhI77Omh3ReLmPsw5t
YZvRl6v7rcfjKCfaLs/BwJQp7VG8l6I5TcebwVGq3KrQ5c38SwfOVgsrjaJvhR1T
6OSFg+OK9EEC+C5mjkwhefbYJpHKlWVQEaXKWSu4QhIDerAPj6MwOaWxBj7kCg4G
XmV2hx72DesEyFcbjn6XlYEosM663BwjvOP7sP6P4l2p0qrPufCIQOyVXFm9uAtc
lo+zvC/2wSGBQW7AQHc+wsia48ok8RPztSg4aV5Dg+xJC9WNz5BvrXUzBupzmYZX
c2SLBdDIhzZZiIY92APfcUSrQpKw4a9G7bmFpM9x08RgiFqmrsdnhPYqj10wyTO1
Hr6Pr71RPovivMaRmxr/cykAEpis/vPKW186ylhRiCl7JWZ6ACu+wpxnr0ZuakVJ
XV9OS06ZXi660tmwUQCK
=VzYf
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
