Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail73.messagelabs.com (mail73.messagelabs.com [216.82.249.243])
	by ozlabs.org (Postfix) with SMTP id 1C88CDDE03
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 04:53:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7C4B5.EA56CA95"
Subject: RE: XSysAce driver cant mount DOS part
Date: Thu, 12 Jul 2007 13:53:20 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A17206@hsv1dafpew02.das.gov.sanm.corp>
References: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp>
	<fa686aa40707121116l1d76078aq82926eb861720474@mail.gmail.com>
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

------_=_NextPart_001_01C7C4B5.EA56CA95
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi!

Wow,=20quick=20replies.

RE:=20Tree.=20=20
Its=20the=20mainline=202.6.17.1,=20with
denx=20ppc=20patches=20from=204.0.0?=20=20IIRC.
I=20redid=20the=20patch=20set=20for=20the=20xsysace=20to=20get=20a=20known=
=20baseline.
Its=20a=20custom=20build=20system,=20which=20I=20developed=20over=20the=20=
years,=20ported=20to=20use=20a=20ppc405=20crosscompiler=20I=20made=20from
CrossTool-0.42.=20Its=20very=20similar=20to=20uClinux,=20but=20with=20a=20=
simpler=20config=20system.
The=20compiler=20is=20gcc.3.4.1=20with=20glibc=202.3.3=20(yeah=20we=20use=20=
glibc).

The=20XsysAce=20patch=20is=20in=20the=20normal=20place,=20only=20change=20=
I=20made=20was=20to=20define=20the=20major=20number.
And=20I=20moved=20xbasic_types.c/h=20to=20another=20folder=20onthe=20path=20=
since=20xilinx_iic=20drivers=20uses=20it=20too,=20and=20I=20was=20getting=20=
redefine=20errors.
One=20thing=20I=20just=20thought=20of=20was=20I=20did=20not=20run=20the=20=
'normal'=20config=20stuff,=20any=20deps=20in=20there?
I=20can=20go=20look=20at=20the=20kconfigs=20and=20see.

RE:=20Xilinx=20SysAce=20driver
The=20HW=20group=20used=20Xilinx=20env=208.2.02i,=20and=20the=20project=20=
shows=20Sysace_compactflash=20driver:=20=20sysace_v1_01_a

The=20HW=20is=20a=20Virtex-4=20with=20the=20embedded=20ppc405.=20=20The=20=
Xsysace=20chip=20is=20supposed=20tobe=20using=20irq_intr=20=3D=202.

The=20system=20actually=20works=20fine=20using=20the=20Ext2=20fs,=20but=20=
if=20we=20want=20to=20upgrade=20the=20fpga=20code,=20I=20need=20to=20be=20=
able=20to=20write=20to=20the=20dos=20part.

Thanks=20so=20much.


Joe=20Robertson
Joseph.Robertson@sanmina-sci.com





-----Original=20Message-----
From:=20glikely@secretlab.ca=20on=20behalf=20of=20Grant=20Likely
Sent:=20Thu=207/12/2007=201:16=20PM
To:=20Robertson,=20Joseph=20M.
Cc:=20linuxppc-embedded@ozlabs.org
Subject:=20Re:=20XSysAce=20driver=20cant=20mount=20DOS=20part
=20
On=207/12/07,=20Robertson,=20Joseph=20M.=20<joseph.robertson@sanmina-sci.c=
om>=20wrote:
>
>=20=20I've=20been=20workig=20with=20this=20for=20a=20while=20but=20have=20=
made=20no=20progress.
>=20=20Today=20I=20got=20the=20latest=20XSysAce=20patch=20for=20kernel=202=
.6.17.1=20and=20applied=20it=20to
>=20get=20clean=20code.
>=20=20I=20inherited=20the=20previous=20code=20from=20another=20developer.=


Who's=20tree=20are=20you=20using?=20=20Montavistas?=20=20Mainline?

Which=20sysace=20driver=20are=20you=20using?=20=20The=20old=20one=20from=20=
Xilinx=20or=20the=20new=20one?

>
>=20=20My=20problem=20is=20that=20mounting=20the=20DOS=20partition=20alway=
s=20fails=20in=20a=20short=20time
>=20with=20a=20kernel=20oops.
>
>=20=20ECAU-9999:#=20Oops:=20kernel=20access=20of=20bad=20area,=20sig:=201=
1=20[#1]
>
>=20=20PREEMPT
---8<---snip--->8---
>=20=20LR=20[C0070C18]=20drain_array+0xb8/0x124
>
>=20=20Call=20Trace:

Did=20you=20trim=20off=20the=20call=20trace?=20=20The=20call=20trace=20is=20=
pretty=20useful=20for
figuring=20out=20what=20happened.

Cheers,
g.

--=20
Grant=20Likely,=20B.Sc.,=20P.Eng.
Secret=20Lab=20Technologies=20Ltd.
grant.likely@secretlab.ca
(403)=20399-0195




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
------_=_NextPart_001_01C7C4B5.EA56CA95
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

<P><FONT=20SIZE=3D2>Hi!<BR>
<BR>
Wow,=20quick=20replies.<BR>
<BR>
RE:=20Tree.&nbsp;<BR>
Its=20the=20mainline=202.6.17.1,=20with<BR>
denx=20ppc=20patches=20from=204.0.0?&nbsp;=20IIRC.<BR>
I=20redid=20the=20patch=20set=20for=20the=20xsysace=20to=20get=20a=20known=
=20baseline.<BR>
Its=20a=20custom=20build=20system,=20which=20I=20developed=20over=20the=20=
years,=20ported=20to=20use=20a=20ppc405=20crosscompiler=20I=20made=20from<=
BR>
CrossTool-0.42.=20Its=20very=20similar=20to=20uClinux,=20but=20with=20a=20=
simpler=20config=20system.<BR>
The=20compiler=20is=20gcc.3.4.1=20with=20glibc=202.3.3=20(yeah=20we=20use=20=
glibc).<BR>
<BR>
The=20XsysAce=20patch=20is=20in=20the=20normal=20place,=20only=20change=20=
I=20made=20was=20to=20define=20the=20major=20number.<BR>
And=20I=20moved=20xbasic_types.c/h=20to=20another=20folder=20onthe=20path=20=
since=20xilinx_iic=20drivers=20uses=20it=20too,=20and=20I=20was=20getting=20=
redefine=20errors.<BR>
One=20thing=20I=20just=20thought=20of=20was=20I=20did=20not=20run=20the=20=
'normal'=20config=20stuff,=20any=20deps=20in=20there?<BR>
I=20can=20go=20look=20at=20the=20kconfigs=20and=20see.<BR>
<BR>
RE:=20Xilinx=20SysAce=20driver<BR>
The=20HW=20group=20used=20Xilinx=20env=208.2.02i,=20and=20the=20project=20=
shows=20Sysace_compactflash=20driver:&nbsp;=20sysace_v1_01_a<BR>
<BR>
The=20HW=20is=20a=20Virtex-4=20with=20the=20embedded=20ppc405.&nbsp;=20The=
=20Xsysace=20chip=20is=20supposed=20tobe=20using=20irq_intr=20=3D=202.<BR>=

<BR>
The=20system=20actually=20works=20fine=20using=20the=20Ext2=20fs,=20but=20=
if=20we=20want=20to=20upgrade=20the=20fpga=20code,=20I=20need=20to=20be=20=
able=20to=20write=20to=20the=20dos=20part.<BR>
<BR>
Thanks=20so=20much.<BR>
<BR>
<BR>
Joe=20Robertson<BR>
Joseph.Robertson@sanmina-sci.com<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
-----Original=20Message-----<BR>
From:=20glikely@secretlab.ca=20on=20behalf=20of=20Grant=20Likely<BR>
Sent:=20Thu=207/12/2007=201:16=20PM<BR>
To:=20Robertson,=20Joseph=20M.<BR>
Cc:=20linuxppc-embedded@ozlabs.org<BR>
Subject:=20Re:=20XSysAce=20driver=20cant=20mount=20DOS=20part<BR>
<BR>
On=207/12/07,=20Robertson,=20Joseph=20M.=20&lt;joseph.robertson@sanmina-sc=
i.com&gt;=20wrote:<BR>
&gt;<BR>
&gt;&nbsp;=20I've=20been=20workig=20with=20this=20for=20a=20while=20but=20=
have=20made=20no=20progress.<BR>
&gt;&nbsp;=20Today=20I=20got=20the=20latest=20XSysAce=20patch=20for=20kern=
el=202.6.17.1=20and=20applied=20it=20to<BR>
&gt;=20get=20clean=20code.<BR>
&gt;&nbsp;=20I=20inherited=20the=20previous=20code=20from=20another=20deve=
loper.<BR>
<BR>
Who's=20tree=20are=20you=20using?&nbsp;=20Montavistas?&nbsp;=20Mainline?<B=
R>
<BR>
Which=20sysace=20driver=20are=20you=20using?&nbsp;=20The=20old=20one=20fro=
m=20Xilinx=20or=20the=20new=20one?<BR>
<BR>
&gt;<BR>
&gt;&nbsp;=20My=20problem=20is=20that=20mounting=20the=20DOS=20partition=20=
always=20fails=20in=20a=20short=20time<BR>
&gt;=20with=20a=20kernel=20oops.<BR>
&gt;<BR>
&gt;&nbsp;=20ECAU-9999:#=20Oops:=20kernel=20access=20of=20bad=20area,=20si=
g:=2011=20[#1]<BR>
&gt;<BR>
&gt;&nbsp;=20PREEMPT<BR>
---8&lt;---snip---&gt;8---<BR>
&gt;&nbsp;=20LR=20[C0070C18]=20drain_array+0xb8/0x124<BR>
&gt;<BR>
&gt;&nbsp;=20Call=20Trace:<BR>
<BR>
Did=20you=20trim=20off=20the=20call=20trace?&nbsp;=20The=20call=20trace=20=
is=20pretty=20useful=20for<BR>
figuring=20out=20what=20happened.<BR>
<BR>
Cheers,<BR>
g.<BR>
<BR>
--<BR>
Grant=20Likely,=20B.Sc.,=20P.Eng.<BR>
Secret=20Lab=20Technologies=20Ltd.<BR>
grant.likely@secretlab.ca<BR>
(403)=20399-0195<BR>
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
------_=_NextPart_001_01C7C4B5.EA56CA95--
