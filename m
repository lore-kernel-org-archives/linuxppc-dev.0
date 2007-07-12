Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail65.messagelabs.com (mail65.messagelabs.com [216.82.244.83])
	by ozlabs.org (Postfix) with SMTP id 7A95CDDF8C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 05:10:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7C4B8.52949B3D"
Subject: RE: XSysAce driver cant mount DOS part
Date: Thu, 12 Jul 2007 14:10:34 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A17207@hsv1dafpew02.das.gov.sanm.corp>
References: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp>
	<1184264800.22249.17.camel@jaalaptop>
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

------_=_NextPart_001_01C7C4B8.52949B3D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

See=20answers=20to=20queries=20below.

Thanks,
Joe=20Robertson
Joseph.Robertson@sanmina-sci.com




-----Original=20Message-----
From:=20Jeff=20Angielski=20[mailto:jeff@theptrgroup.com]
Sent:=20Thu=207/12/2007=201:26=20PM
To:=20Robertson,=20Joseph=20M.
Cc:=20linuxppc-embedded@ozlabs.org
Subject:=20Re:=20XSysAce=20driver=20cant=20mount=20DOS=20part
=20
On=20Thu,=202007-07-12=20at=2013:03=20-0500,=20Robertson,=20Joseph=20M.=20=
wrote:
>=20Hi=20all,
>=20
>=20I've=20been=20workig=20with=20this=20for=20a=20while=20but=20have=20ma=
de=20no=20progress.
>=20Today=20I=20got=20the=20latest=20XSysAce=20patch=20for=20kernel=202.6.=
17.1=20and=20applied
>=20it=20to=20get=20clean=20code.=20
>=20I=20inherited=20the=20previous=20code=20from=20another=20developer.
>=20
>=20My=20problem=20is=20that=20mounting=20the=20DOS=20partition=20always=20=
fails=20in=20a=20short
>=20time=20with=20a=20kernel=20oops.

Can=20you=20access=20that=20partition=20on=20your=20Linux=20host=20using=20=
a=20CF=20adapter?

=20Yes.

Can=20you=20access=20that=20partition=20from=20the=20uboot=20prompt?

=20Dunno,=20I=20don't=20think=20I=20have=20uboot=20set=20to=20let=20me=20d=
o=20that.
=20precompiled=20setup,=20I'd=20have=20to=20work=20on=20it.
=20
How=20did=20you=20format=20that=20partition?=20=20mkfs.msdos?

=20=20Yes,=20mkdosfs=20-F=2016=20/dev/sda1=20=20(its=20a=20fat16,=2032Mb=20=
partition)




--=20
Jeff=20Angielski
The=20PTR=20Group
www.theptrgroup.com





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
------_=_NextPart_001_01C7C4B8.52949B3D
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
<TITLE>RE:=20XSysAce=20driver=20cant=20mount=20DOS=20part</TITLE>
</HEAD>
<BODY>
<!--=20Converted=20from=20text/plain=20format=20-->

<P><FONT=20SIZE=3D2>See=20answers=20to=20queries=20below.<BR>
<BR>
Thanks,<BR>
Joe=20Robertson<BR>
Joseph.Robertson@sanmina-sci.com<BR>
<BR>
<BR>
<BR>
<BR>
-----Original=20Message-----<BR>
From:=20Jeff=20Angielski=20[<A=20HREF=3D"mailto:jeff@theptrgroup.com">mail=
to:jeff@theptrgroup.com</A>]<BR>
Sent:=20Thu=207/12/2007=201:26=20PM<BR>
To:=20Robertson,=20Joseph=20M.<BR>
Cc:=20linuxppc-embedded@ozlabs.org<BR>
Subject:=20Re:=20XSysAce=20driver=20cant=20mount=20DOS=20part<BR>
<BR>
On=20Thu,=202007-07-12=20at=2013:03=20-0500,=20Robertson,=20Joseph=20M.=20=
wrote:<BR>
&gt;=20Hi=20all,<BR>
&gt;<BR>
&gt;=20I've=20been=20workig=20with=20this=20for=20a=20while=20but=20have=20=
made=20no=20progress.<BR>
&gt;=20Today=20I=20got=20the=20latest=20XSysAce=20patch=20for=20kernel=202=
.6.17.1=20and=20applied<BR>
&gt;=20it=20to=20get=20clean=20code.<BR>
&gt;=20I=20inherited=20the=20previous=20code=20from=20another=20developer.=
<BR>
&gt;<BR>
&gt;=20My=20problem=20is=20that=20mounting=20the=20DOS=20partition=20alway=
s=20fails=20in=20a=20short<BR>
&gt;=20time=20with=20a=20kernel=20oops.<BR>
<BR>
Can=20you=20access=20that=20partition=20on=20your=20Linux=20host=20using=20=
a=20CF=20adapter?<BR>
<BR>
&nbsp;Yes.<BR>
<BR>
Can=20you=20access=20that=20partition=20from=20the=20uboot=20prompt?<BR>
<BR>
&nbsp;Dunno,=20I=20don't=20think=20I=20have=20uboot=20set=20to=20let=20me=20=
do=20that.<BR>
&nbsp;precompiled=20setup,=20I'd=20have=20to=20work=20on=20it.<BR>
<BR>
How=20did=20you=20format=20that=20partition?&nbsp;=20mkfs.msdos?<BR>
<BR>
&nbsp;=20Yes,=20mkdosfs=20-F=2016=20/dev/sda1&nbsp;=20(its=20a=20fat16,=20=
32Mb=20partition)<BR>
<BR>
<BR>
<BR>
<BR>
--<BR>
Jeff=20Angielski<BR>
The=20PTR=20Group<BR>
www.theptrgroup.com<BR>
<BR>
<BR>
<BR>
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
------_=_NextPart_001_01C7C4B8.52949B3D--
