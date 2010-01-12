Return-Path: <stef.van.os@Prodrive.nl>
Received: from mail.prodrive.nl (mail.prodrive.nl [194.151.106.228])
	by ozlabs.org (Postfix) with ESMTP id B36F3B7C64
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 22:14:44 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PCI-PCI bridge scanning broken on 460EX
Date: Tue, 12 Jan 2010 12:14:20 +0100
Message-ID: <4CD35CD1F8085945B597F80EEC89421303B8AD10@exc01.bk.prodrive.nl>
In-Reply-To: <4B4C56D5.6020008@embedded-sol.com>
References: <4B388D9D.7010404@embedded-sol.com>	<1262584539.2173.335.camel@pasglop>	<4B41ADF1.1000400@embedded-sol.com>	<4B49CE8A.7000609@embedded-sol.com>	<1263155906.724.2.camel@pasglop>	<4B4A4307.5050704@embedded-sol.com>	<1263159117.724.15.camel@pasglop>	<4CD35CD1F8085945B597F80EEC89421303B8AD0C@exc01.bk.prodrive.nl>	<4B4B1027.4020708@embedded-sol.com>
	<4B4B55CF.9000707@embedded-sol.com>	<1263243199.724.146.camel@pasglop>
	<4B4BAAC0.4010300@embedded-sol.com>
	<1263250414.724.161.camel@pasglop>
	<4B4C56D5.6020008@embedded-sol.com>
From: "Stef van Os" <stef.van.os@Prodrive.nl>
To: "Felix Radensky" <felix@embedded-sol.com>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello=20Felix,

Glad=20to=20know=20this=20is=20working=20for=20you!

I'll=20try=20to=20send=20out=20a=20patch=20later=20today.=20The=20same=20=
change=20should=20also=20be
applied=20to=20the=20"ppc4xx_probe_pci_bridge"=20function,=20as=20it=20al=
so
initialises=20PCI=20without=20type=201=20transactions.

With=20kind=20regards=20/=20Met=20vriendelijke=20groet,

Stef=20van=20Os

Prodrive=20B.V.=20


-----Original=20Message-----
From:=20Felix=20Radensky=20[mailto:felix@embedded-sol.com]=20
Sent:=20dinsdag=2012=20januari=202010=2012:03
To:=20Benjamin=20Herrenschmidt
Cc:=20Stef=20van=20Os;=20Stefan=20Roese;=20Feng=20Kan;=20linuxppc-dev@ozl=
abs.org
Subject:=20Re:=20PCI-PCI=20bridge=20scanning=20broken=20on=20460EX

Hi=20Ben

Benjamin=20Herrenschmidt=20wrote:
>=20On=20Tue,=202010-01-12=20at=2000:48=20+0200,=20Felix=20Radensky=20wro=
te:
>=20=20=20
>>=20Maybe=20because=20the=20bus=20behind=20root=20P2P=20bridge=20is=20bu=
s=200,=20and=20type=201=20
>>=20cycles=20are=20needed=20for=20bus=20numbers=20greater=20than=200.=20=
That's=20what=20460EX=20
>>=20manual=20says.
>>=20=20=20=20=20
>
>=20Well,=20no...=20the=20bus=20behind=20the=20root=20P2P=20is=20bus=201=
=20...=20the=20root=20P2P=20
>=20itself=20is=20on=20bus=200...=20but=20then,=20it's=20some=20trick=20i=
n=20the=20way=20they=20
>=20implemented=20it=20I=20suppose.
>
>=20=20=20
>>=20You=20are=20correct,=20the=20log=20is=20from=20older=20version,=20wi=
thout=20Stef's=20fix.=20I

>>=20don't=20have=20access=20to=20a=20system=20with=20devices=20behind=20=
PLX,=20and=20the=20guy=20
>>=20who=20did=20the=20testing=20used=20wrong=20kernel.
>>=20I'll=20make=20sure=20he=20uses=20the=20correct=20one=20and=20get=20b=
ack=20to=20you.=20Maybe=20
>>=20everything=20works=20after=20all=20:)=20I'm=20really=20sorry=20for=
=20confusion.
>>=20=20=20=20=20
>
>=20No=20worries=20:-)=20Feel=20free=20to=20send=20a=20proper=20patch=20t=
o=20fix=20that=20problem=20
>=20upstream=20too=20!
>
>=20=20=20
The=20kernel=20with=20Stef's=20fix=20works=20fine,=20and=20recognizes=20b=
oth=20PLX=20and
device=20behind=20it.
Stef,=20=20do=20want=20to=20provide=20a=20patch=20for=20upstream=20kernel=
,=20or=20do=20you=20want=20me
to=20do=20that=20on=20your=20behalf=20?

Thanks=20a=20lot=20everyone=20for=20you=20help=20!

Felix.
Felix.

Disclaimer:=20The=20information=20contained=20in=20this=20email,=20includ=
ing=20any=20attachments=20is=20
confidential=20and=20is=20for=20the=20sole=20use=20of=20the=20intended=20=
recipient(s).=20Any=20unauthorized=20
review,=20use,=20disclosure=20or=20distribution=20is=20prohibited.=20If=
=20you=20are=20not=20the=20intended=20
recipient,=20please=20notify=20the=20sender=20immediately=20by=20replying=
=20to=20this=20message=20and=20
destroy=20all=20copies=20of=20this=20message=20and=20any=20attachments.
