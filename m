Return-Path: <mfwbm@yahoo.co.in>
Received: from web7903.mail.in.yahoo.com (web7903.mail.in.yahoo.com
	[202.86.4.79]) by ozlabs.org (Postfix) with SMTP id 49C99DDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Oct 2008 01:02:28 +1100 (EST)
Date: Fri, 24 Oct 2008 19:25:47 +0530 (IST)
From: mfwbm <mfwbm@yahoo.co.in>
Subject: problem with stacked module in 2.6.24 kernel build
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1691016544-1224856547=:94177"
Message-ID: <754909.94177.qm@web7903.mail.in.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1691016544-1224856547=:94177
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0AI am trying to port some drivers from our previous product=0Aline,=
 based on 2.6.10 kernel to  2.6.24 kernel and is stuck=0Awith  a strange is=
sue: =0AThere are three kernel modules, A.ko, B,ko=0Aand C.ko; both "B" and=
 "C" are using some symbols exported from "A" and=0Athese symbols are defin=
ed as "extern" in "B" and "C". =0A"A" and "B"=0Aare compiled separately, bu=
t "C" needs to be compiled as part of kernel=0Abuild and is configured as "=
m" in kernel config.=0AAfter bulding vmlinux it fails while making the ko w=
ith following error; I tried building the module separately, but no luck:=
=0A=0A[root@localhost linux-2.6.24]# make O=3D../build-test modules=0A  Usi=
ng <path>/linux-2.6.24 as source for kernel=0A  CHK     include/linux/versi=
on.h=0A  CHK     include/linux/utsrelease.h=0A  CALL    <path>/linux-2.6.24=
/scripts/checksyscalls.sh=0A<stdin>:1345:2: warning: #warning syscall sync_=
file_range not implemented=0A<stdin>:1385:2: warning: #warning syscall fall=
ocate not implemented=0A  CC [M]  drivers/mtd/devices/ctlm_sf.o=0A  Buildin=
g modules, stage 2.=0A  MODPOST 1 modules=0AERROR: "<symbols from A>" [<pat=
h>/C.ko] undefined!=0Amake[2]: *** [__modpost] Error 1=0Amake[1]: *** [modu=
les] Error 2=0Amake: *** [sub-make] Error 2=0A=0AIn=0A2.6.10 kernel it prin=
ts only a WARNING and the module is getting built;=0Asame is the case for o=
ther modules which are built separately in both=0Akernels.=0A=0AAny help re=
garding this is higly appreciated.=0A=0AThanks in advance,=0Amfwbm=0A=0A=0A=
      Add more friends to your messenger and enjoy! Go to http://messenger.=
yahoo.com/invite/
--0-1691016544-1224856547=:94177
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:12pt"><div style=3D"font-family: times new roman,new york,times,seri=
f; font-size: 12pt;">Hi,<br><br>I am trying to port some drivers from our p=
revious product=0Aline, based on 2.6.10 kernel to&nbsp; 2.6.24 kernel and i=
s stuck=0Awith&nbsp; a strange issue: <br>There are three kernel modules, A=
.ko, B,ko=0Aand C.ko; both "B" and "C" are using some symbols exported from=
 "A" and=0Athese symbols are defined as "extern" in "B" and "C". <br>"A" an=
d "B"=0Aare compiled separately, but "C" needs to be compiled as part of ke=
rnel=0Abuild and is configured as "m" in kernel config.<br>After bulding vm=
linux it fails while making the ko with following error; I tried building t=
he module separately, but no luck:<br><br><span style=3D"font-style: italic=
;">[root@localhost linux-2.6.24]# make O=3D../build-test modules</span><br =
style=3D"font-style: italic;"><span style=3D"font-style: italic;">&nbsp;=0A=
 Using &lt;path&gt;/linux-2.6.24 as source for kernel</span><br style=3D"fo=
nt-style: italic;"><span style=3D"font-style: italic;">&nbsp; CHK&nbsp;&nbs=
p;&nbsp;&nbsp; include/linux/version.h</span><br style=3D"font-style: itali=
c;"><span style=3D"font-style: italic;">&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; =
include/linux/utsrelease.h</span><br style=3D"font-style: italic;"><span st=
yle=3D"font-style: italic;">&nbsp; CALL&nbsp;&nbsp;&nbsp; &lt;path&gt;/linu=
x-2.6.24/scripts/checksyscalls.sh</span><br style=3D"font-style: italic;"><=
span style=3D"font-style: italic;">&lt;stdin&gt;:1345:2: warning: #warning =
syscall sync_file_range not implemented</span><br style=3D"font-style: ital=
ic;"><span style=3D"font-style: italic;">&lt;stdin&gt;:1385:2: warning: #wa=
rning syscall fallocate not implemented</span><br style=3D"font-style: ital=
ic;"><span style=3D"font-style: italic;">&nbsp; CC [M]&nbsp; drivers/mtd/de=
vices/ctlm_sf.o</span><br style=3D"font-style: italic;"><span style=3D"font=
-style:
 italic;">&nbsp; Building modules, stage 2.</span><br style=3D"font-style: =
italic;"><span style=3D"font-style: italic;">&nbsp; MODPOST 1 modules</span=
><br style=3D"font-style: italic;"><span style=3D"font-style: italic;">ERRO=
R: "&lt;symbols from A&gt;" [&lt;path&gt;/C.ko] undefined!</span><br style=
=3D"font-style: italic;"><span style=3D"font-style: italic;">make[2]: *** [=
__modpost] Error 1</span><br style=3D"font-style: italic;"><span style=3D"f=
ont-style: italic;">make[1]: *** [modules] Error 2</span><br style=3D"font-=
style: italic;"><span style=3D"font-style: italic;">make: *** [sub-make] Er=
ror 2</span><br><br>In=0A2.6.10 kernel it prints only a WARNING and the mod=
ule is getting built;=0Asame is the case for other modules which are built =
separately in both=0Akernels.<br><br>Any help regarding this is higly appre=
ciated.<br><br>Thanks in advance,<br>mfwbm</div></div><br>=0A      <!--6-->=
<hr size=3D1></hr> Add more friends to your messenger and enjoy! <a href=3D=
"http://in.rd.yahoo.com/tagline_messenger_6/*http://messenger.yahoo.com/inv=
ite/"> Invite them now.</a></body></html>
--0-1691016544-1224856547=:94177--
