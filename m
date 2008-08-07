Return-Path: <fabien.oriede@yahoo.fr>
Received: from web27403.mail.ukl.yahoo.com (web27403.mail.ukl.yahoo.com
	[217.146.177.179]) by ozlabs.org (Postfix) with SMTP id 6F824DDF02
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Aug 2008 19:53:20 +1000 (EST)
Date: Thu, 7 Aug 2008 09:53:17 +0000 (GMT)
From: Fabien Oriede <fabien.oriede@yahoo.fr>
Subject: kernel 2.6.26 & gcc 4.0.0
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-777681139-1218102797=:18655"
Message-ID: <75390.18655.qm@web27403.mail.ukl.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-777681139-1218102797=:18655
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello all,=0AI'm trying to put a cramfs image on my custom board, and for t=
his, I have followed this topic : http://www.denx.de/wiki/view/DULG/RootFil=
eSystemOnACramfsFileSystem=0ANow I have my cramfs image, but I have seen th=
at I need to download my cramfs image in a mtdblock and for that, I need to=
 set some MTD options in the kernel. (http://www.denx.de/wiki/view/DULG/Fla=
shFilesystemsMTD)=0ABut when I make the command "make uImage", I have this =
problem :=0A[root@xxxx linux-2.6.26]# make uImage=0A=C2=A0 CHK=C2=A0=C2=A0=
=C2=A0=C2=A0 include/linux/version.h=0A=C2=A0 CHK=C2=A0=C2=A0=C2=A0=C2=A0 i=
nclude/linux/utsrelease.h=0A=C2=A0 CALL=C2=A0=C2=A0=C2=A0 scripts/checksysc=
alls.sh=0A=C2=A0 CHK=C2=A0=C2=A0=C2=A0=C2=A0 include/linux/compile.h=0A=C2=
=A0 CALL=C2=A0=C2=A0=C2=A0 arch/powerpc/kernel/systbl_chk.sh=0A=C2=A0 CC=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch/ppc/syslib/m8xx_setup.o=0Aarch/ppc/syslib/=
m8xx_setup.c:68: error: array type has incomplete element type=0Aarch/ppc/s=
yslib/m8xx_setup.c:70: error: field name not in record or union initializer=
=0Aarch/ppc/syslib/m8xx_setup.c:70: error: (near initialization for 'mpc8xx=
ads_partitions')=0Aarch/ppc/syslib/m8xx_setup.c:71: error: field name not i=
n record or union initializer=0Aarch/ppc/syslib/m8xx_setup.c:71: error: (ne=
ar initialization for 'mpc8xxads_partitions')=0Aarch/ppc/syslib/m8xx_setup.=
c:72: error: field name not in record or union initializer=0Aarch/ppc/sysli=
b/m8xx_setup.c:72: error: (near initialization for 'mpc8xxads_partitions')=
=0Aarch/ppc/syslib/m8xx_setup.c:73: error: field name not in record or unio=
n initializer=0Aarch/ppc/syslib/m8xx_setup.c:73: error: (near initializatio=
n for 'mpc8xxads_partitions')=0Aarch/ppc/syslib/m8xx_setup.c:73: error: 'MT=
D_WRITEABLE' undeclared here (not in a function)=0Aarch/ppc/syslib/m8xx_set=
up.c:75: error: field name not in record or union initializer=0Aarch/ppc/sy=
slib/m8xx_setup.c:75: error: (near initialization for 'mpc8xxads_partitions=
')=0Aarch/ppc/syslib/m8xx_setup.c:76: error: field name not in record or un=
ion initializer=0Aarch/ppc/syslib/m8xx_setup.c:76: error: (near initializat=
ion for 'mpc8xxads_partitions')=0Aarch/ppc/syslib/m8xx_setup.c: In function=
 'm8xx_show_percpuinfo':=0Aarch/ppc/syslib/m8xx_setup.c:312: warning: forma=
t '%u' expects type 'unsigned int', but argument 3 has type 'long unsigned =
int'=0Aarch/ppc/syslib/m8xx_setup.c:312: warning: format '%u' expects type =
'unsigned int', but argument 4 has type 'long unsigned int'=0Aarch/ppc/sysl=
ib/m8xx_setup.c: In function 'platform_init':=0Aarch/ppc/syslib/m8xx_setup.=
c:451: warning: assignment from incompatible pointer type=0Amake[1]: *** [a=
rch/ppc/syslib/m8xx_setup.o] Erreur 1=0Amake: *** [arch/ppc/syslib] Erreur =
2=0A=0A[root@xxxx linux-2.6.26]# powerpc-linux-gcc --version=0Apowerpc-linu=
x-gcc (GCC) 4.0.0 (DENX ELDK 4.1 4.0.0)=0ACopyright (C) 2005 Free Software =
Foundation, Inc.=0AThis is free software; see the source for copying condit=
ions.=C2=A0 There is NO=0Awarranty; not even for MERCHANTABILITY or FITNESS=
 FOR A PARTICULAR PURPOSE=0AIt seems that this is a problem with the versio=
n 4 of the gcc, and I would like to know if I need to change for an old ver=
sion of gcc ? like 3.0. Or may be a patch exists to bring down this problem=
 ?=0AThanks in advance.=0ARegards,=0AFabien.=0A=0A=0A      ________________=
_____________________________________________________________ =0AEnvoyez av=
ec Yahoo! Mail. Une boite mail plus intelligente http://mail.yahoo.fr
--0-777681139-1218102797=:18655
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial, helvetica, sans-serif;font-size:1=
0pt"><DIV>Hello all,</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>I'm trying to put a c=
ramfs image on my custom board, and for this, I have followed this topic : =
<A href=3D"http://www.denx.de/wiki/view/DULG/RootFileSystemOnACramfsFileSys=
tem">http://www.denx.de/wiki/view/DULG/RootFileSystemOnACramfsFileSystem</A=
></DIV>=0A<DIV>Now I have my cramfs image, but I have seen that I need to d=
ownload my cramfs image in a mtdblock and for that, I need to set some MTD =
options in the kernel. (<A href=3D"http://www.denx.de/wiki/view/DULG/FlashF=
ilesystemsMTD">http://www.denx.de/wiki/view/DULG/FlashFilesystemsMTD</A>)</=
DIV>=0A<DIV>But when I make the command "make uImage", I have this problem =
:</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>[root@xxxx linux-2.6.26]# make uImage<BR=
>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<BR>&nbsp; CHK&n=
bsp;&nbsp;&nbsp;&nbsp; include/linux/utsrelease.h<BR>&nbsp; CALL&nbsp;&nbsp=
;&nbsp; scripts/checksyscalls.sh<BR>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; incl=
ude/linux/compile.h<BR>&nbsp; CALL&nbsp;&nbsp;&nbsp; arch/powerpc/kernel/sy=
stbl_chk.sh<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/ppc/syslib/m8xx=
_setup.o<BR>arch/ppc/syslib/m8xx_setup.c:68: error: array type has incomple=
te element type<BR>arch/ppc/syslib/m8xx_setup.c:70: error: field name not i=
n record or union initializer<BR>arch/ppc/syslib/m8xx_setup.c:70: error: (n=
ear initialization for 'mpc8xxads_partitions')<BR>arch/ppc/syslib/m8xx_setu=
p.c:71: error: field name not in record or union initializer<BR>arch/ppc/sy=
slib/m8xx_setup.c:71: error: (near initialization for 'mpc8xxads_partitions=
')<BR>arch/ppc/syslib/m8xx_setup.c:72: error: field name not in record or u=
nion
 initializer<BR>arch/ppc/syslib/m8xx_setup.c:72: error: (near initializatio=
n for 'mpc8xxads_partitions')<BR>arch/ppc/syslib/m8xx_setup.c:73: error: fi=
eld name not in record or union initializer<BR>arch/ppc/syslib/m8xx_setup.c=
:73: error: (near initialization for 'mpc8xxads_partitions')<BR>arch/ppc/sy=
slib/m8xx_setup.c:73: error: 'MTD_WRITEABLE' undeclared here (not in a func=
tion)<BR>arch/ppc/syslib/m8xx_setup.c:75: error: field name not in record o=
r union initializer<BR>arch/ppc/syslib/m8xx_setup.c:75: error: (near initia=
lization for 'mpc8xxads_partitions')<BR>arch/ppc/syslib/m8xx_setup.c:76: er=
ror: field name not in record or union initializer<BR>arch/ppc/syslib/m8xx_=
setup.c:76: error: (near initialization for 'mpc8xxads_partitions')<BR>arch=
/ppc/syslib/m8xx_setup.c: In function 'm8xx_show_percpuinfo':<BR>arch/ppc/s=
yslib/m8xx_setup.c:312: warning: format '%u' expects type 'unsigned int', b=
ut argument 3 has type 'long unsigned
 int'<BR>arch/ppc/syslib/m8xx_setup.c:312: warning: format '%u' expects typ=
e 'unsigned int', but argument 4 has type 'long unsigned int'<BR>arch/ppc/s=
yslib/m8xx_setup.c: In function 'platform_init':<BR>arch/ppc/syslib/m8xx_se=
tup.c:451: warning: assignment from incompatible pointer type<BR>make[1]: *=
** [arch/ppc/syslib/m8xx_setup.o] Erreur 1<BR>make: *** [arch/ppc/syslib] E=
rreur 2</DIV>=0A<DIV><BR>[root@xxxx linux-2.6.26]# powerpc-linux-gcc --vers=
ion<BR>powerpc-linux-gcc (GCC) 4.0.0 (DENX ELDK 4.1 4.0.0)<BR>Copyright (C)=
 2005 Free Software Foundation, Inc.<BR>This is free software; see the sour=
ce for copying conditions.&nbsp; There is NO<BR>warranty; not even for MERC=
HANTABILITY or FITNESS FOR A PARTICULAR PURPOSE</DIV>=0A<DIV>&nbsp;</DIV>=
=0A<DIV>It seems that this is a problem with the version 4 of the gcc, and =
I would like to know if I need to change for an old version of gcc ? like 3=
.0. Or may be a patch exists to bring down this problem ?</DIV>=0A<DIV>&nbs=
p;</DIV>=0A<DIV>=0A<DIV>Thanks in advance.</DIV>=0A<DIV>Regards,</DIV>=0A<D=
IV>Fabien.</DIV></DIV></div><br>=0A=0A=0A      <hr size=3D"1"> =0AEnvoy=C3=
=A9 avec <a href=3D"http://us.rd.yahoo.com/mailuk/taglines/isp/control/*htt=
p://us.rd.yahoo.com/evt=3D52423/*http://fr.docs.yahoo.com/mail/overview/ind=
ex.html">Yahoo! Mail</a>.<br>Une boite mail plus intelligente. </a></body><=
/html>
--0-777681139-1218102797=:18655--
