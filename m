Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail170.messagelabs.com (mail170.messagelabs.com
	[216.82.253.227]) by ozlabs.org (Postfix) with SMTP id BAAD0DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 00:29:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7FEB7.60983B67"
Subject: Cypress C67x00 driver connects ?
Date: Mon, 24 Sep 2007 09:29:55 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A172AD@hsv1dafpew02.das.gov.sanm.corp>
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

------_=_NextPart_001_01C7FEB7.60983B67
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Can=20I=20connect=20the=20c67x00=20driver=20directly=20to=20the=20USB=20bu=
s?

I=20have=20a=20device,=20a=20virtex4=20fpga,=20with=20no=20PCI=20bus.=20=20=
I=20have=20a=20fpga=20bus=20to=20the=20cypress=20chip=20(c67300).
I=20have=20compiled=20the=20core=20USB=20code=20(but=20no=20uhci=20ohci).

It=20loads=20ok,=20detects=20and=20loads=202=20host=20sies.=20=20I=20get=20=
interrupts=20for=20all=20that=20(and=20the=203=20mailbox=20puts=20I=20do).=

But=20I=20was=20just=20connecting=20to=20'platfom_bus_type'.=20=20After=20=
all=20that=20I=20get=20no=20more=20interrupts.

The=20kernel=20drivers=20textbook=20doesn't=20quite=20match=20anymore,=20l=
inks=20to=20.hotplug=20in=20structs=20have=20moved.

Pointers=20to=20websites=20and=20papers=20appreciated.
I=20am=20using=20a=20custom=20kernel=20tree,=202.6.17.1,=20some=20of=20Gra=
nt=20Likely=20stuff=20is=20already=20in=20there=20(from=20the=20original=20=
developer=20on=20this=20project).

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
------_=_NextPart_001_01C7FEB7.60983B67
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
<TITLE>Cypress=20C67x00=20driver=20connects=20?</TITLE>
</HEAD>
<BODY>
<!--=20Converted=20from=20text/plain=20format=20-->

<P><FONT=20SIZE=3D2>Hi,<BR>
<BR>
Can=20I=20connect=20the=20c67x00=20driver=20directly=20to=20the=20USB=20bu=
s?<BR>
<BR>
I=20have=20a=20device,=20a=20virtex4=20fpga,=20with=20no=20PCI=20bus.&nbsp=
;=20I=20have=20a=20fpga=20bus=20to=20the=20cypress=20chip=20(c67300).<BR>
I=20have=20compiled=20the=20core=20USB=20code=20(but=20no=20uhci=20ohci).<=
BR>
<BR>
It=20loads=20ok,=20detects=20and=20loads=202=20host=20sies.&nbsp;=20I=20ge=
t=20interrupts=20for=20all=20that=20(and=20the=203=20mailbox=20puts=20I=20=
do).<BR>
But=20I=20was=20just=20connecting=20to=20'platfom_bus_type'.&nbsp;=20After=
=20all=20that=20I=20get=20no=20more=20interrupts.<BR>
<BR>
The=20kernel=20drivers=20textbook=20doesn't=20quite=20match=20anymore,=20l=
inks=20to=20.hotplug=20in=20structs=20have=20moved.<BR>
<BR>
Pointers=20to=20websites=20and=20papers=20appreciated.<BR>
I=20am=20using=20a=20custom=20kernel=20tree,=202.6.17.1,=20some=20of=20Gra=
nt=20Likely=20stuff=20is=20already=20in=20there=20(from=20the=20original=20=
developer=20on=20this=20project).<BR>
<BR>
Thanks,<BR>
Joe=20Robertson<BR>
<BR>
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
------_=_NextPart_001_01C7FEB7.60983B67--
