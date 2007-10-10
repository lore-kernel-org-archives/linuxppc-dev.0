Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail97.messagelabs.com (mail97.messagelabs.com [216.82.244.131])
	by ozlabs.org (Postfix) with SMTP id ABB35DDF76
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Oct 2007 23:50:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C80B44.92F4D007"
Subject: C67x00 driver and usb keyboard
Date: Wed, 10 Oct 2007 08:50:53 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A172D5@hsv1dafpew02.das.gov.sanm.corp>
From: "Robertson, Joseph M." <joseph.robertson@sanmina-sci.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C80B44.92F4D007
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi=20all,

Good=20News:=20=20I=20got=20the=20C67x00=20driver=20to=20work=20with=20my=20=
ppc-405=20+=20cypress=20usb=20controller!

I=20had=20to=20get=20the=20calls=20right=20to=20the=20cypress=20chip=20abo=
ut=20turning=20on=20the=20power=20to=20the=20ports.=20Our=20HW=20people=20=
wired=20all=20
that=20stuff=20up=20for=20us.=20=20So=20I=20had=20to=20make=20some=20pins=20=
outputs=20and=20turn=20them=20on.

Usb=20storage=20works.=20=20I=20can=20get=20udev=20to=20create=20a=20devic=
e=20and=20I=20can=20connect=20and=20use=20it.

BUT=20I=20cannot=20get=20a=20keyboard=20or=20mouse=20to=20work.

I=20have:
1.=20turned=20on=20all=20the=20keyboard=20stuff=20in=20the=20kernel
=20=20=20keyboard.o=20is=20being=20made,=20all=20the=20usbhid=20stuff=20is=
=20being=20compiled=20(made=20it=20a=20module).
2.=20loading=20the=20modules=20detects=20a=20usb=20keyboard=20and=20fills=20=
out=20the=20right=20id=20and=20vendor.
3.=20loading=20a=20mouse=20fills=20out=20the=20right=20id=20and=20vendor.
4.=20I=20have=20set=20my=20xwindows=20kdrive.cf=20to=20use=20XKB.

I=20don't=20know,=20anyone=20have=20any=20debugging=20tips=20for=20usb=20k=
eyboards?
My=20big=20problem=20is=20I=20cant=20find=20any=20good=20info=20on=20how=20=
usb=20keyboards=20are=20supposed=20to=20connect=20to=20the=20kernel=20and=20=
X.

I=20have=20a=20custom=202.6.17.1=20kernel,=20plus=20the=20c67x00=20driver.=

HW=20is=20a=20Virtex4=20with=20builtin=20PPC-405=20and=20cypress=20c67300=20=
usb=20controller.
Xfree=204.3.0=20building=20the=20kdrive,=20small=20X=20windows.


Joe=20Robertson
Joseph.Robertson@sanmina-sci.com


CONFIDENTIALITY
This=20e-mail=20message=20and=20any=20attachments=20thereto,=20is=20intend=
ed=20only=20for=20use=20by=20the=20addressee(s)=20named=20herein=20and=20m=
ay=20contain=20legally=20privileged=20and/or=20confidential=20information.=
=20If=20you=20are=20not=20the=20intended=20recipient=20of=20this=20e-mail=20=
message,=20you=20are=20hereby=20notified=20that=20any=20dissemination,=20d=
istribution=20or=20copying=20of=20this=20e-mail=20message,=20and=20any=20a=
ttachments=20thereto,=20is=20strictly=20prohibited.=20=20If=20you=20have=20=
received=20this=20e-mail=20message=20in=20error,=20please=20immediately=20=
notify=20the=20sender=20and=20permanently=20delete=20the=20original=20and=20=
any=20copies=20of=20this=20email=20and=20any=20prints=20thereof.
ABSENT=20AN=20EXPRESS=20STATEMENT=20TO=20THE=20CONTRARY=20HEREINABOVE,=20T=
HIS=20E-MAIL=20IS=20NOT=20INTENDED=20AS=20A=20SUBSTITUTE=20FOR=20A=20WRITI=
NG.=20=20Notwithstanding=20the=20Uniform=20Electronic=20Transactions=20Act=
=20or=20the=20applicability=20of=20any=20other=20law=20of=20similar=20subs=
tance=20and=20effect,=20absent=20an=20express=20statement=20to=20the=20con=
trary=20hereinabove,=20this=20e-mail=20message=20its=20contents,=20and=20a=
ny=20attachments=20hereto=20are=20not=20intended=20to=20represent=20an=20o=
ffer=20or=20acceptance=20to=20enter=20into=20a=20contract=20and=20are=20no=
t=20otherwise=20intended=20to=20bind=20the=20sender,=20Sanmina-SCI=20Corpo=
ration=20(or=20any=20of=20its=20subsidiaries),=20or=20any=20other=20person=
=20or=20entity.
------_=_NextPart_001_01C80B44.92F4D007
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE=20HTML=20PUBLIC=20"-//W3C//DTD=20HTML=203.2//EN">
<HTML>
<HEAD>
<META=20HTTP-EQUIV=3D"Content-Type"=20CONTENT=3D"text/html;=20charset=3DIS=
O-8859-1">
<META=20NAME=3D"Generator"=20CONTENT=3D"MS=20Exchange=20Server=20version=20=
6.5.7652.24">
<TITLE>C67x00=20driver=20and=20usb=20keyboard</TITLE>
</HEAD>
<BODY>
<!--=20Converted=20from=20text/plain=20format=20-->

<P><FONT=20SIZE=3D2>Hi=20all,<BR>
<BR>
Good=20News:&nbsp;=20I=20got=20the=20C67x00=20driver=20to=20work=20with=20=
my=20ppc-405=20+=20cypress=20usb=20controller!<BR>
<BR>
I=20had=20to=20get=20the=20calls=20right=20to=20the=20cypress=20chip=20abo=
ut=20turning=20on=20the=20power=20to=20the=20ports.=20Our=20HW=20people=20=
wired=20all<BR>
that=20stuff=20up=20for=20us.&nbsp;=20So=20I=20had=20to=20make=20some=20pi=
ns=20outputs=20and=20turn=20them=20on.<BR>
<BR>
Usb=20storage=20works.&nbsp;=20I=20can=20get=20udev=20to=20create=20a=20de=
vice=20and=20I=20can=20connect=20and=20use=20it.<BR>
<BR>
BUT=20I=20cannot=20get=20a=20keyboard=20or=20mouse=20to=20work.<BR>
<BR>
I=20have:<BR>
1.=20turned=20on=20all=20the=20keyboard=20stuff=20in=20the=20kernel<BR>
&nbsp;&nbsp;=20keyboard.o=20is=20being=20made,=20all=20the=20usbhid=20stuf=
f=20is=20being=20compiled=20(made=20it=20a=20module).<BR>
2.=20loading=20the=20modules=20detects=20a=20usb=20keyboard=20and=20fills=20=
out=20the=20right=20id=20and=20vendor.<BR>
3.=20loading=20a=20mouse=20fills=20out=20the=20right=20id=20and=20vendor.<=
BR>
4.=20I=20have=20set=20my=20xwindows=20kdrive.cf=20to=20use=20XKB.<BR>
<BR>
I=20don't=20know,=20anyone=20have=20any=20debugging=20tips=20for=20usb=20k=
eyboards?<BR>
My=20big=20problem=20is=20I=20cant=20find=20any=20good=20info=20on=20how=20=
usb=20keyboards=20are=20supposed=20to=20connect=20to=20the=20kernel=20and=20=
X.<BR>
<BR>
I=20have=20a=20custom=202.6.17.1=20kernel,=20plus=20the=20c67x00=20driver.=
<BR>
HW=20is=20a=20Virtex4=20with=20builtin=20PPC-405=20and=20cypress=20c67300=20=
usb=20controller.<BR>
Xfree=204.3.0=20building=20the=20kdrive,=20small=20X=20windows.<BR>
<BR>
<BR>
Joe=20Robertson<BR>
Joseph.Robertson@sanmina-sci.com<BR>
<BR>
</FONT>
</P>


<BR>
CONFIDENTIALITY<BR>
This=20e-mail=20message=20and=20any=20attachments=20thereto,=20is=20intend=
ed=20only=20for=20use=20by=20the=20addressee(s)=20named=20herein=20and=20m=
ay=20contain=20legally=20privileged=20and/or=20confidential=20information.=
=20If=20you=20are=20not=20the=20intended=20recipient=20of=20this=20e-mail=20=
message,=20you=20are=20hereby=20notified=20that=20any=20dissemination,=20d=
istribution=20or=20copying=20of=20this=20e-mail=20message,=20and=20any=20a=
ttachments=20thereto,=20is=20strictly=20prohibited.=20=20If=20you=20have=20=
received=20this=20e-mail=20message=20in=20error,=20please=20immediately=20=
notify=20the=20sender=20and=20permanently=20delete=20the=20original=20and=20=
any=20copies=20of=20this=20email=20and=20any=20prints=20thereof.<BR>
ABSENT=20AN=20EXPRESS=20STATEMENT=20TO=20THE=20CONTRARY=20HEREINABOVE,=20T=
HIS=20E-MAIL=20IS=20NOT=20INTENDED=20AS=20A=20SUBSTITUTE=20FOR=20A=20WRITI=
NG.=20=20Notwithstanding=20the=20Uniform=20Electronic=20Transactions=20Act=
=20or=20the=20applicability=20of=20any=20other=20law=20of=20similar=20subs=
tance=20and=20effect,=20absent=20an=20express=20statement=20to=20the=20con=
trary=20hereinabove,=20this=20e-mail=20message=20its=20contents,=20and=20a=
ny=20attachments=20hereto=20are=20not=20intended=20to=20represent=20an=20o=
ffer=20or=20acceptance=20to=20enter=20into=20a=20contract=20and=20are=20no=
t=20otherwise=20intended=20to=20bind=20the=20sender,=20Sanmina-SCI=20Corpo=
ration=20(or=20any=20of=20its=20subsidiaries),=20or=20any=20other=20person=
=20or=20entity.<BR>
</BODY>
</HTML>
------_=_NextPart_001_01C80B44.92F4D007--
