Return-Path: <nhit_bk@yahoo.com>
Received: from web30009.mail.mud.yahoo.com (web30009.mail.mud.yahoo.com
	[209.191.69.26]) by ozlabs.org (Postfix) with SMTP id E1F1767BE4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Nov 2006 01:54:16 +1100 (EST)
Message-ID: <20061123144735.80827.qmail@web30009.mail.mud.yahoo.com>
Date: Thu, 23 Nov 2006 06:47:35 -0800 (PST)
From: nam ho <nhit_bk@yahoo.com>
Subject: Recompiling 8xx uart driver as loadable module
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2031552761-1164293255=:75814"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2031552761-1164293255=:75814
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

Greeting all,=0A=0AI am developing my application on TQM8xxL with linux ker=
nel 2.6.11.7 and  tosatti.patch file. It can run on TQM8xxL. But I want to =
recompile uart driver as loadable module, there are problem while linking o=
bject file belows:=0A=0A_ I configured kernel to supporting loadable module=
:=0A=0A#=0A# Loadable module support=0A#=0ACONFIG_MODULES=3Dy=0ACONFIG_MODU=
LE_UNLOAD=3Dy=0ACONFIG_MODULE_FORCE_UNLOAD=3Dy=0ACONFIG_OBSOLETE_MODPARM=3D=
y=0ACONFIG_MODVERSIONS=3Dy=0A# CONFIG_MODULE_SRCVERSION_ALL is not set=0ACO=
NFIG_KMOD=3Dy=0A=0A_ And configured uart driver as loadable module:=0A=0A#=
=0A# Character devices=0A#=0A# CONFIG_VT is not set=0A# CONFIG_SERIAL_NONST=
ANDARD is not set=0A=0A#=0A# Serial drivers=0A#=0A# CONFIG_SERIAL_8250 is n=
ot set=0A=0A#=0A# Non-8250 serial port support=0A#=0ACONFIG_SERIAL_CORE=3Dm=
=0ACONFIG_SERIAL_CPM=3Dm=0ACONFIG_UNIX98_PTYS=3Dy=0A# CONFIG_LEGACY_PTYS is=
 not set=0A=0A_ And after compiling kernel image successful, I compiled mod=
ules, these following warning appeared:=0A=0A[root@main linux-2.6.11.7_src]=
# make ARCH=3Dppc CROSS_COMPILE=3Dppc_8xx- modules=0A  CHK     include/linu=
x/version.h=0Amake[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.=0A  C=
C [M]  drivers/serial/serial_core.o=0A  CC [M]  drivers/serial/cpm_uart/cpm=
_uart_core.o=0Adrivers/serial/cpm_uart/cpm_uart_core.c:732: warning: `cpm_u=
art_init_smc' defined but not used=0Adrivers/serial/cpm_uart/cpm_uart_core.=
c:671: warning: `cpm_uart_init_scc' defined but not used=0A  CC [M]  driver=
s/serial/cpm_uart/cpm_uart_cpm1.o=0A  LD [M]  drivers/serial/cpm_uart/cpm_u=
art.o=0A  Building modules, stage 2.=0A  MODPOST=0A*** Warning: "cpm_setbrg=
" [drivers/serial/cpm_uart/cpm_uart.ko] undefined!=0A*** Warning: "m8xx_cpm=
_hostalloc" [drivers/serial/cpm_uart/cpm_uart.ko] undefined!=0A*** Warning:=
 "cpmp" [drivers/serial/cpm_uart/cpm_uart.ko] undefined!=0A  CC      driver=
s/serial/cpm_uart/cpm_uart.mod.o=0A  LD [M]  drivers/serial/cpm_uart/cpm_ua=
rt.ko=0A  CC      drivers/serial/serial_core.mod.o=0A  LD [M]  drivers/seri=
al/serial_core.ko=0A[root@main linux-2.6.11.7_src]#=0A=0A_ I don't know why=
 It can't linking with the symbols cpm_setbrg, m8xx_cpm_hostalloc, cpmp. Al=
though these were implemented on commproc.c and has been compiled as commpr=
oc.o in arch/ppc/8xx_io/ folder of kernel source file.=0A=0AAnyone can help=
 me to fix it.=0A=0AThanks,=0ANam Ho.=0A=0A=0A=0A=0A =0A___________________=
_________________________________________________________________=0ADo you =
Yahoo!?=0AEveryone is raving about the all-new Yahoo! Mail beta.=0Ahttp://n=
ew.mail.yahoo.com
--0-2031552761-1164293255=:75814
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:10pt"><div>Greeting all,<br><br>I am developing my application on=
 TQM8xxL with linux kernel 2.6.11.7 and&nbsp; tosatti.patch file. It can ru=
n on TQM8xxL. But I want to recompile uart driver as loadable module, there=
 are problem while linking object file belows:<br><br>_ I configured kernel=
 to supporting loadable module:<br><br><span style=3D"font-style: italic;">=
#</span><br style=3D"font-style: italic;"><span style=3D"font-style: italic=
;"># Loadable module support</span><br style=3D"font-style: italic;"><span =
style=3D"font-style: italic;">#</span><br style=3D"font-style: italic;"><sp=
an style=3D"font-style: italic;">CONFIG_MODULES=3Dy</span><br style=3D"font=
-style: italic;"><span style=3D"font-style: italic;">CONFIG_MODULE_UNLOAD=
=3Dy</span><br style=3D"font-style: italic;"><span style=3D"font-style: ita=
lic;">CONFIG_MODULE_FORCE_UNLOAD=3Dy</span><br
 style=3D"font-style: italic;"><span style=3D"font-style: italic;">CONFIG_O=
BSOLETE_MODPARM=3Dy</span><br style=3D"font-style: italic;"><span style=3D"=
font-style: italic;">CONFIG_MODVERSIONS=3Dy</span><br style=3D"font-style: =
italic;"><span style=3D"font-style: italic;"># CONFIG_MODULE_SRCVERSION_ALL=
 is not set</span><br style=3D"font-style: italic;"><span style=3D"font-sty=
le: italic;">CONFIG_KMOD=3Dy</span><br><br>_ And configured uart driver as =
loadable module:<br><br><span style=3D"font-style: italic;">#</span><br sty=
le=3D"font-style: italic;"><span style=3D"font-style: italic;"># Character =
devices</span><br style=3D"font-style: italic;"><span style=3D"font-style: =
italic;">#</span><br style=3D"font-style: italic;"><span style=3D"font-styl=
e: italic;"># CONFIG_VT is not set</span><br style=3D"font-style: italic;">=
<span style=3D"font-style: italic;"># CONFIG_SERIAL_NONSTANDARD is not set<=
/span><br style=3D"font-style: italic;"><br style=3D"font-style: italic;"><=
span style=3D"font-style: italic;">#</span><br
 style=3D"font-style: italic;"><span style=3D"font-style: italic;"># Serial=
 drivers</span><br style=3D"font-style: italic;"><span style=3D"font-style:=
 italic;">#</span><br style=3D"font-style: italic;"><span style=3D"font-sty=
le: italic;"># CONFIG_SERIAL_8250 is not set</span><br style=3D"font-style:=
 italic;"><br style=3D"font-style: italic;"><span style=3D"font-style: ital=
ic;">#</span><br style=3D"font-style: italic;"><span style=3D"font-style: i=
talic;"># Non-8250 serial port support</span><br style=3D"font-style: itali=
c;"><span style=3D"font-style: italic;">#</span><br style=3D"font-style: it=
alic;"><span style=3D"font-style: italic;">CONFIG_SERIAL_CORE=3Dm</span><br=
 style=3D"font-style: italic;"><span style=3D"font-style: italic;">CONFIG_S=
ERIAL_CPM=3Dm</span><br style=3D"font-style: italic;"><span style=3D"font-s=
tyle: italic;">CONFIG_UNIX98_PTYS=3Dy</span><br style=3D"font-style: italic=
;"><span style=3D"font-style: italic;"># CONFIG_LEGACY_PTYS is not set</spa=
n><br><br>_ And after compiling kernel image successful, I
 compiled modules, these following warning appeared:<br><br><span style=3D"=
font-style: italic;">[root@main linux-2.6.11.7_src]# make ARCH=3Dppc CROSS_=
COMPILE=3Dppc_8xx- modules</span><br style=3D"font-style: italic;"><span st=
yle=3D"font-style: italic;">&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linu=
x/version.h</span><br style=3D"font-style: italic;"><span style=3D"font-sty=
le: italic;">make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.</span>=
<br style=3D"font-style: italic;"><span style=3D"font-style: italic;">&nbsp=
; CC [M]&nbsp; drivers/serial/serial_core.o</span><br style=3D"font-style: =
italic;"><span style=3D"font-style: italic;">&nbsp; CC [M]&nbsp; drivers/se=
rial/cpm_uart/cpm_uart_core.o</span><br style=3D"font-style: italic;"><span=
 style=3D"font-style: italic;">drivers/serial/cpm_uart/cpm_uart_core.c:732:=
 warning: `cpm_uart_init_smc' defined but not used</span><br style=3D"font-=
style: italic;"><span style=3D"font-style: italic;">drivers/serial/cpm_uart=
/cpm_uart_core.c:671: warning:
 `cpm_uart_init_scc' defined but not used</span><br style=3D"font-style: it=
alic;"><span style=3D"font-style: italic;">&nbsp; CC [M]&nbsp; drivers/seri=
al/cpm_uart/cpm_uart_cpm1.o</span><br style=3D"font-style: italic;"><span s=
tyle=3D"font-style: italic;">&nbsp; LD [M]&nbsp; drivers/serial/cpm_uart/cp=
m_uart.o</span><br style=3D"font-style: italic;"><span style=3D"font-style:=
 italic;">&nbsp; Building modules, stage 2.</span><br style=3D"font-style: =
italic;"><span style=3D"font-style: italic;">&nbsp; MODPOST</span><br style=
=3D"font-style: italic;"><span style=3D"font-style: italic;">*** Warning: "=
cpm_setbrg" [drivers/serial/cpm_uart/cpm_uart.ko] undefined!</span><br styl=
e=3D"font-style: italic;"><span style=3D"font-style: italic;">*** Warning: =
"m8xx_cpm_hostalloc" [drivers/serial/cpm_uart/cpm_uart.ko] undefined!</span=
><br style=3D"font-style: italic;"><span style=3D"font-style: italic;">*** =
Warning: "cpmp" [drivers/serial/cpm_uart/cpm_uart.ko] undefined!</span><br =
style=3D"font-style: italic;"><span
 style=3D"font-style: italic;">&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; driv=
ers/serial/cpm_uart/cpm_uart.mod.o</span><br style=3D"font-style: italic;">=
<span style=3D"font-style: italic;">&nbsp; LD [M]&nbsp; drivers/serial/cpm_=
uart/cpm_uart.ko</span><br style=3D"font-style: italic;"><span style=3D"fon=
t-style: italic;">&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/serial/se=
rial_core.mod.o</span><br style=3D"font-style: italic;"><span style=3D"font=
-style: italic;">&nbsp; LD [M]&nbsp; drivers/serial/serial_core.ko</span><b=
r style=3D"font-style: italic;"><span style=3D"font-style: italic;">[root@m=
ain linux-2.6.11.7_src]#</span><br><br>_ I don't know why It can't linking =
with the symbols <span style=3D"font-style: italic;">cpm_setbrg, m8xx_cpm_h=
ostalloc, cpmp</span>. Although these were implemented on commproc.c and ha=
s been compiled as commproc.o in arch/ppc/8xx_io/ folder of kernel source f=
ile.<br><br>Anyone can help me to fix it.<br><br>Thanks,<br>Nam Ho.<br></di=
v></div><br>=0A=0A<hr size=3D1>Check out <a href=3D"http://us.rd.yahoo.com/=
evt=3D43257/*http://advision.webevents.yahoo.com/mailbeta">the all-new Yaho=
o! Mail beta</a> - Fire up a more powerful email and get things done faster=
.</body></html>
--0-2031552761-1164293255=:75814--
