Return-Path: <aiyuanwang@yahoo.com>
Received: from web52903.mail.re2.yahoo.com (web52903.mail.re2.yahoo.com
	[206.190.49.13]) by ozlabs.org (Postfix) with SMTP id 2B4221007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 09:38:28 +1100 (EST)
Message-ID: <401793.31718.qm@web52903.mail.re2.yahoo.com>
Date: Tue, 1 Dec 2009 14:38:27 -0800 (PST)
From: Allan Wang <aiyuanwang@yahoo.com>
Subject: EP440XS board boot problem(Note:similart to Sequoia)
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2055523732-1259707107=:31718"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0-2055523732-1259707107=:31718
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I resend my message since my last message has wrong coding.=0A=0A=0AI am ne=
w to the list. I am still newbie to embedded linux. I have bought an ep440x=
s board which is similar to sequoia board. u-boot is working. I am trying t=
o make it run linux.=C2=A0 I have the following problems and need your help=
. Thank you very much:=0A=0A=0AI am using linux kernel 2.6.30.4. I encounte=
r 2 problems:=0A1. After console_init() is called inside start_kernel(), th=
e console starts printing garbage like:=0ASerial: 8250/16550 driver, 4 port=
s, IRQ sharing enabled=0Aserial8250.0: ttyS0 at MMIO 0x1ef600300 (irq =3D 1=
6) is a 16550A=0A=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=0A=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=0A=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=0A=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=0A=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD.=
=0A2. It pakics when mounting the root file system(NFS):=0A(gdb) bt=0A#0=C2=
=A0 panic (fmt=3D0xc0290e94 "VFS: Unable to mount root fs on %s")=0Aat kern=
el/panic.c:70=0A#1=C2=A0 0xc02d8ce0 in mount_block_root (name=3D0xc0290de4 =
"/dev/root", flags=3D0x8001)=0Aat init/do_mounts.c:272=0A#2=C2=A0 0xc02d908=
4 in prepare_namespace () at init/do_mounts.c:415=0A#3=C2=A0 0xc02d81ec in =
kernel_init (unused=3D<value optimized out>) at init/main.c:885=0A#4=C2=A0 =
0xc000de60 in kernel_thread ()=0AThere is a patch for Sequoia board to dele=
te /chosen part in sequoia.dts, is /chosen required?=0A=0AAllan=0A=0A=0A=0A=
      
--0-2055523732-1259707107=:31718
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV>I resend my message since my last message has wrong co=
ding.</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>I am new to the =
list. I am still newbie to embedded linux. I have bought an ep440xs board w=
hich is similar to sequoia board. u-boot is working. I am trying to make it=
 run linux.&nbsp; I have the following problems and need your help. Thank y=
ou very much:<BR><BR><BR>I am using linux kernel <SPAN class=3Dyshortcuts i=
d=3Dlw_1259707064_0 style=3D"CURSOR: hand; BORDER-BOTTOM: #0066cc 1px dashe=
d">2.6.30</SPAN>.4. I encounter 2 problems:<BR>1. After console_init() is c=
alled inside start_kernel(), the console starts printing garbage like:<BR>S=
erial: 8250/16550 driver, 4 ports, IRQ sharing enabled<BR>serial8250.0: tty=
S0 at MMIO 0x1ef600300 (irq =3D 16) is a
 16550A<BR>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD<BR>=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD<BR>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD<BR>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD<BR>=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD.<BR>2. It pakics when mounting the root file system(NFS):<BR>(gdb) bt<B=
R>#0&nbsp; panic (fmt=3D0xc0290e94 "VFS: Unable to mount root fs on %s")<BR=
>at kernel/panic.c:70<BR>#1&nbsp; 0xc02d8ce0 in mount_block_root (name=3D0x=
c0290de4 "/dev/root", flags=3D0x8001)<BR>at init/do_mounts.c:272<BR>#2&nbsp=
; 0xc02d9084 in prepare_namespace () at init/do_mounts.c:415<BR>#3&nbsp; 0x=
c02d81ec in kernel_init (unused=3D&lt;value optimized out&gt;) at init/main=
.c:885<BR>#4&nbsp; 0xc000de60 in kernel_thread ()<BR>There is a patch for S=
equoia board
 to delete /chosen part in sequoia.dts, is /chosen required?<BR><BR>Allan<B=
R></DIV><!-- cg17.c2.mail.re1.yahoo.com compressed/chunked Wed Nov 25 07:05=
:06 PST 2009 --></div><br>=0A=0A      </body></html>
--0-2055523732-1259707107=:31718--
