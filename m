Return-Path: <Sylvain.Joyeau@thomson.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: little endian page mapping on PQ3
Date: Fri, 24 Aug 2007 13:40:31 +0200
Message-ID: <B00307ADBC68954AA8D6FB3AC8FD66F30141DE36@rennsmail05.eu.thmulti.com>
From: "Joyeau Sylvain" <Sylvain.Joyeau@thomson.net>
To: "Jose Almeida" <jalmeida@sysgo.fr>,
	<Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jose,

You are right, PQ3 supports endianess choice on a per page basis.=20
Without any hook in Linux, you can remap physical address range (but =
RAM), by calling __ioremap() with the "_PAGE_ENDIAN" bit set in the =
flags.

--
sj

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+sylvain.joyeau=3Dthomson.net@ozlabs.or
> g=20
> [mailto:linuxppc-embedded-bounces+sylvain.joyeau=3Dthomson.net@o
> zlabs.org] On Behalf Of Jose Almeida
> Sent: vendredi 24 ao=FBt 2007 09:59
> To: Linuxppc-embedded@ozlabs.org
> Subject: little endian page mapping on PQ3
>=20
> Hi all,
>=20
> Looking at PQ3 documentation, it looks like there is a way to select
> on a page basis if we would like to map one particular page in BIG or
> LITTLE endian.
> This is a very nice feature when you need to exchange some data
> between a PC and a PQ3 target.
>=20
> I am wondering if someone have already tryed this PQ3 feature ?
> I guess this would require some kind of hook in the kernel ...
>=20
> Any clue ?
>=20
> Thanks -  Jose
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
