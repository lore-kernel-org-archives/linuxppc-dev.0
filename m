Return-Path: <fabien.oriede@yahoo.fr>
Received: from web27401.mail.ukl.yahoo.com (web27401.mail.ukl.yahoo.com
	[217.146.177.177]) by ozlabs.org (Postfix) with SMTP id 70248DDF77
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Aug 2008 20:06:51 +1000 (EST)
Date: Thu, 7 Aug 2008 10:06:49 +0000 (GMT)
From: Fabien Oriede <fabien.oriede@yahoo.fr>
Subject: Re : kernel 2.6.26 & gcc 4.0.0
To: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2042487601-1218103609=:59127"
Message-ID: <292718.59127.qm@web27401.mail.ukl.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2042487601-1218103609=:59127
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

No, I did not modify this file.=0A=0A=0A----- Message d'origine ----=0ADe :=
 Marco Stornelli <marco.stornelli@coritel.it>=0A=C3=80 : Fabien Oriede <fab=
ien.oriede@yahoo.fr>=0ACc : linuxppc-embedded@ozlabs.org=0AEnvoy=C3=A9 le :=
 Jeudi, 7 Ao=C3=BBt 2008, 11h59mn 19s=0AObjet=C2=A0: Re: kernel 2.6.26 & gc=
c 4.0.0=0A=0AFabien Oriede ha scritto:=0A> Hello all,=0A> I'm trying to put=
 a cramfs image on my custom board, and for this, I have followed this topi=
c : http://www.denx.de/wiki/view/DULG/RootFileSystemOnACramfsFileSystem=0A>=
 Now I have my cramfs image, but I have seen that I need to download my cra=
mfs image in a mtdblock and for that, I need to set some MTD options in the=
 kernel. (http://www.denx.de/wiki/view/DULG/FlashFilesystemsMTD)=0A> But wh=
en I make the command "make uImage", I have this problem :=0A> [root@xxxx l=
inux-2.6.26]# make uImage=0A>=C2=A0 CHK=C2=A0 =C2=A0 include/linux/version.=
h=0A>=C2=A0 CHK=C2=A0 =C2=A0 include/linux/utsrelease.h=0A>=C2=A0 CALL=C2=
=A0 =C2=A0 scripts/checksyscalls.sh=0A>=C2=A0 CHK=C2=A0 =C2=A0 include/linu=
x/compile.h=0A>=C2=A0 CALL=C2=A0 =C2=A0 arch/powerpc/kernel/systbl_chk.sh=
=0A>=C2=A0 CC=C2=A0 =C2=A0 =C2=A0 arch/ppc/syslib/m8xx_setup.o=0A> arch/ppc=
/syslib/m8xx_setup.c:68: error: array type has incomplete element type=0A> =
arch/ppc/syslib/m8xx_setup.c:70: error: field name not in record or union i=
nitializer=0A> arch/ppc/syslib/m8xx_setup.c:70: error: (near initialization=
 for 'mpc8xxads_partitions')=0A> arch/ppc/syslib/m8xx_setup.c:71: error: fi=
eld name not in record or union initializer=0A> arch/ppc/syslib/m8xx_setup.=
c:71: error: (near initialization for 'mpc8xxads_partitions')=0A> arch/ppc/=
syslib/m8xx_setup.c:72: error: field name not in record or union initialize=
r=0A> arch/ppc/syslib/m8xx_setup.c:72: error: (near initialization for 'mpc=
8xxads_partitions')=0A> arch/ppc/syslib/m8xx_setup.c:73: error: field name =
not in record or union initializer=0A> arch/ppc/syslib/m8xx_setup.c:73: err=
or: (near initialization for 'mpc8xxads_partitions')=0A> arch/ppc/syslib/m8=
xx_setup.c:73: error: 'MTD_WRITEABLE' undeclared here (not in a function)=
=0A> arch/ppc/syslib/m8xx_setup.c:75: error: field name not in record or un=
ion initializer=0A> arch/ppc/syslib/m8xx_setup.c:75: error: (near initializ=
ation for 'mpc8xxads_partitions')=0A> arch/ppc/syslib/m8xx_setup.c:76: erro=
r: field name not in record or union initializer=0A> arch/ppc/syslib/m8xx_s=
etup.c:76: error: (near initialization for 'mpc8xxads_partitions')=0A> arch=
/ppc/syslib/m8xx_setup.c: In function 'm8xx_show_percpuinfo':=0A> arch/ppc/=
syslib/m8xx_setup.c:312: warning: format '%u' expects type 'unsigned int', =
but argument 3 has type 'long unsigned int'=0A> arch/ppc/syslib/m8xx_setup.=
c:312: warning: format '%u' expects type 'unsigned int', but argument 4 has=
 type 'long unsigned int'=0A> arch/ppc/syslib/m8xx_setup.c: In function 'pl=
atform_init':=0A> arch/ppc/syslib/m8xx_setup.c:451: warning: assignment fro=
m incompatible pointer type=0A> make[1]: *** [arch/ppc/syslib/m8xx_setup.o]=
 Erreur 1=0A> make: *** [arch/ppc/syslib] Erreur 2=0A> =0A> [root@xxxx linu=
x-2.6.26]# powerpc-linux-gcc --version=0A> powerpc-linux-gcc (GCC) 4.0.0 (D=
ENX ELDK 4.1 4.0.0)=0A> Copyright (C) 2005 Free Software Foundation, Inc.=
=0A> This is free software; see the source for copying conditions.=C2=A0 Th=
ere is NO=0A> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTI=
CULAR PURPOSE=0A> It seems that this is a problem with the version 4 of the=
 gcc, and I would like to know if I need to change for an old version of gc=
c ? like 3.0. Or may be a patch exists to bring down this problem ?=0A> Tha=
nks in advance.=0A> Regards,=0A> Fabien.=0A> =0A> =0A>=C2=A0 =C2=A0 =C2=A0 =
___________________________________________________________________________=
__ =0A> Envoyez avec Yahoo! Mail. Une boite mail plus intelligente http://m=
ail.yahoo.fr=0A> =0A> =0A> ------------------------------------------------=
------------------------=0A> =0A> _________________________________________=
______=0A> Linuxppc-embedded mailing list=0A> Linuxppc-embedded@ozlabs.org=
=0A> https://ozlabs.org/mailman/listinfo/linuxppc-embedded=0A=0AHave you mo=
dified that file?=0A=0A-- =0AMarco Stornelli=0AEmbedded Software Engineer=
=0ACoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni=0Ahttp://www.cori=
tel.it=0A=0Amarco.stornelli@coritel.it=0A+39 06 72582838=0A=0A=0A=0A      _=
___________________________________________________________________________=
_ =0AEnvoyez avec Yahoo! Mail. Une boite mail plus intelligente http://mail=
.yahoo.fr
--0-2042487601-1218103609=:59127
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial, helvetica, sans-serif;font-size:1=
0pt"><DIV>No, I did not modify this file.</DIV>=0A<DIV style=3D"FONT-SIZE: =
10pt; FONT-FAMILY: arial, helvetica, sans-serif"><BR>=0A<DIV style=3D"FONT-=
SIZE: 13px; FONT-FAMILY: arial, helvetica, sans-serif">----- Message d'orig=
ine ----<BR>De : Marco Stornelli &lt;marco.stornelli@coritel.it&gt;<BR>=C3=
=80 : Fabien Oriede &lt;fabien.oriede@yahoo.fr&gt;<BR>Cc : linuxppc-embedde=
d@ozlabs.org<BR>Envoy=C3=A9 le : Jeudi, 7 Ao=C3=BBt 2008, 11h59mn 19s<BR>Ob=
jet&nbsp;: Re: kernel 2.6.26 &amp; gcc 4.0.0<BR><BR>Fabien Oriede ha scritt=
o:<BR>&gt; Hello all,<BR>&gt; I'm trying to put a cramfs image on my custom=
 board, and for this, I have followed this topic : <A href=3D"http://www.de=
nx.de/wiki/view/DULG/RootFileSystemOnACramfsFileSystem" target=3D_blank>htt=
p://www.denx.de/wiki/view/DULG/RootFileSystemOnACramfsFileSystem</A><BR>&gt=
; Now I have my cramfs image, but I have seen that I need to download my cr=
amfs image in a mtdblock and for that, I need to set some MTD options in th=
e kernel. (<A href=3D"http://www.denx.de/wiki/view/DULG/FlashFilesystemsMTD=
"
 target=3D_blank>http://www.denx.de/wiki/view/DULG/FlashFilesystemsMTD</A>)=
<BR>&gt; But when I make the command "make uImage", I have this problem :<B=
R>&gt; [root@xxxx linux-2.6.26]# make uImage<BR>&gt;&nbsp; CHK&nbsp; &nbsp;=
 include/linux/version.h<BR>&gt;&nbsp; CHK&nbsp; &nbsp; include/linux/utsre=
lease.h<BR>&gt;&nbsp; CALL&nbsp; &nbsp; scripts/checksyscalls.sh<BR>&gt;&nb=
sp; CHK&nbsp; &nbsp; include/linux/compile.h<BR>&gt;&nbsp; CALL&nbsp; &nbsp=
; arch/powerpc/kernel/systbl_chk.sh<BR>&gt;&nbsp; CC&nbsp; &nbsp; &nbsp; ar=
ch/ppc/syslib/m8xx_setup.o<BR>&gt; arch/ppc/syslib/m8xx_setup.c:68: error: =
array type has incomplete element type<BR>&gt; arch/ppc/syslib/m8xx_setup.c=
:70: error: field name not in record or union initializer<BR>&gt; arch/ppc/=
syslib/m8xx_setup.c:70: error: (near initialization for 'mpc8xxads_partitio=
ns')<BR>&gt; arch/ppc/syslib/m8xx_setup.c:71: error: field name not in reco=
rd or union initializer<BR>&gt; arch/ppc/syslib/m8xx_setup.c:71:
 error: (near initialization for 'mpc8xxads_partitions')<BR>&gt; arch/ppc/s=
yslib/m8xx_setup.c:72: error: field name not in record or union initializer=
<BR>&gt; arch/ppc/syslib/m8xx_setup.c:72: error: (near initialization for '=
mpc8xxads_partitions')<BR>&gt; arch/ppc/syslib/m8xx_setup.c:73: error: fiel=
d name not in record or union initializer<BR>&gt; arch/ppc/syslib/m8xx_setu=
p.c:73: error: (near initialization for 'mpc8xxads_partitions')<BR>&gt; arc=
h/ppc/syslib/m8xx_setup.c:73: error: 'MTD_WRITEABLE' undeclared here (not i=
n a function)<BR>&gt; arch/ppc/syslib/m8xx_setup.c:75: error: field name no=
t in record or union initializer<BR>&gt; arch/ppc/syslib/m8xx_setup.c:75: e=
rror: (near initialization for 'mpc8xxads_partitions')<BR>&gt; arch/ppc/sys=
lib/m8xx_setup.c:76: error: field name not in record or union initializer<B=
R>&gt; arch/ppc/syslib/m8xx_setup.c:76: error: (near initialization for 'mp=
c8xxads_partitions')<BR>&gt; arch/ppc/syslib/m8xx_setup.c: In
 function 'm8xx_show_percpuinfo':<BR>&gt; arch/ppc/syslib/m8xx_setup.c:312:=
 warning: format '%u' expects type 'unsigned int', but argument 3 has type =
'long unsigned int'<BR>&gt; arch/ppc/syslib/m8xx_setup.c:312: warning: form=
at '%u' expects type 'unsigned int', but argument 4 has type 'long unsigned=
 int'<BR>&gt; arch/ppc/syslib/m8xx_setup.c: In function 'platform_init':<BR=
>&gt; arch/ppc/syslib/m8xx_setup.c:451: warning: assignment from incompatib=
le pointer type<BR>&gt; make[1]: *** [arch/ppc/syslib/m8xx_setup.o] Erreur =
1<BR>&gt; make: *** [arch/ppc/syslib] Erreur 2<BR>&gt; <BR>&gt; [root@xxxx =
linux-2.6.26]# powerpc-linux-gcc --version<BR>&gt; powerpc-linux-gcc (GCC) =
4.0.0 (DENX ELDK 4.1 4.0.0)<BR>&gt; Copyright (C) 2005 Free Software Founda=
tion, Inc.<BR>&gt; This is free software; see the source for copying condit=
ions.&nbsp; There is NO<BR>&gt; warranty; not even for MERCHANTABILITY or F=
ITNESS FOR A PARTICULAR PURPOSE<BR>&gt; It seems that this is a
 problem with the version 4 of the gcc, and I would like to know if I need =
to change for an old version of gcc ? like 3.0. Or may be a patch exists to=
 bring down this problem ?<BR>&gt; Thanks in advance.<BR>&gt; Regards,<BR>&=
gt; Fabien.<BR>&gt; <BR>&gt; <BR>&gt;&nbsp; &nbsp; &nbsp; _________________=
____________________________________________________________ <BR>&gt; Envoy=
ez avec Yahoo! Mail. Une boite mail plus intelligente <A href=3D"http://mai=
l.yahoo.fr/" target=3D_blank>http://mail.yahoo.fr</A><BR>&gt; <BR>&gt; <BR>=
&gt; ----------------------------------------------------------------------=
--<BR>&gt; <BR>&gt; _______________________________________________<BR>&gt;=
 Linuxppc-embedded mailing list<BR>&gt; <A href=3D"mailto:Linuxppc-embedded=
@ozlabs.org" ymailto=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embed=
ded@ozlabs.org</A><BR>&gt; <A href=3D"https://ozlabs.org/mailman/listinfo/l=
inuxppc-embedded"
 target=3D_blank>https://ozlabs.org/mailman/listinfo/linuxppc-embedded</A><=
BR><BR>Have you modified that file?<BR><BR>-- <BR>Marco Stornelli<BR>Embedd=
ed Software Engineer<BR>CoRiTeL - Consorzio di Ricerca sulle Telecomunicazi=
oni<BR><A href=3D"http://www.coritel.it/" target=3D_blank>http://www.corite=
l.it</A><BR><BR><A href=3D"mailto:marco.stornelli@coritel.it" ymailto=3D"ma=
ilto:marco.stornelli@coritel.it">marco.stornelli@coritel.it</A><BR>+39 06 7=
2582838<BR></DIV></DIV></div><br>=0A=0A=0A      <hr size=3D"1"> =0AEnvoy=C3=
=A9 avec <a href=3D"http://us.rd.yahoo.com/mailuk/taglines/isp/control/*htt=
p://us.rd.yahoo.com/evt=3D52423/*http://fr.docs.yahoo.com/mail/overview/ind=
ex.html">Yahoo! Mail</a>.<br>Une boite mail plus intelligente. </a></body><=
/html>
--0-2042487601-1218103609=:59127--
