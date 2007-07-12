Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail74.messagelabs.com (mail74.messagelabs.com [216.82.244.99])
	by ozlabs.org (Postfix) with SMTP id 4EC6FDDEB9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 05:17:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7C4B9.3E47F771"
Subject: RE: XSysAce driver cant mount DOS part
Date: Thu, 12 Jul 2007 14:17:09 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A17208@hsv1dafpew02.das.gov.sanm.corp>
References: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp><fa686aa40707121116l1d76078aq82926eb861720474@mail.gmail.com><939D37AEB47F1F49B88FAB6599B6023501A17206@hsv1dafpew02.das.gov.sanm.corp>
	<fa686aa40707121206n7e75e770q742adb3659f35e79@mail.gmail.com>
From: "Robertson, Joseph M." <joseph.robertson@sanmina-sci.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
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

------_=_NextPart_001_01C7C4B9.3E47F771
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I=20will=20try=20the=20new=20code=20you=20suggest.=20=20We=20are=20not=20s=
upporting=20CF=20changes=20at=20all=20(factory=20only).


RE:=202.6.17.1=20being=20old.=20
Well,=20old=20is=20relative.=20=20Once=20this=20works,=20and=20its=2099%=20=
there,=20we=20won't=20change=20it.
We'll=20probably=20be=20using=20this=20kernel=20for=203-5=20years.
In=20fact,=20at=20this=20point=20we've=20got=202.5=20years=20invested,=20a=
nd=20about=204=20months=20of=20testing=20already,=20so=20changing=20now=20=
is=20bad.
That=20would=20mean=20I=20have=20to=20retest=20a=20whole=20bunch=20of=20st=
uff.

Thanks,
Joe=20Robertson
Joseph.Robertson@sanmina-sci.com



-----Original=20Message-----
From:=20glikely@secretlab.ca=20on=20behalf=20of=20Grant=20Likely
Sent:=20Thu=207/12/2007=202:06=20PM
To:=20Robertson,=20Joseph=20M.
Cc:=20linuxppc-embedded@ozlabs.org
Subject:=20Re:=20XSysAce=20driver=20cant=20mount=20DOS=20part
=20
On=207/12/07,=20Robertson,=20Joseph=20M.=20<joseph.robertson@sanmina-sci.c=
om>=20wrote:
>=20=20RE:=20Tree.
>=20=20Its=20the=20mainline=202.6.17.1,=20with
>=20=20denx=20ppc=20patches=20from=204.0.0?=20=20IIRC.
>=20=20I=20redid=20the=20patch=20set=20for=20the=20xsysace=20to=20get=20a=20=
known=20baseline.
>=20=20Its=20a=20custom=20build=20system,=20which=20I=20developed=20over=20=
the=20years,=20ported=20to=20use
>=20a=20ppc405=20crosscompiler=20I=20made=20from
>=20=20CrossTool-0.42.=20Its=20very=20similar=20to=20uClinux,=20but=20with=
=20a=20simpler=20config
>=20system.
>=20=20The=20compiler=20is=20gcc.3.4.1=20with=20glibc=202.3.3=20(yeah=20we=
=20use=20glibc).

Heh,=20so=20do=20I.=20=20So=20do=20a=20lot=20of=20people.=20=20glibc=20*is=
*=20for=20embedded
systems,=20regardless=20of=20what=20some=20may=20say.=20=20:-)

>=20=20The=20XsysAce=20patch=20is=20in=20the=20normal=20place,=20only=20ch=
ange=20I=20made=20was=20to=20define
>=20the=20major=20number.
>=20=20And=20I=20moved=20xbasic_types.c/h=20to=20another=20folder=20onthe=20=
path=20since=20xilinx_iic
>=20drivers=20uses=20it=20too,=20and=20I=20was=20getting=20redefine=20erro=
rs.
>=20=20One=20thing=20I=20just=20thought=20of=20was=20I=20did=20not=20run=20=
the=20'normal'=20config=20stuff,
>=20any=20deps=20in=20there?
>=20=20I=20can=20go=20look=20at=20the=20kconfigs=20and=20see.
>
>=20=20RE:=20Xilinx=20SysAce=20driver
>=20=20The=20HW=20group=20used=20Xilinx=20env=208.2.02i,=20and=20the=20pro=
ject=20shows
>=20Sysace_compactflash=20driver:=20=20sysace_v1_01_a

Okay,=20so=20that's=20the=20old=20driver.=20=20There=20is=20a=20new=20driv=
er=20that=20has
considerably=20better=20performance=20which=20you=20might=20want=20to=20tr=
y;=20but=20it
doesn't=20support=20insertion/removal=20yet.=20=20It=20is=20about=20to=20b=
e=20pulled=20into
mainline,=20but=20you=20can=20get=20it=20here=20too:

http://article.gmane.org/gmane.linux.kernel/526293/match=3Dxsysace+c

>
>=20=20The=20HW=20is=20a=20Virtex-4=20with=20the=20embedded=20ppc405.=20=20=
The=20Xsysace=20chip=20is
>=20supposed=20tobe=20using=20irq_intr=20=3D=202.
>
>=20=20The=20system=20actually=20works=20fine=20using=20the=20Ext2=20fs,=20=
but=20if=20we=20want=20to=20upgrade
>=20the=20fpga=20code,=20I=20need=20to=20be=20able=20to=20write=20to=20the=
=20dos=20part.

2.6.17=20is=20rather=20old.=20=20You=20might=20be=20hitting=20an=20old=20b=
ug.=20=20Virtex
support=20in=20the=20newer=20kernels=20is=20significantly=20better.=20=20H=
ave=20you
considered=20upgrading?=20=20I've=20got=20a=20bunch=20of=20patches=20in=20=
my=20git=20tree=20that
add=20the=20TEMAC=20and=20other=20drivers=20to=20a=20more=20recent=20kerne=
l.=20=20My=20internal
tree=20is=20based=20on=202.6.22;=20I'll=20try=20to=20update=20my=20externa=
l=20tree=20to=20match
in=20the=20next=20day=20or=20so:

http://git.secretlab.ca/cgi-bin/gitweb.cgi?h=3Dvirtex-dev;p=3Dlinux-2.6.gi=
t;a=3Dshortlog

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
------_=_NextPart_001_01C7C4B9.3E47F771
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
I=20will=20try=20the=20new=20code=20you=20suggest.&nbsp;=20We=20are=20not=20=
supporting=20CF=20changes=20at=20all=20(factory=20only).<BR>
<BR>
<BR>
RE:=202.6.17.1=20being=20old.<BR>
Well,=20old=20is=20relative.&nbsp;=20Once=20this=20works,=20and=20its=2099=
%=20there,=20we=20won't=20change=20it.<BR>
We'll=20probably=20be=20using=20this=20kernel=20for=203-5=20years.<BR>
In=20fact,=20at=20this=20point=20we've=20got=202.5=20years=20invested,=20a=
nd=20about=204=20months=20of=20testing=20already,=20so=20changing=20now=20=
is=20bad.<BR>
That=20would=20mean=20I=20have=20to=20retest=20a=20whole=20bunch=20of=20st=
uff.<BR>
<BR>
Thanks,<BR>
Joe=20Robertson<BR>
Joseph.Robertson@sanmina-sci.com<BR>
<BR>
<BR>
<BR>
-----Original=20Message-----<BR>
From:=20glikely@secretlab.ca=20on=20behalf=20of=20Grant=20Likely<BR>
Sent:=20Thu=207/12/2007=202:06=20PM<BR>
To:=20Robertson,=20Joseph=20M.<BR>
Cc:=20linuxppc-embedded@ozlabs.org<BR>
Subject:=20Re:=20XSysAce=20driver=20cant=20mount=20DOS=20part<BR>
<BR>
On=207/12/07,=20Robertson,=20Joseph=20M.=20&lt;joseph.robertson@sanmina-sc=
i.com&gt;=20wrote:<BR>
&gt;&nbsp;=20RE:=20Tree.<BR>
&gt;&nbsp;=20Its=20the=20mainline=202.6.17.1,=20with<BR>
&gt;&nbsp;=20denx=20ppc=20patches=20from=204.0.0?&nbsp;=20IIRC.<BR>
&gt;&nbsp;=20I=20redid=20the=20patch=20set=20for=20the=20xsysace=20to=20ge=
t=20a=20known=20baseline.<BR>
&gt;&nbsp;=20Its=20a=20custom=20build=20system,=20which=20I=20developed=20=
over=20the=20years,=20ported=20to=20use<BR>
&gt;=20a=20ppc405=20crosscompiler=20I=20made=20from<BR>
&gt;&nbsp;=20CrossTool-0.42.=20Its=20very=20similar=20to=20uClinux,=20but=20=
with=20a=20simpler=20config<BR>
&gt;=20system.<BR>
&gt;&nbsp;=20The=20compiler=20is=20gcc.3.4.1=20with=20glibc=202.3.3=20(yea=
h=20we=20use=20glibc).<BR>
<BR>
Heh,=20so=20do=20I.&nbsp;=20So=20do=20a=20lot=20of=20people.&nbsp;=20glibc=
=20*is*=20for=20embedded<BR>
systems,=20regardless=20of=20what=20some=20may=20say.&nbsp;=20:-)<BR>
<BR>
&gt;&nbsp;=20The=20XsysAce=20patch=20is=20in=20the=20normal=20place,=20onl=
y=20change=20I=20made=20was=20to=20define<BR>
&gt;=20the=20major=20number.<BR>
&gt;&nbsp;=20And=20I=20moved=20xbasic_types.c/h=20to=20another=20folder=20=
onthe=20path=20since=20xilinx_iic<BR>
&gt;=20drivers=20uses=20it=20too,=20and=20I=20was=20getting=20redefine=20e=
rrors.<BR>
&gt;&nbsp;=20One=20thing=20I=20just=20thought=20of=20was=20I=20did=20not=20=
run=20the=20'normal'=20config=20stuff,<BR>
&gt;=20any=20deps=20in=20there?<BR>
&gt;&nbsp;=20I=20can=20go=20look=20at=20the=20kconfigs=20and=20see.<BR>
&gt;<BR>
&gt;&nbsp;=20RE:=20Xilinx=20SysAce=20driver<BR>
&gt;&nbsp;=20The=20HW=20group=20used=20Xilinx=20env=208.2.02i,=20and=20the=
=20project=20shows<BR>
&gt;=20Sysace_compactflash=20driver:&nbsp;=20sysace_v1_01_a<BR>
<BR>
Okay,=20so=20that's=20the=20old=20driver.&nbsp;=20There=20is=20a=20new=20d=
river=20that=20has<BR>
considerably=20better=20performance=20which=20you=20might=20want=20to=20tr=
y;=20but=20it<BR>
doesn't=20support=20insertion/removal=20yet.&nbsp;=20It=20is=20about=20to=20=
be=20pulled=20into<BR>
mainline,=20but=20you=20can=20get=20it=20here=20too:<BR>
<BR>
<A=20HREF=3D"http://article.gmane.org/gmane.linux.kernel/526293/match=3Dxs=
ysace+c">http://article.gmane.org/gmane.linux.kernel/526293/match=3Dxsysac=
e+c</A><BR>
<BR>
&gt;<BR>
&gt;&nbsp;=20The=20HW=20is=20a=20Virtex-4=20with=20the=20embedded=20ppc405=
.&nbsp;=20The=20Xsysace=20chip=20is<BR>
&gt;=20supposed=20tobe=20using=20irq_intr=20=3D=202.<BR>
&gt;<BR>
&gt;&nbsp;=20The=20system=20actually=20works=20fine=20using=20the=20Ext2=20=
fs,=20but=20if=20we=20want=20to=20upgrade<BR>
&gt;=20the=20fpga=20code,=20I=20need=20to=20be=20able=20to=20write=20to=20=
the=20dos=20part.<BR>
<BR>
2.6.17=20is=20rather=20old.&nbsp;=20You=20might=20be=20hitting=20an=20old=20=
bug.&nbsp;=20Virtex<BR>
support=20in=20the=20newer=20kernels=20is=20significantly=20better.&nbsp;=20=
Have=20you<BR>
considered=20upgrading?&nbsp;=20I've=20got=20a=20bunch=20of=20patches=20in=
=20my=20git=20tree=20that<BR>
add=20the=20TEMAC=20and=20other=20drivers=20to=20a=20more=20recent=20kerne=
l.&nbsp;=20My=20internal<BR>
tree=20is=20based=20on=202.6.22;=20I'll=20try=20to=20update=20my=20externa=
l=20tree=20to=20match<BR>
in=20the=20next=20day=20or=20so:<BR>
<BR>
<A=20HREF=3D"http://git.secretlab.ca/cgi-bin/gitweb.cgi?h=3Dvirtex-dev;p=3D=
linux-2.6.git;a=3Dshortlog">http://git.secretlab.ca/cgi-bin/gitweb.cgi?h=3D=
virtex-dev;p=3Dlinux-2.6.git;a=3Dshortlog</A><BR>
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
------_=_NextPart_001_01C7C4B9.3E47F771--
