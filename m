Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail136.messagelabs.com (mail136.messagelabs.com [216.82.249.3])
	by ozlabs.org (Postfix) with SMTP id 97FA5DDEDE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 04:03:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7C4AE.E3F3F3EC"
Subject: XSysAce driver cant mount DOS part
Date: Thu, 12 Jul 2007 13:03:03 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp>
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

------_=_NextPart_001_01C7C4AE.E3F3F3EC
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi=20all,

I've=20been=20workig=20with=20this=20for=20a=20while=20but=20have=20made=20=
no=20progress.
Today=20I=20got=20the=20latest=20XSysAce=20patch=20for=20kernel=202.6.17.1=
=20and=20applied=20it=20to=20get=20clean=20code.=20=20
I=20inherited=20the=20previous=20code=20from=20another=20developer.

My=20problem=20is=20that=20mounting=20the=20DOS=20partition=20always=20fai=
ls=20in=20a=20short=20time=20with=20a=20kernel=20oops.

ECAU-9999:#=20Oops:=20kernel=20access=20of=20bad=20area,=20sig:=2011=20[#1=
]=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
PREEMPT=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=

NIP:=20C00701C8=20LR:=20C0070C18=20CTR:=2000000000=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
REGS:=20c0391dd0=20TRAP:=200300=20=20=20Not=20tainted=20=20(2.6.17.1)=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
MSR:=2000021030=20<ME,IR,DR>=20=20CR:=2022028082=20=20XER:=200000000B=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=

DAR:=2000000000,=20DSISR:=2000800000=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
TASK=20=3D=20c0373030[4]=20'events/0'=20THREAD:=20c0390000=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
GPR00:=2000000080=20C0391E80=20C0373030=20C02CAC00=20C0E03000=20C0E03154=20=
00000000=20C02CAC00=20=20
GPR08:=2000200200=2000000000=2000100100=2000000000=2000051A4B=20FFFFDE60=20=
03BD4900=20007FFF3B=20=20
GPR16:=2000400000=2000000001=20FFFFFFFF=2003BCDC58=2000000000=20007FFF00=20=
00000002=20C0280000=20=20
GPR24:=20C0363A10=200000000B=2000000000=2000000000=2000000000=20C02CAC00=20=
C035ED20=20C0E03000=20=20
NIP=20[C00701C8]=20free_block+0x8c/0x138=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
LR=20[C0070C18]=20drain_array+0xb8/0x124=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
Call=20Trace:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20

The=20setup:
My=20own=20build=20system.
Kernel=202.6.17.1=20with=20lots=20of=20xilinx=20stuff,=20eth,=20i2c,=20xsy=
sace.=20=20Crosscompiled=20for=20PPC405.
Latest,=20clean=20XSysAce=20code.=20=20mods:=20=20major=20hardcoded=20to=20=
=3D=20125.=20=20Polled=20mode.
CF:=20=203=20partitions,
1:=20=20DOS=20FAT16
2:=20=20Ext2=20=20main
3:=20=20Ext2=20=20rescue

This=20build=20boots=20up=20fine,=20mounts=20a=20ext2=20as=20root=20fine.=20=
=20I=20can=20also=20mount=20the=20rescue=20partition=20with=20no=20problem=
s.

Does=20anyone=20have=20any=20pointers=20of=20where=20I=20should=20look=20f=
or=20problems?

My=20next=20step=20is=20to=20go=20and=20set=20it=20up=20for=20interrupt=20=
service=20and=20see=20if=20that=20changes=20anything.
=20
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
------_=_NextPart_001_01C7C4AE.E3F3F3EC
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
<TITLE>XSysAce=20driver=20cant=20mount=20DOS=20part</TITLE>
</HEAD>
<BODY>
<!--=20Converted=20from=20text/plain=20format=20-->

<P><FONT=20SIZE=3D2>Hi=20all,<BR>
<BR>
I've=20been=20workig=20with=20this=20for=20a=20while=20but=20have=20made=20=
no=20progress.<BR>
Today=20I=20got=20the=20latest=20XSysAce=20patch=20for=20kernel=202.6.17.1=
=20and=20applied=20it=20to=20get=20clean=20code.&nbsp;<BR>
I=20inherited=20the=20previous=20code=20from=20another=20developer.<BR>
<BR>
My=20problem=20is=20that=20mounting=20the=20DOS=20partition=20always=20fai=
ls=20in=20a=20short=20time=20with=20a=20kernel=20oops.<BR>
<BR>
ECAU-9999:#=20Oops:=20kernel=20access=20of=20bad=20area,=20sig:=2011=20[#1=
]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
PREEMPT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
NIP:=20C00701C8=20LR:=20C0070C18=20CTR:=2000000000&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
REGS:=20c0391dd0=20TRAP:=200300&nbsp;&nbsp;=20Not=20tainted&nbsp;=20(2.6.1=
7.1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;<BR>
MSR:=2000021030=20&lt;ME,IR,DR&gt;&nbsp;=20CR:=2022028082&nbsp;=20XER:=200=
000000B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;<BR>
DAR:=2000000000,=20DSISR:=2000800000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
TASK=20=3D=20c0373030[4]=20'events/0'=20THREAD:=20c0390000&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
GPR00:=2000000080=20C0391E80=20C0373030=20C02CAC00=20C0E03000=20C0E03154=20=
00000000=20C02CAC00&nbsp;<BR>
GPR08:=2000200200=2000000000=2000100100=2000000000=2000051A4B=20FFFFDE60=20=
03BD4900=20007FFF3B&nbsp;<BR>
GPR16:=2000400000=2000000001=20FFFFFFFF=2003BCDC58=2000000000=20007FFF00=20=
00000002=20C0280000&nbsp;<BR>
GPR24:=20C0363A10=200000000B=2000000000=2000000000=2000000000=20C02CAC00=20=
C035ED20=20C0E03000&nbsp;<BR>
NIP=20[C00701C8]=20free_block+0x8c/0x138&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;<BR>
LR=20[C0070C18]=20drain_array+0xb8/0x124&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;<BR>
Call=20Trace:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
<BR>
The=20setup:<BR>
My=20own=20build=20system.<BR>
Kernel=202.6.17.1=20with=20lots=20of=20xilinx=20stuff,=20eth,=20i2c,=20xsy=
sace.&nbsp;=20Crosscompiled=20for=20PPC405.<BR>
Latest,=20clean=20XSysAce=20code.&nbsp;=20mods:&nbsp;=20major=20hardcoded=20=
to=20=3D=20125.&nbsp;=20Polled=20mode.<BR>
CF:&nbsp;=203=20partitions,<BR>
1:&nbsp;=20DOS=20FAT16<BR>
2:&nbsp;=20Ext2&nbsp;=20main<BR>
3:&nbsp;=20Ext2&nbsp;=20rescue<BR>
<BR>
This=20build=20boots=20up=20fine,=20mounts=20a=20ext2=20as=20root=20fine.&=
nbsp;=20I=20can=20also=20mount=20the=20rescue=20partition=20with=20no=20pr=
oblems.<BR>
<BR>
Does=20anyone=20have=20any=20pointers=20of=20where=20I=20should=20look=20f=
or=20problems?<BR>
<BR>
My=20next=20step=20is=20to=20go=20and=20set=20it=20up=20for=20interrupt=20=
service=20and=20see=20if=20that=20changes=20anything.<BR>
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
------_=_NextPart_001_01C7C4AE.E3F3F3EC--
