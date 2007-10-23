Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail64.messagelabs.com (mail64.messagelabs.com [216.82.249.227])
	by ozlabs.org (Postfix) with SMTP id 0A0CADDFE5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 04:43:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C815A4.90FE80E8"
Subject: C67x00 driver and usb keyboard
Date: Tue, 23 Oct 2007 13:43:13 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A172EF@hsv1dafpew02.das.gov.sanm.corp>
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

------_=_NextPart_001_01C815A4.90FE80E8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I=20have=20everything=20in=20the=20kernel=20about=20usb=20that=20will=20co=
mpile=20turned=20on.=20=20HID,=20input,=20mousedev,=20keybdev,=20usbcore,=20=
c67x00,=20usbhid.=20=20=20And=20yet=20a=20keyboard=20or=20mouse=20does=20n=
ot=20work.=20=20USB=20memory=20keys=20work=20fine.

c67x00=20detects=20keyboard=20and=20mouse,=20I=20get=20messages=20telling=20=
me=20the=20correct=20devices.=20=20But=20no=20key=20strokes=20or=20mouse=20=
input.=20=20Even=20cat=20/dev/input/mice=20gets=20nothing.

Kinda=20getting=20real=20tired=20of=20everyone=20saying=20it=20should=20'j=
ust=20work'.=20=20
Theres=20a=20way=20and=20a=20reason=20how=20the=20keyboard=20works,=20and=20=
something=20isn't=20right,=20it=20does=20not=20work.

Anyone=20ever=20have=20a=20similar=20problem?

Thanks,

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
------_=_NextPart_001_01C815A4.90FE80E8
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

<P><FONT=20SIZE=3D2>Hi,<BR>
<BR>
I=20have=20everything=20in=20the=20kernel=20about=20usb=20that=20will=20co=
mpile=20turned=20on.&nbsp;=20HID,=20input,=20mousedev,=20keybdev,=20usbcor=
e,=20c67x00,=20usbhid.&nbsp;&nbsp;=20And=20yet=20a=20keyboard=20or=20mouse=
=20does=20not=20work.&nbsp;=20USB=20memory=20keys=20work=20fine.<BR>
<BR>
c67x00=20detects=20keyboard=20and=20mouse,=20I=20get=20messages=20telling=20=
me=20the=20correct=20devices.&nbsp;=20But=20no=20key=20strokes=20or=20mous=
e=20input.&nbsp;=20Even=20cat=20/dev/input/mice=20gets=20nothing.<BR>
<BR>
Kinda=20getting=20real=20tired=20of=20everyone=20saying=20it=20should=20'j=
ust=20work'.&nbsp;<BR>
Theres=20a=20way=20and=20a=20reason=20how=20the=20keyboard=20works,=20and=20=
something=20isn't=20right,=20it=20does=20not=20work.<BR>
<BR>
Anyone=20ever=20have=20a=20similar=20problem?<BR>
<BR>
Thanks,<BR>
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
------_=_NextPart_001_01C815A4.90FE80E8--
