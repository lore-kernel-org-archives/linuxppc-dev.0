Return-Path: <nhit_bk@yahoo.com>
Message-ID: <20061208151041.91462.qmail@web30013.mail.mud.yahoo.com>
Date: Fri, 8 Dec 2006 07:10:41 -0800 (PST)
From: nam ho <nhit_bk@yahoo.com>
Subject: Recompiling 8xx uart driver as loadable module
To: Linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2015804242-1165590641=:88598"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-2015804242-1165590641=:88598
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
 not set=0A=0A_ And after compiling kernel image successful, I=0A compiled =
modules, these following warning appeared:=0A=0A[root@main linux-2.6.11.7_s=
rc]# make ARCH=3Dppc CROSS_COMPILE=3Dppc_8xx- modules=0A  CHK     include/l=
inux/version.h=0Amake[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.=0A=
  CC [M]  drivers/serial/serial_core.o=0A  CC [M]  drivers/serial/cpm_uart/=
cpm_uart_core.o=0Adrivers/serial/cpm_uart/cpm_uart_core.c:732: warning: `cp=
m_uart_init_smc' defined but not used=0Adrivers/serial/cpm_uart/cpm_uart_co=
re.c:671: warning:=0A `cpm_uart_init_scc' defined but not used=0A  CC [M]  =
drivers/serial/cpm_uart/cpm_uart_cpm1.o=0A  LD [M]  drivers/serial/cpm_uart=
/cpm_uart.o=0A  Building modules, stage 2.=0A  MODPOST=0A*** Warning: "cpm_=
setbrg" [drivers/serial/cpm_uart/cpm_uart.ko] undefined!=0A*** Warning: "m8=
xx_cpm_hostalloc" [drivers/serial/cpm_uart/cpm_uart.ko] undefined!=0A*** Wa=
rning: "cpmp" [drivers/serial/cpm_uart/cpm_uart.ko] undefined!=0A  CC      =
drivers/serial/cpm_uart/cpm_uart.mod.o=0A  LD [M]  drivers/serial/cpm_uart/=
cpm_uart.ko=0A  CC      drivers/serial/serial_core.mod.o=0A  LD [M]  driver=
s/serial/serial_core.ko=0A[root@main linux-2.6.11.7_src]#=0A=0A_ I don't kn=
ow why It can't linking with the symbols cpm_setbrg, m8xx_cpm_hostalloc, cp=
mp. Although these were implemented on commproc.c and has been compiled as =
commproc.o in arch/ppc/8xx_io/ folder of kernel source file.=0A=0AAnyone ca=
n help me to fix it.=0A=0AThanks,=0ANam Ho.=0A=0A=0A=0A=0A=0A=0A=0A =0A____=
___________________________________________________________________________=
_____=0AWant to start your own business?=0ALearn how on Yahoo! Small Busine=
ss.=0Ahttp://smallbusiness.yahoo.com/r-index
--0-2015804242-1165590641=:88598
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:14pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 14pt;"><div style=3D"font-family: times new roman,new york=
,times,serif; font-size: 12pt;">Greeting all,<br><div style=3D"font-family:=
 times new roman,new york,times,serif; font-size: 10pt;"><div><br>I am deve=
loping my application on TQM8xxL with linux kernel 2.6.11.7 and&nbsp; tosat=
ti.patch file. It can run on TQM8xxL. But I want to recompile uart driver a=
s loadable module, there are problem while linking object file belows:<br><=
br>_ I configured kernel to supporting loadable module:<br><br><span style=
=3D"font-style: italic;">#</span><br style=3D"font-style: italic;"><span st=
yle=3D"font-style: italic;"># Loadable module support</span><br style=3D"fo=
nt-style: italic;"><span style=3D"font-style: italic;">#</span><br style=3D=
"font-style: italic;"><span
 style=3D"font-style: italic;">CONFIG_MODULES=3Dy</span><br style=3D"font-s=
tyle: italic;"><span style=3D"font-style: italic;">CONFIG_MODULE_UNLOAD=3Dy=
</span><br style=3D"font-style: italic;"><span style=3D"font-style: italic;=
">CONFIG_MODULE_FORCE_UNLOAD=3Dy</span><br style=3D"font-style: italic;"><s=
pan style=3D"font-style: italic;">CONFIG_OBSOLETE_MODPARM=3Dy</span><br sty=
le=3D"font-style: italic;"><span style=3D"font-style: italic;">CONFIG_MODVE=
RSIONS=3Dy</span><br style=3D"font-style: italic;"><span style=3D"font-styl=
e: italic;"># CONFIG_MODULE_SRCVERSION_ALL is not set</span><br style=3D"fo=
nt-style: italic;"><span style=3D"font-style: italic;">CONFIG_KMOD=3Dy</spa=
n><br><br>_ And configured uart driver as loadable module:<br><br><span sty=
le=3D"font-style: italic;">#</span><br style=3D"font-style: italic;"><span =
style=3D"font-style: italic;"># Character devices</span><br style=3D"font-s=
tyle: italic;"><span style=3D"font-style: italic;">#</span><br style=3D"fon=
t-style: italic;"><span style=3D"font-style: italic;"># CONFIG_VT
 is not set</span><br style=3D"font-style: italic;"><span style=3D"font-sty=
le: italic;"># CONFIG_SERIAL_NONSTANDARD is not set</span><br style=3D"font=
-style: italic;"><br style=3D"font-style: italic;"><span style=3D"font-styl=
e: italic;">#</span><br style=3D"font-style: italic;"><span style=3D"font-s=
tyle: italic;"># Serial drivers</span><br style=3D"font-style: italic;"><sp=
an style=3D"font-style: italic;">#</span><br style=3D"font-style: italic;">=
<span style=3D"font-style: italic;"># CONFIG_SERIAL_8250 is not set</span><=
br style=3D"font-style: italic;"><br style=3D"font-style: italic;"><span st=
yle=3D"font-style: italic;">#</span><br style=3D"font-style: italic;"><span=
 style=3D"font-style: italic;"># Non-8250 serial port support</span><br sty=
le=3D"font-style: italic;"><span style=3D"font-style: italic;">#</span><br =
style=3D"font-style: italic;"><span style=3D"font-style: italic;">CONFIG_SE=
RIAL_CORE=3Dm</span><br style=3D"font-style: italic;"><span style=3D"font-s=
tyle: italic;">CONFIG_SERIAL_CPM=3Dm</span><br
 style=3D"font-style: italic;"><span style=3D"font-style: italic;">CONFIG_U=
NIX98_PTYS=3Dy</span><br style=3D"font-style: italic;"><span style=3D"font-=
style: italic;"># CONFIG_LEGACY_PTYS is not set</span><br><br>_ And after c=
ompiling kernel image successful, I=0A compiled modules, these following wa=
rning appeared:<br><br><span style=3D"font-style: italic;">[root@main linux=
-2.6.11.7_src]# make ARCH=3Dppc CROSS_COMPILE=3Dppc_8xx- modules</span><br =
style=3D"font-style: italic;"><span style=3D"font-style: italic;">&nbsp; CH=
K&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h</span><br style=3D"font-s=
tyle: italic;"><span style=3D"font-style: italic;">make[1]: `arch/ppc/kerne=
l/asm-offsets.s' is up to date.</span><br style=3D"font-style: italic;"><sp=
an style=3D"font-style: italic;">&nbsp; CC [M]&nbsp; drivers/serial/serial_=
core.o</span><br style=3D"font-style: italic;"><span style=3D"font-style: i=
talic;">&nbsp; CC [M]&nbsp; drivers/serial/cpm_uart/cpm_uart_core.o</span><=
br style=3D"font-style: italic;"><span style=3D"font-style: italic;">driver=
s/serial/cpm_uart/cpm_uart_core.c:732: warning: `cpm_uart_init_smc' defined=
 but not used</span><br style=3D"font-style: italic;"><span style=3D"font-s=
tyle: italic;">drivers/serial/cpm_uart/cpm_uart_core.c:671: warning:=0A `cp=
m_uart_init_scc' defined but not used</span><br style=3D"font-style: italic=
;"><span style=3D"font-style: italic;">&nbsp; CC [M]&nbsp; drivers/serial/c=
pm_uart/cpm_uart_cpm1.o</span><br style=3D"font-style: italic;"><span style=
=3D"font-style: italic;">&nbsp; LD [M]&nbsp; drivers/serial/cpm_uart/cpm_ua=
rt.o</span><br style=3D"font-style: italic;"><span style=3D"font-style: ita=
lic;">&nbsp; Building modules, stage 2.</span><br style=3D"font-style: ital=
ic;"><span style=3D"font-style: italic;">&nbsp; MODPOST</span><br style=3D"=
font-style: italic;"><span style=3D"font-style: italic;">*** Warning: "cpm_=
setbrg" [drivers/serial/cpm_uart/cpm_uart.ko] undefined!</span><br style=3D=
"font-style: italic;"><span style=3D"font-style: italic;">*** Warning: "m8x=
x_cpm_hostalloc" [drivers/serial/cpm_uart/cpm_uart.ko] undefined!</span><br=
 style=3D"font-style: italic;"><span style=3D"font-style: italic;">*** Warn=
ing: "cpmp" [drivers/serial/cpm_uart/cpm_uart.ko] undefined!</span><br styl=
e=3D"font-style: italic;"><span
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
v></div></div></div></div><br>=0A<hr size=3D1>Cheap Talk? <a href=3D"http:/=
/us.rd.yahoo.com/mail_us/taglines/postman8/*http://us.rd.yahoo.com/evt=3D39=
663/*http://voice.yahoo.com">Check out</a> Yahoo! Messenger's low PC-to-Pho=
ne call rates.</body></html>
--0-2015804242-1165590641=:88598--
