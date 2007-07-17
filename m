Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail53.messagelabs.com (mail53.messagelabs.com [216.82.249.211])
	by ozlabs.org (Postfix) with SMTP id AC890DDED3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jul 2007 08:15:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7C8BF.E821924E"
Subject: Cypress c67x00 Support?
Date: Tue, 17 Jul 2007 17:14:56 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A1721C@hsv1dafpew02.das.gov.sanm.corp>
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

------_=_NextPart_001_01C7C8BF.E821924E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I=20have=20some=20questions=20about=20the=20Cypress=20c67x00=20code=20that=
=20was=20posted=20a=20few=20days=20ago.
I=20got=20the=20many=20patches=20from=20the=20git=20(thanks=20Grant!),=20b=
ut=20I=20am=20wondering,=20

How=20did=20you=20guys=20fix=20up=20the=20Kconfigs=20to=20work=20with=20th=
e=20Xilinx=20Virtex-4=20fpga?

My=20hw=20guys=20have=20put=20the=20cypress=20chip=20on=20'the=20system=20=
ace'(OPB?)=20bus,=20a=2016=20bit=20bus,=20and=20I=20have=20the=20address=20=
to=20it.

But=20its=20definetely=20not=20PCI,=20and=20if=20you=20use=20a=20plain=20k=
ernel=20tree=20like=20I=20have,=20I=20cannot=20access=20any=20features=20w=
ithout=20turning=20on=20the=20PCI=20options.=20=20Which=20of=20course=20fa=
ils,=20since=20I=20have=20no=20PCI=20parameters=20to=20feed=20the=20code.

Perhaps=20a=20better=20question=20is:=20Is=20this=20code=20intended=20for=20=
the=20Virtex-4?
If=20no,=20then=20I=20will=20have=20to=20fix=20it=20up.


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
------_=_NextPart_001_01C7C8BF.E821924E
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
<TITLE>Cypress=20c67x00=20Support?</TITLE>
</HEAD>
<BODY>
<!--=20Converted=20from=20text/plain=20format=20-->

<P><FONT=20SIZE=3D2>Hi,<BR>
<BR>
I=20have=20some=20questions=20about=20the=20Cypress=20c67x00=20code=20that=
=20was=20posted=20a=20few=20days=20ago.<BR>
I=20got=20the=20many=20patches=20from=20the=20git=20(thanks=20Grant!),=20b=
ut=20I=20am=20wondering,<BR>
<BR>
How=20did=20you=20guys=20fix=20up=20the=20Kconfigs=20to=20work=20with=20th=
e=20Xilinx=20Virtex-4=20fpga?<BR>
<BR>
My=20hw=20guys=20have=20put=20the=20cypress=20chip=20on=20'the=20system=20=
ace'(OPB?)=20bus,=20a=2016=20bit=20bus,=20and=20I=20have=20the=20address=20=
to=20it.<BR>
<BR>
But=20its=20definetely=20not=20PCI,=20and=20if=20you=20use=20a=20plain=20k=
ernel=20tree=20like=20I=20have,=20I=20cannot=20access=20any=20features=20w=
ithout=20turning=20on=20the=20PCI=20options.&nbsp;=20Which=20of=20course=20=
fails,=20since=20I=20have=20no=20PCI=20parameters=20to=20feed=20the=20code=
.<BR>
<BR>
Perhaps=20a=20better=20question=20is:=20Is=20this=20code=20intended=20for=20=
the=20Virtex-4?<BR>
If=20no,=20then=20I=20will=20have=20to=20fix=20it=20up.<BR>
<BR>
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
------_=_NextPart_001_01C7C8BF.E821924E--
