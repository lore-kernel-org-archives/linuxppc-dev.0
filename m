Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcFw74SMbzF12j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 09:13:41 +1100 (AEDT)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-83BC7C2C-F4A1-41A1-96C8-94D195D79D13
Mime-Version: 1.0 (1.0)
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20180207211725.GA27167@lunn.ch>
Date: Wed, 7 Feb 2018 23:13:27 +0100
Cc: mad skateman <madskateman@gmail.com>,
 Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jamie Krueger <jamie@bitbybitsoftwaregroup.com>
Message-Id: <9FB0E24D-AC58-45EA-9DDD-740E76A8C62E@xenosoft.de>
References: <1516125454.18795.87.camel@infinera.com>
 <20180116205342.GA29888@lunn.ch> <1516189651.18795.99.camel@infinera.com>
 <20180117134339.GC32299@lunn.ch>
 <DB3PR0402MB3849850266808EC52F88A783ECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <DB3PR0402MB3849865056493075A4F4317CECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <DB3PR0402MB38494AC5EE923A10053745DDECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <CAHkrCmGxFUbfEyufdYhFYA4jyOkh+W2z=1yZsZwv+O4t+hE_1w@mail.gmail.com>
 <1d62c827-0ff7-0372-a2f8-f1930e9f788c@xenosoft.de>
 <CAHkrCmGrp3eUKYqRpv4__qw24yvL3Fou+MNwaDCX=XGgmFqRRg@mail.gmail.com>
 <20180207211725.GA27167@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-83BC7C2C-F4A1-41A1-96C8-94D195D79D13
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

How can we fix the buffer problem?

Thanks,
Christian


On 7. Feb 2018, at 22:17, Andrew Lunn <andrew@lunn.ch> wrote:

On Wed, Feb 07, 2018 at 10:00:45PM +0100, mad skateman wrote:
Hi,

I just found out that something goes wrong within the ARP table (well thats
what i think). I hope someone has a clue..

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

This looks like 'normal' behaviour. It has been reported that the
device runs out of buffers. That means it will fail to receive ARP
replies. So the ARP entry will time out and be removed, as it should.

Fix the buffer problem, and ARP will likely work properly.

   Andrew=

--Apple-Mail-83BC7C2C-F4A1-41A1-96C8-94D195D79D13
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><p style=3D"margin: 0px; font-stretch: norm=
al; font-size: 12px; line-height: normal; font-family: Helvetica;"><span sty=
le=3D"font-size: 12pt;">Hi Andrew,</span></p><p style=3D"margin: 0px; font-s=
tretch: normal; font-size: 12px; line-height: normal; font-family: Helvetica=
; min-height: 13.8px;"><span style=3D"font-size: 12pt;"></span><br></p><p st=
yle=3D"margin: 0px; font-stretch: normal; font-size: 12px; line-height: norm=
al; font-family: Helvetica;"><span style=3D"font-size: 12pt;">How can we fix=
 the buffer problem?</span></p><p style=3D"margin: 0px; font-stretch: normal=
; font-size: 12px; line-height: normal; font-family: Helvetica; min-height: 1=
3.8px;"><span style=3D"font-size: 12pt;"></span><br></p><p style=3D"margin: 0=
px; font-stretch: normal; font-size: 12px; line-height: normal; font-family:=
 Helvetica;"><span style=3D"font-size: 12pt;">Thanks,</span></p><p style=3D"=
margin: 0px; font-stretch: normal; font-size: 12px; line-height: normal; fon=
t-family: Helvetica;"><span style=3D"font-size: 12pt;">Christian</span></p><=
p style=3D"margin: 0px; font-stretch: normal; font-size: 12px; line-height: n=
ormal; font-family: Helvetica; min-height: 13.8px;"><span style=3D"font-size=
: 12pt;"></span><br></p><p style=3D"margin: 0px; font-stretch: normal; font-=
size: 12px; line-height: normal; font-family: Helvetica; min-height: 13.8px;=
"><span style=3D"font-size: 12pt;"></span><br></p><p style=3D"margin: 0px; f=
ont-stretch: normal; font-size: 12px; line-height: normal; font-family: Helv=
etica;"><span style=3D"font-size: 12pt;">On 7. Feb 2018, at 22:17, Andrew Lu=
nn &lt;<a href=3D"mailto:andrew@lunn.ch">andrew@lunn.ch</a>&gt; wrote:</span=
></p><p style=3D"margin: 0px; font-stretch: normal; font-size: 12px; line-he=
ight: normal; font-family: Helvetica; min-height: 13.8px;"><span style=3D"fo=
nt-size: 12pt;"></span><br></p><p style=3D"margin: 0px; font-stretch: normal=
; font-size: 12px; line-height: normal; font-family: Helvetica;"><span style=
=3D"font-size: 12pt;">On Wed, Feb 07, 2018 at 10:00:45PM +0100, mad skateman=
 wrote:</span></p><p style=3D"margin: 0px; font-stretch: normal; font-size: 1=
2px; line-height: normal; font-family: Helvetica;"><span style=3D"font-size:=
 12pt;">Hi,</span></p><p style=3D"margin: 0px; font-stretch: normal; font-si=
ze: 12px; line-height: normal; font-family: Helvetica; min-height: 13.8px;">=
<span style=3D"font-size: 12pt;"></span><br></p><p style=3D"margin: 0px; fon=
t-stretch: normal; font-size: 12px; line-height: normal; font-family: Helvet=
ica;"><span style=3D"font-size: 12pt;">I just found out that something goes w=
rong within the ARP table (well thats</span></p><p style=3D"margin: 0px; fon=
t-stretch: normal; font-size: 12px; line-height: normal; font-family: Helvet=
ica;"><span style=3D"font-size: 12pt;">what i think). I hope someone has a c=
lue..</span></p><p style=3D"margin: 0px; font-stretch: normal; font-size: 12=
px; line-height: normal; font-family: Helvetica; min-height: 13.8px;"><span s=
tyle=3D"font-size: 12pt;"></span><br></p><p style=3D"margin: 0px; font-stret=
ch: normal; font-size: 12px; line-height: normal; font-family: Helvetica;"><=
span style=3D"font-size: 12pt;">=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94</span></p><p style=3D"margin: 0px; font-stretch: normal; font-size=
: 12px; line-height: normal; font-family: Helvetica; min-height: 13.8px;"><s=
pan style=3D"font-size: 12pt;"></span><br></p><p style=3D"margin: 0px; font-=
stretch: normal; font-size: 12px; line-height: normal; font-family: Helvetic=
a;"><span style=3D"font-size: 12pt;">This looks like 'normal' behaviour. It h=
as been reported that the</span></p><p style=3D"margin: 0px; font-stretch: n=
ormal; font-size: 12px; line-height: normal; font-family: Helvetica;"><span s=
tyle=3D"font-size: 12pt;">device runs out of buffers. That means it will fai=
l to receive ARP</span></p><p style=3D"margin: 0px; font-stretch: normal; fo=
nt-size: 12px; line-height: normal; font-family: Helvetica;"><span style=3D"=
font-size: 12pt;">replies. So the ARP entry will time out and be removed, as=
 it should.</span></p><p style=3D"margin: 0px; font-stretch: normal; font-si=
ze: 12px; line-height: normal; font-family: Helvetica; min-height: 13.8px;">=
<span style=3D"font-size: 12pt;"></span><br></p><p style=3D"margin: 0px; fon=
t-stretch: normal; font-size: 12px; line-height: normal; font-family: Helvet=
ica;"><span style=3D"font-size: 12pt;">Fix the buffer problem, and ARP will l=
ikely work properly.</span></p><p style=3D"margin: 0px; font-stretch: normal=
; font-size: 12px; line-height: normal; font-family: Helvetica; min-height: 1=
3.8px;"><span style=3D"font-size: 12pt;"></span><br></p><p style=3D"margin: 0=
px; font-stretch: normal; font-size: 12px; line-height: normal; font-family:=
 Helvetica; min-height: 13.8px;"><span style=3D"font-size: 12pt;"></span>























</p><p style=3D"margin: 0px; font-stretch: normal; font-size: 12px; line-hei=
ght: normal; font-family: Helvetica;"><span style=3D"font-size: 12pt;">&nbsp=
;&nbsp; Andrew</span></p></body></html>=

--Apple-Mail-83BC7C2C-F4A1-41A1-96C8-94D195D79D13--
