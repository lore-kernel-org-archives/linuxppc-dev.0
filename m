Return-Path: <sim.diak@yahoo.com.cn>
Received: from web92002.mail.cnb.yahoo.com (web92002.mail.cnb.yahoo.com
	[203.209.230.49]) by ozlabs.org (Postfix) with SMTP id CA1F0DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Jan 2008 14:59:47 +1100 (EST)
Date: Sat, 5 Jan 2008 11:53:05 +0800 (CST)
From: diak sim <sim.diak@yahoo.com.cn>
Subject: porting linux 2.6 to ml410, no output after "Now booting the kernel",
	and some other questions
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2104541532-1199505185=:60442"
Message-ID: <101795.60442.qm@web92002.mail.cnb.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2104541532-1199505185=:60442
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

my kernel is linux-2.6-vertex 2.6.23-rc2.=0Ai make sure that the kernel is =
running, but nothing output to the serial terminal after "Now booting the k=
ernel".=0Abefore load_kernel() return, i can use puts() to do some display.=
=0A=0A=0Ai've selected 16550 serial port and add console=3DttyS0 to the cmd=
line.=0Aanother question,=0Aafter load_kernel() function, where is the next=
 step? is it head.S?=0Aif i am in main.c using start_kernel() function, how=
 can i output something to the serial?=0Areferencing many info, so mass, i =
don't know how to debug this. the XMD provide a gdbserver to connect,=0Abut=
 when i use gdb to "target remote" it, it says packet too long.....=0Athank=
s.=0A=0A=0A=0A=0A      ____________________________________________________=
_______ =0A=E9=9B=85=E8=99=8E=E9=82=AE=E7=AE=B1=E4=BC=A0=E9=80=92=E6=96=B0=
=E5=B9=B4=E7=A5=9D=E7=A6=8F=EF=BC=8C=E4=B8=AA=E6=80=A7=E8=B4=BA=E5=8D=A1=E9=
=80=81=E4=BA=B2=E6=9C=8B=EF=BC=81 =0Ahttp://cn.mail.yahoo.com/gc/index.html=
?entry=3D5&souce=3Dmail_mailletter_tagline
--0-2104541532-1199505185=:60442
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div>my kernel is linux-2.6-vertex 2.6.23-rc2.<br>i make su=
re that the kernel is running, but nothing output to the serial terminal af=
ter "Now booting the kernel".<br>before load_kernel() return, i can use put=
s() to do some display.<br>=0A=0Ai've selected 16550 serial port and add co=
nsole=3DttyS0 to the cmdline.<br>another question,<br>after load_kernel() f=
unction, where is the next step? is it head.S?<br>if i am in main.c using s=
tart_kernel() function, how can i output something to the serial?<br>refere=
ncing many info, so mass, i don't know how to debug this. the XMD provide a=
 gdbserver to connect,<br>but when i use gdb to "target remote" it, it says=
 packet too long.....<br>thanks.<br></div></div><br>=0A=0A=0A      <hr size=
=3D1><a href=3D"http://cn.mail.yahoo.com/gc/index.html?entry=3D5&souce=3Dma=
il_mailletter_tagline">=E9=9B=85=E8=99=8E=E9=82=AE=E7=AE=B1=E4=BC=A0=E9=80=
=92=E6=96=B0=E5=B9=B4=E7=A5=9D=E7=A6=8F=EF=BC=8C=E4=B8=AA=E6=80=A7=E8=B4=BA=
=E5=8D=A1=E9=80=81=E4=BA=B2=E6=9C=8B=EF=BC=81</a> </body></html>
--0-2104541532-1199505185=:60442--
