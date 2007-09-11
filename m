Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail170.messagelabs.com (mail170.messagelabs.com
	[216.82.253.227]) by ozlabs.org (Postfix) with SMTP id EDB41DDEFD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 00:47:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7F482.ADA53FCB"
Subject: Dumb pci bus question
Date: Tue, 11 Sep 2007 09:47:29 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A17297@hsv1dafpew02.das.gov.sanm.corp>
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

------_=_NextPart_001_01C7F482.ADA53FCB
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi=20All,

What=20do=20you=20folks=20do=20when=20the=20hardware=20dept.=20people=20do=
=20not=20provide=20a=20PCI=20bus,=20and=20everything=20in=20linux=20is=20p=
redicated=20upon=20having=20a=20pci=20bus?

No=20pci=20->=20no=20hotplug=20->=20no=20udev=20->=20no=20usb.

Do=20you=20hardwire=20all=20the=20drivers=20and=20devices?

This=20is=20what=20I=20have=20done=20so=20far,=20all=20the=20dev=20are=20h=
ardcoded=20in=20a=20ram=20disk,=20mounted=20to=20/ram,=20with=20symlink=20=
cleaning=20it=20allup=20to=20normal=20paths.=20=20I=20am=20curious,=20beca=
useof=20course=20all=20the=20docs=20are=20written=20by=20boobs=20using=20a=
=20desktop=20systm,=20and=20often=20include=20the=20phrase=20'and=20so=20i=
t=20just=20works.'=20=20Which=20of=20course=20is=20useless=20to=20someone=20=
trying=20to=20'understand=20how=20it=20works'.

Also=20need=20depmod=20to=20work=20in=20a=20cross-compile=20env=20too,=20r=
ight=20now=20it=20fails...

Thanks=20for=20listening....

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
------_=_NextPart_001_01C7F482.ADA53FCB
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
<TITLE>Dumb=20pci=20bus=20question</TITLE>
</HEAD>
<BODY>
<!--=20Converted=20from=20text/plain=20format=20-->
<BR>

<P><FONT=20SIZE=3D2>Hi=20All,<BR>
<BR>
What=20do=20you=20folks=20do=20when=20the=20hardware=20dept.=20people=20do=
=20not=20provide=20a=20PCI=20bus,=20and=20everything=20in=20linux=20is=20p=
redicated=20upon=20having=20a=20pci=20bus?<BR>
<BR>
No=20pci=20-&gt;=20no=20hotplug=20-&gt;=20no=20udev=20-&gt;=20no=20usb.<BR=
>
<BR>
Do=20you=20hardwire=20all=20the=20drivers=20and=20devices?<BR>
<BR>
This=20is=20what=20I=20have=20done=20so=20far,=20all=20the=20dev=20are=20h=
ardcoded=20in=20a=20ram=20disk,=20mounted=20to=20/ram,=20with=20symlink=20=
cleaning=20it=20allup=20to=20normal=20paths.&nbsp;=20I=20am=20curious,=20b=
ecauseof=20course=20all=20the=20docs=20are=20written=20by=20boobs=20using=20=
a=20desktop=20systm,=20and=20often=20include=20the=20phrase=20'and=20so=20=
it=20just=20works.'&nbsp;=20Which=20of=20course=20is=20useless=20to=20some=
one=20trying=20to=20'understand=20how=20it=20works'.<BR>
<BR>
Also=20need=20depmod=20to=20work=20in=20a=20cross-compile=20env=20too,=20r=
ight=20now=20it=20fails...<BR>
<BR>
Thanks=20for=20listening....<BR>
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
------_=_NextPart_001_01C7F482.ADA53FCB--
