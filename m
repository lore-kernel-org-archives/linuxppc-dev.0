Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id E60B5DDE08
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 17:39:28 +1000 (EST)
Message-ID: <4844F52D.8050203@matrix-vision.de>
Date: Tue, 03 Jun 2008 09:39:25 +0200
From: =?ISO-8859-15?Q?Andr=E9_Schwarz?= <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Fabio Tosetto <tosettofabio83@libero.it>
Subject: Re: slow MMC over SPI
References: <4843AD1C.4010901@matrix-vision.de> <4844DC96.6060807@libero.it>
In-Reply-To: <4844DC96.6060807@libero.it>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fabio,

I'm running on a MPC8343.
The SD-Card is connected on the spi hardware controller.


regards,
Andr=E9

Fabio Tosetto schrieb:
> Hello,
>=20
> I am trying to enable the SD over SPI on a emebedded system with one
> processor powerpc mpc5200b; you have enabled mmc over spi into a native=
=20
> spi or psc spi?
>=20
> regards,
> Fabio
>=20
> Andre Schwarz ha scritto:
>> All,
>>
>> has anybody made some investigations about performance of a SD/MMC car=
d
>> on SPI ?
>>
>> Actually I'm using various cards (different speed classes) on an SPI b=
us
>> of a MPC8343 cpu.
>> Everything is working fine basically, i.e. card is detected properly a=
nd
>> block device can be mounted and used.
>>
>> SPI clock is adjusted to the card's capabilities and is running quite
>> fast (>30MHz).
>>
>> But between consecutive reads/writes there's a fixed gap of 2us thus
>> yielding a poor performance of approx. 300KBytes/sec.
>> The spi bus is utilized only ~10%.
>>
>> Any ideas where this comes from ?
>> Ist it a fixed delay regarding to some kind of spec or is it possibly =
a
>> spi driver/mmc layer issue ?
>>
>>
>> regards,
>> Andre Schwarz
>>
>> MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  -=20
>> Registergericht: Amtsgericht Stuttgart, HRB 271090
>> Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>> .
>>
>>  =20
>=20


MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
