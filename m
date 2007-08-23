Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail63.messagelabs.com (mail63.messagelabs.com [216.82.240.51])
	by ozlabs.org (Postfix) with SMTP id 5BA63DDEA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Aug 2007 07:06:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7E5C9.675C8DF3"
Subject: c67x00 driver again.
Date: Thu, 23 Aug 2007 16:05:58 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A17280@hsv1dafpew02.das.gov.sanm.corp>
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

------_=_NextPart_001_01C7E5C9.675C8DF3
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi=20all,

I=20think=20I=20am=20getting=20closer.=20=20With=20the=20c67x00=20hcd=20dr=
iver=20do=20I=20need=20the=20usb-hcd=20to=20be=20running?
I=20think=20I=20missed=20a=20link=20somewhere.=20=20The=20driver=20loads,=20=
buts=20inserting=20a=20memstick=20does=20nothing.
I'm=20thinking=20I=20need=20to=20be=20connected=20to=20the=20core=20someho=
w.=20=20I=20have=20the=20usb-core=20as=20builtin.

Again=20its=20heavily=20custom=202.6.17.3=20on=20a=20virtex-4=20ppc.=202=20=
usb=20ports=20wired=20out.
I=20had=20a=20meltdown=20yesterday=20so=20some=20of=20the=20prinks=20are=20=
different...

-----
c67x00=20init.
c67x00=20udc=20init.
c67x00=20drv=20probing.
c67x00=20before=20mem.
c67x00=20before=20irq.
c67x00=20before=20mem=20alloc.
c67x00=20setup=20sies.
c67x00=20before=20ll=20init.
c67x00=20c67x00.0:=20USB=20OTG=20controller,=20p:0x43e00000,=20v:0xc522000=
0,=20irq:3
c67x00=20c67x00_sie.0:=20Cypress=20C67X00=20Host=20Controller
c67x00=20c67x00_sie.0:=20new=20USB=20bus=20registered,=20assigned=20bus=20=
number=201
c67x00,=20hcd=20start.<6>usb=20usb1:=20configuration=20#1=20chosen=20from=20=
1=20choice
hub=201-0:1.0:=20USB=20hub=20found
hub=201-0:1.0:=202=20ports=20detected
c67x00=20c67x00_sie.1:=20Cypress=20C67X00=20Host=20Controller
c67x00=20c67x00_sie.1:=20new=20USB=20bus=20registered,=20assigned=20bus=20=
number=202
c67x00,=20hcd=20start.<6>usb=20usb2:=20configuration=20#1=20chosen=20from=20=
1=20choice
hub=202-0:1.0:=20USB=20hub=20found
hub=202-0:1.0:=202=20ports=20detected
Initializing=20USB=20Mass=20Storage=20driver...
usbcore:=20registered=20new=20driver=20usb-storage
USB=20Mass=20Storage=20support=20registered.
usb-storage:=20usb_stor_exit()=20called
usb-storage:=20--=20calling=20usb_deregister()
usbcore:=20deregistering=20driver=20usb-storage
Initializing=20USB=20Mass=20Storage=20driver...
usbcore:=20registered=20new=20driver=20usb-storage
USB=20Mass=20Storage=20support=20registered.
-----



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
------_=_NextPart_001_01C7E5C9.675C8DF3
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
<TITLE>c67x00=20driver=20again.</TITLE>
</HEAD>
<BODY>
<!--=20Converted=20from=20text/plain=20format=20-->
<BR>

<P><FONT=20SIZE=3D2>Hi=20all,<BR>
<BR>
I=20think=20I=20am=20getting=20closer.&nbsp;=20With=20the=20c67x00=20hcd=20=
driver=20do=20I=20need=20the=20usb-hcd=20to=20be=20running?<BR>
I=20think=20I=20missed=20a=20link=20somewhere.&nbsp;=20The=20driver=20load=
s,=20buts=20inserting=20a=20memstick=20does=20nothing.<BR>
I'm=20thinking=20I=20need=20to=20be=20connected=20to=20the=20core=20someho=
w.&nbsp;=20I=20have=20the=20usb-core=20as=20builtin.<BR>
<BR>
Again=20its=20heavily=20custom=202.6.17.3=20on=20a=20virtex-4=20ppc.=202=20=
usb=20ports=20wired=20out.<BR>
I=20had=20a=20meltdown=20yesterday=20so=20some=20of=20the=20prinks=20are=20=
different...<BR>
<BR>
-----<BR>
c67x00=20init.<BR>
c67x00=20udc=20init.<BR>
c67x00=20drv=20probing.<BR>
c67x00=20before=20mem.<BR>
c67x00=20before=20irq.<BR>
c67x00=20before=20mem=20alloc.<BR>
c67x00=20setup=20sies.<BR>
c67x00=20before=20ll=20init.<BR>
c67x00=20c67x00.0:=20USB=20OTG=20controller,=20p:0x43e00000,=20v:0xc522000=
0,=20irq:3<BR>
c67x00=20c67x00_sie.0:=20Cypress=20C67X00=20Host=20Controller<BR>
c67x00=20c67x00_sie.0:=20new=20USB=20bus=20registered,=20assigned=20bus=20=
number=201<BR>
c67x00,=20hcd=20start.&lt;6&gt;usb=20usb1:=20configuration=20#1=20chosen=20=
from=201=20choice<BR>
hub=201-0:1.0:=20USB=20hub=20found<BR>
hub=201-0:1.0:=202=20ports=20detected<BR>
c67x00=20c67x00_sie.1:=20Cypress=20C67X00=20Host=20Controller<BR>
c67x00=20c67x00_sie.1:=20new=20USB=20bus=20registered,=20assigned=20bus=20=
number=202<BR>
c67x00,=20hcd=20start.&lt;6&gt;usb=20usb2:=20configuration=20#1=20chosen=20=
from=201=20choice<BR>
hub=202-0:1.0:=20USB=20hub=20found<BR>
hub=202-0:1.0:=202=20ports=20detected<BR>
Initializing=20USB=20Mass=20Storage=20driver...<BR>
usbcore:=20registered=20new=20driver=20usb-storage<BR>
USB=20Mass=20Storage=20support=20registered.<BR>
usb-storage:=20usb_stor_exit()=20called<BR>
usb-storage:=20--=20calling=20usb_deregister()<BR>
usbcore:=20deregistering=20driver=20usb-storage<BR>
Initializing=20USB=20Mass=20Storage=20driver...<BR>
usbcore:=20registered=20new=20driver=20usb-storage<BR>
USB=20Mass=20Storage=20support=20registered.<BR>
-----<BR>
<BR>
<BR>
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
------_=_NextPart_001_01C7E5C9.675C8DF3--
