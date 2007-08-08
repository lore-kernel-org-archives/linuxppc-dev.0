Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail75.messagelabs.com (mail75.messagelabs.com [216.82.250.3])
	by ozlabs.org (Postfix) with SMTP id 8D798DDE9B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 06:34:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7D9FB.8ED866C4"
Subject: Cypress C67X00 driver question
Date: Wed, 8 Aug 2007 15:34:45 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A17257@hsv1dafpew02.das.gov.sanm.corp>
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

------_=_NextPart_001_01C7D9FB.8ED866C4
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi=20all,
First=20off=20big=20thanks=20to=20the=20guys=20working=20on=20the=20Cypres=
s=20USB=20C67X00=20driver!=20=20
Without=20them=20I=20would=20not=20even=20be=20this=20far.

But=20my=20question=20for=20them=20is:=20=20How=20are=20you=20guys=20initi=
alizing=20the=20Cypress=20chip?
It=20looks=20like=20the=20driver=20is=20expecting=20the=20cypress=20to=20b=
e=20programmed=20and=20ready.

I=20have=20a=20FPGA=20design=20with=20a=20Cypress=20C67300=20which=20has=20=
no=20eeprom=20or=20cpld,=20so=20it=20just=20comes=20up=20blank=20in=20copr=
ocessor=20mode.

I=20believe=20I=20need=20to=20'program'=20the=20chip=20and=20kick=20it=20b=
efore=20the=20driver=20loads=20is=20that=20right?
Has=20anyone=20ever=20done=20this=20before?=20=20
The=20Cypress=20docs=20do=20not=20even=20begin=20to=20provide=20a=20simple=
=20example=20of=20the=20minimum=20registers=20to=20set
before=20the=20usb=20will=20'work'.=20=20I=20just=20need=202=20hosts.

Thanks,

Joe=20Robertson
x8259
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
------_=_NextPart_001_01C7D9FB.8ED866C4
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE=20HTML=20PUBLIC=20"-//W3C//DTD=20HTML=203.2//EN">
<HTML>
<HEAD>
<META=20HTTP-EQUIV=3D"Content-Type"=20CONTENT=3D"text/html;=20charset=3Dis=
o-8859-1">
<META=20NAME=3D"Generator"=20CONTENT=3D"MS=20Exchange=20Server=20version=20=
6.5.7652.24">
<TITLE>Cypress=20C67X00=20driver=20question</TITLE>
</HEAD>
<BODY>
<!--=20Converted=20from=20text/plain=20format=20-->
<BR>

<P><FONT=20SIZE=3D2>Hi=20all,<BR>
First=20off=20big=20thanks=20to=20the=20guys=20working=20on=20the=20Cypres=
s=20USB=20C67X00=20driver!&nbsp;<BR>
Without=20them=20I=20would=20not=20even=20be=20this=20far.<BR>
<BR>
But=20my=20question=20for=20them=20is:&nbsp;=20How=20are=20you=20guys=20in=
itializing=20the=20Cypress=20chip?<BR>
It=20looks=20like=20the=20driver=20is=20expecting=20the=20cypress=20to=20b=
e=20programmed=20and=20ready.<BR>
<BR>
I=20have=20a=20FPGA=20design=20with=20a=20Cypress=20C67300=20which=20has=20=
no=20eeprom=20or=20cpld,=20so=20it=20just=20comes=20up=20blank=20in=20copr=
ocessor=20mode.<BR>
<BR>
I=20believe=20I=20need=20to=20'program'=20the=20chip=20and=20kick=20it=20b=
efore=20the=20driver=20loads=20is=20that=20right?<BR>
Has=20anyone=20ever=20done=20this=20before?&nbsp;<BR>
The=20Cypress=20docs=20do=20not=20even=20begin=20to=20provide=20a=20simple=
=20example=20of=20the=20minimum=20registers=20to=20set<BR>
before=20the=20usb=20will=20'work'.&nbsp;=20I=20just=20need=202=20hosts.<B=
R>
<BR>
Thanks,<BR>
<BR>
Joe=20Robertson<BR>
x8259<BR>
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
------_=_NextPart_001_01C7D9FB.8ED866C4--
