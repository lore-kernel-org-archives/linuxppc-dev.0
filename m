Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail168.messagelabs.com (mail168.messagelabs.com
	[216.82.253.195]) by ozlabs.org (Postfix) with SMTP id 4F10FDDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 23:28:08 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7C551.A42EC36D"
Subject: RE: XSysAce driver cant mount DOS part
Date: Fri, 13 Jul 2007 08:28:04 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A1720A@hsv1dafpew02.das.gov.sanm.corp>
References: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp>
	<4697451E.3030409@gmail.com>
From: "Robertson, Joseph M." <joseph.robertson@sanmina-sci.com>
To: "urwithsudheer" <urwithsudheer@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C7C551.A42EC36D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,=20

Yes,=20I=20got=20it=20from=20here.
http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.1=
7.1-sysace-1.2.patch

The=20'official'=20one,=20yes?

Thanks,

Joe=20Robertson
Joseph.Robertson@sanmina-sci.com



-----Original=20Message-----
From:=20urwithsudheer=20[mailto:urwithsudheer@gmail.com]
Sent:=20Fri=207/13/2007=204:25=20AM
To:=20Robertson,=20Joseph=20M.
Cc:=20linuxppc-embedded@ozlabs.org
Subject:=20Re:=20XSysAce=20driver=20cant=20mount=20DOS=20part
=20
Hi

Robertson,=20Joseph=20M.=20wrote:
>
>=20Hi=20all,
>
>=20I've=20been=20workig=20with=20this=20for=20a=20while=20but=20have=20ma=
de=20no=20progress.
>=20Today=20I=20got=20the=20latest=20XSysAce=20patch=20for=20kernel=202.6.=
17.1=20and=20applied=20
>=20it=20to=20get=20clean=20code.=20
>=20I=20inherited=20the=20previous=20code=20from=20another=20developer.
>
Can=20you=20send=20the=20link=20to=20xsysace=20driver=20source=20code=20fr=
om=20where=20you=20obtained.


Thanks
Sudheer


>
>=20My=20problem=20is=20that=20mounting=20the=20DOS=20partition=20always=20=
fails=20in=20a=20short=20
>=20time=20with=20a=20kernel=20oops.
>
>=20ECAU-9999:#=20Oops:=20kernel=20access=20of=20bad=20area,=20sig:=2011=20=

>=20[#1]=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=

>=20PREEMPT=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>=20NIP:=20C00701C8=20LR:=20C0070C18=20CTR:=20
>=2000000000=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>=20REGS:=20c0391dd0=20TRAP:=200300=20=20=20Not=20tainted=20=20
>=20(2.6.17.1)=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
>=20MSR:=2000021030=20<ME,IR,DR>=20=20CR:=2022028082=20=20XER:=20
>=200000000B=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
>=20DAR:=2000000000,=20DSISR:=20
>=2000800000=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
>=20TASK=20=3D=20c0373030[4]=20'events/0'=20THREAD:=20
>=20c0390000=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
>=20GPR00:=2000000080=20C0391E80=20C0373030=20C02CAC00=20C0E03000=20C0E031=
54=2000000000=20
>=20C02CAC00=20
>=20GPR08:=2000200200=2000000000=2000100100=2000000000=2000051A4B=20FFFFDE=
60=2003BD4900=20
>=20007FFF3B=20
>=20GPR16:=2000400000=2000000001=20FFFFFFFF=2003BCDC58=2000000000=20007FFF=
00=2000000002=20
>=20C0280000=20
>=20GPR24:=20C0363A10=200000000B=2000000000=2000000000=2000000000=20C02CAC=
00=20C035ED20=20
>=20C0E03000=20
>=20NIP=20[C00701C8]=20
>=20free_block+0x8c/0x138=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>=20LR=20[C0070C18]=20
>=20drain_array+0xb8/0x124=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
>=20Call=20Trace:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>
>=20The=20setup:
>=20My=20own=20build=20system.
>=20Kernel=202.6.17.1=20with=20lots=20of=20xilinx=20stuff,=20eth,=20i2c,=20=
xsysace.=20=20
>=20Crosscompiled=20for=20PPC405.
>=20Latest,=20clean=20XSysAce=20code.=20=20mods:=20=20major=20hardcoded=20=
to=20=3D=20125.=20=20Polled=20
>=20mode.
>=20CF:=20=203=20partitions,
>=201:=20=20DOS=20FAT16
>=202:=20=20Ext2=20=20main
>=203:=20=20Ext2=20=20rescue
>
>=20This=20build=20boots=20up=20fine,=20mounts=20a=20ext2=20as=20root=20fi=
ne.=20=20I=20can=20also=20
>=20mount=20the=20rescue=20partition=20with=20no=20problems.
>
>=20Does=20anyone=20have=20any=20pointers=20of=20where=20I=20should=20look=
=20for=20problems?
>
>=20My=20next=20step=20is=20to=20go=20and=20set=20it=20up=20for=20interrup=
t=20service=20and=20see=20if=20
>=20that=20changes=20anything.
>
>=20Thanks,
>
>=20Joe=20Robertson
>=20Joseph.Robertson@sanmina-sci.com
>
>
>=20CONFIDENTIALITY
>=20This=20e-mail=20message=20and=20any=20attachments=20thereto,=20is=20in=
tended=20only=20for=20
>=20use=20by=20the=20addressee(s)=20named=20herein=20and=20may=20contain=20=
legally=20
>=20privileged=20and/or=20confidential=20information.=20If=20you=20are=20n=
ot=20the=20
>=20intended=20recipient=20of=20this=20e-mail=20message,=20you=20are=20her=
eby=20notified=20
>=20that=20any=20dissemination,=20distribution=20or=20copying=20of=20this=20=
e-mail=20
>=20message,=20and=20any=20attachments=20thereto,=20is=20strictly=20prohib=
ited.=20If=20you=20
>=20have=20received=20this=20e-mail=20message=20in=20error,=20please=20imm=
ediately=20notify=20
>=20the=20sender=20and=20permanently=20delete=20the=20original=20and=20any=
=20copies=20of=20this=20
>=20email=20and=20any=20prints=20thereof.
>=20ABSENT=20AN=20EXPRESS=20STATEMENT=20TO=20THE=20CONTRARY=20HEREINABOVE,=
=20THIS=20E-MAIL=20
>=20IS=20NOT=20INTENDED=20AS=20A=20SUBSTITUTE=20FOR=20A=20WRITING.=20Notwi=
thstanding=20the=20
>=20Uniform=20Electronic=20Transactions=20Act=20or=20the=20applicability=20=
of=20any=20other=20
>=20law=20of=20similar=20substance=20and=20effect,=20absent=20an=20express=
=20statement=20to=20
>=20the=20contrary=20hereinabove,=20this=20e-mail=20message=20its=20conten=
ts,=20and=20any=20
>=20attachments=20hereto=20are=20not=20intended=20to=20represent=20an=20of=
fer=20or=20
>=20acceptance=20to=20enter=20into=20a=20contract=20and=20are=20not=20othe=
rwise=20intended=20to=20
>=20bind=20the=20sender,=20Sanmina-SCI=20Corporation=20(or=20any=20of=20it=
s=20subsidiaries),=20
>=20or=20any=20other=20person=20or=20entity.
>=20----------------------------------------------------------------------=
--
>
>=20_______________________________________________
>=20Linuxppc-embedded=20mailing=20list
>=20Linuxppc-embedded@ozlabs.org
>=20https://ozlabs.org/mailman/listinfo/linuxppc-embedded



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
------_=_NextPart_001_01C7C551.A42EC36D
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

<P><FONT=20SIZE=3D2>Hi,<BR>
<BR>
Yes,=20I=20got=20it=20from=20here.<BR>
<A=20HREF=3D"http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/l=
inuxppc-2.6.17.1-sysace-1.2.patch">http://www.cs.york.ac.uk/rtslab/demos/a=
mos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch</A><BR>
<BR>
The=20'official'=20one,=20yes?<BR>
<BR>
Thanks,<BR>
<BR>
Joe=20Robertson<BR>
Joseph.Robertson@sanmina-sci.com<BR>
<BR>
<BR>
<BR>
-----Original=20Message-----<BR>
From:=20urwithsudheer=20[<A=20HREF=3D"mailto:urwithsudheer@gmail.com">mail=
to:urwithsudheer@gmail.com</A>]<BR>
Sent:=20Fri=207/13/2007=204:25=20AM<BR>
To:=20Robertson,=20Joseph=20M.<BR>
Cc:=20linuxppc-embedded@ozlabs.org<BR>
Subject:=20Re:=20XSysAce=20driver=20cant=20mount=20DOS=20part<BR>
<BR>
Hi<BR>
<BR>
Robertson,=20Joseph=20M.=20wrote:<BR>
&gt;<BR>
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
Can=20you=20send=20the=20link=20to=20xsysace=20driver=20source=20code=20fr=
om=20where=20you=20obtained.<BR>
<BR>
<BR>
Thanks<BR>
Sudheer<BR>
<BR>
<BR>
&gt;<BR>
&gt;=20My=20problem=20is=20that=20mounting=20the=20DOS=20partition=20alway=
s=20fails=20in=20a=20short<BR>
&gt;=20time=20with=20a=20kernel=20oops.<BR>
&gt;<BR>
&gt;=20ECAU-9999:#=20Oops:=20kernel=20access=20of=20bad=20area,=20sig:=201=
1<BR>
&gt;=20[#1]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&gt;=20PREEMPT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>=

&gt;=20NIP:=20C00701C8=20LR:=20C0070C18=20CTR:<BR>
&gt;=2000000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;<BR>
&gt;=20REGS:=20c0391dd0=20TRAP:=200300&nbsp;&nbsp;=20Not=20tainted&nbsp;<B=
R>
&gt;=20(2.6.17.1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&gt;=20MSR:=2000021030=20&lt;ME,IR,DR&gt;&nbsp;=20CR:=2022028082&nbsp;=20X=
ER:<BR>
&gt;=200000000B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;<BR>
&gt;=20DAR:=2000000000,=20DSISR:<BR>
&gt;=2000800000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;<BR>
&gt;=20TASK=20=3D=20c0373030[4]=20'events/0'=20THREAD:<BR>
&gt;=20c0390000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&gt;=20GPR00:=2000000080=20C0391E80=20C0373030=20C02CAC00=20C0E03000=20C0E=
03154=2000000000<BR>
&gt;=20C02CAC00<BR>
&gt;=20GPR08:=2000200200=2000000000=2000100100=2000000000=2000051A4B=20FFF=
FDE60=2003BD4900<BR>
&gt;=20007FFF3B<BR>
&gt;=20GPR16:=2000400000=2000000001=20FFFFFFFF=2003BCDC58=2000000000=20007=
FFF00=2000000002<BR>
&gt;=20C0280000<BR>
&gt;=20GPR24:=20C0363A10=200000000B=2000000000=2000000000=2000000000=20C02=
CAC00=20C035ED20<BR>
&gt;=20C0E03000<BR>
&gt;=20NIP=20[C00701C8]<BR>
&gt;=20free_block+0x8c/0x138&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&gt;=20LR=20[C0070C18]<BR>
&gt;=20drain_array+0xb8/0x124&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&gt;=20Call=20Trace:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>=

&gt;<BR>
&gt;=20The=20setup:<BR>
&gt;=20My=20own=20build=20system.<BR>
&gt;=20Kernel=202.6.17.1=20with=20lots=20of=20xilinx=20stuff,=20eth,=20i2c=
,=20xsysace.&nbsp;<BR>
&gt;=20Crosscompiled=20for=20PPC405.<BR>
&gt;=20Latest,=20clean=20XSysAce=20code.&nbsp;=20mods:&nbsp;=20major=20har=
dcoded=20to=20=3D=20125.&nbsp;=20Polled<BR>
&gt;=20mode.<BR>
&gt;=20CF:&nbsp;=203=20partitions,<BR>
&gt;=201:&nbsp;=20DOS=20FAT16<BR>
&gt;=202:&nbsp;=20Ext2&nbsp;=20main<BR>
&gt;=203:&nbsp;=20Ext2&nbsp;=20rescue<BR>
&gt;<BR>
&gt;=20This=20build=20boots=20up=20fine,=20mounts=20a=20ext2=20as=20root=20=
fine.&nbsp;=20I=20can=20also<BR>
&gt;=20mount=20the=20rescue=20partition=20with=20no=20problems.<BR>
&gt;<BR>
&gt;=20Does=20anyone=20have=20any=20pointers=20of=20where=20I=20should=20l=
ook=20for=20problems?<BR>
&gt;<BR>
&gt;=20My=20next=20step=20is=20to=20go=20and=20set=20it=20up=20for=20inter=
rupt=20service=20and=20see=20if<BR>
&gt;=20that=20changes=20anything.<BR>
&gt;<BR>
&gt;=20Thanks,<BR>
&gt;<BR>
&gt;=20Joe=20Robertson<BR>
&gt;=20Joseph.Robertson@sanmina-sci.com<BR>
&gt;<BR>
&gt;<BR>
&gt;=20CONFIDENTIALITY<BR>
&gt;=20This=20e-mail=20message=20and=20any=20attachments=20thereto,=20is=20=
intended=20only=20for<BR>
&gt;=20use=20by=20the=20addressee(s)=20named=20herein=20and=20may=20contai=
n=20legally<BR>
&gt;=20privileged=20and/or=20confidential=20information.=20If=20you=20are=20=
not=20the<BR>
&gt;=20intended=20recipient=20of=20this=20e-mail=20message,=20you=20are=20=
hereby=20notified<BR>
&gt;=20that=20any=20dissemination,=20distribution=20or=20copying=20of=20th=
is=20e-mail<BR>
&gt;=20message,=20and=20any=20attachments=20thereto,=20is=20strictly=20pro=
hibited.=20If=20you<BR>
&gt;=20have=20received=20this=20e-mail=20message=20in=20error,=20please=20=
immediately=20notify<BR>
&gt;=20the=20sender=20and=20permanently=20delete=20the=20original=20and=20=
any=20copies=20of=20this<BR>
&gt;=20email=20and=20any=20prints=20thereof.<BR>
&gt;=20ABSENT=20AN=20EXPRESS=20STATEMENT=20TO=20THE=20CONTRARY=20HEREINABO=
VE,=20THIS=20E-MAIL<BR>
&gt;=20IS=20NOT=20INTENDED=20AS=20A=20SUBSTITUTE=20FOR=20A=20WRITING.=20No=
twithstanding=20the<BR>
&gt;=20Uniform=20Electronic=20Transactions=20Act=20or=20the=20applicabilit=
y=20of=20any=20other<BR>
&gt;=20law=20of=20similar=20substance=20and=20effect,=20absent=20an=20expr=
ess=20statement=20to<BR>
&gt;=20the=20contrary=20hereinabove,=20this=20e-mail=20message=20its=20con=
tents,=20and=20any<BR>
&gt;=20attachments=20hereto=20are=20not=20intended=20to=20represent=20an=20=
offer=20or<BR>
&gt;=20acceptance=20to=20enter=20into=20a=20contract=20and=20are=20not=20o=
therwise=20intended=20to<BR>
&gt;=20bind=20the=20sender,=20Sanmina-SCI=20Corporation=20(or=20any=20of=20=
its=20subsidiaries),<BR>
&gt;=20or=20any=20other=20person=20or=20entity.<BR>
&gt;=20-------------------------------------------------------------------=
-----<BR>
&gt;<BR>
&gt;=20_______________________________________________<BR>
&gt;=20Linuxppc-embedded=20mailing=20list<BR>
&gt;=20Linuxppc-embedded@ozlabs.org<BR>
&gt;=20<A=20HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded"=
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded</A><BR>
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
------_=_NextPart_001_01C7C551.A42EC36D--
