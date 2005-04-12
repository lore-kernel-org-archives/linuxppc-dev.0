Return-Path: <chris.elston@radstone.co.uk>
Received: from mail14.messagelabs.com (mail14.messagelabs.com [212.125.75.19])
	by ozlabs.org (Postfix) with SMTP id 6C7AD67B2C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 20:14:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 12 Apr 2005 11:07:38 +0100
Message-ID: <F38DEABE0E171746B133C1ABBD142D9703691B00@radmail.Radstone.Local>
From: "Chris Elston" <chris.elston@radstone.co.uk>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: MTD Mapping driver - out of vmalloc space
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>=20>=20How=20about=20setting=20PAGE_OFFSET=20to=200x80000000,=20that=20is=
=202G/2G=20split?
>=20>=20It=20would=20make=20enough=20virtual=20address=20space.=20I've=20n=
ever=20tried=20on=20PPC,
>=20>=20so=20I=20don't=20know=20the=20side=20effect=20of=20this.=20
>=20
>=20This=20is=20the=20ideal=20solution.=20=20It=20works=20fine=20with=20th=
e=20caveat=20that
>=20you=20have=20to=20be=20very=20aware=20of=20the=20virtual=20memory=20ma=
p=20of=20your=20board
>=20port=20when=20doing=20this.=20=20On=20ppc32,=20we=20have=20very=20fine=
=20grained=20options
>=20for=20manipulating=20this=20and=20other=20parameters=20under=20Advance=
d=20Options.
>=20If=20the=20original=20poster=20can=20provide=20more=20details=20then=20=
we=20can=20tell
>=20him=20the=20exact=20settings=20to=20use.

Thanks=20for=20everyone's=20input=20on=20this,=20I've=20moved=20the=20kern=
el=20virtual
base=20address=20to=200xa0000000,=20and=20it=20works=20fine=20now.=20=20

I'm=20still=20not=20convinced=20that=20this=20is=20a=20future=20proof=20so=
lution=20
though.=20=20What=20happens=20when=20I=20get=20a=20board=20with=20512MB=20=
Flash=201GB=20SDRAM?
I=20can=20push=20the=20top=20of=20the=20SDRAM=20out=20to=20the=20high=20me=
m=20area,=20but=20I'll=20
have=20to=20encroach=20further=20into=20user=20space=20to=20map=20the=20Fl=
ash.=20=20There's
no=20good=20reason=20that=20the=20whole=20of=20the=20Flash=20need=20be=20m=
apped=20at=20the=20same
time.=20(Perhaps=20performance?)

Thanks,

Chris.

________________________________________________________________________
This=20e-mail=20has=20been=20scanned=20for=20all=20viruses=20by=20Star.=20=
The
service=20is=20powered=20by=20MessageLabs.=20For=20more=20information=20on=
=20a=20proactive
anti-virus=20service=20working=20around=20the=20clock,=20around=20the=20gl=
obe,=20visit:
http://www.star.net.uk
________________________________________________________________________
