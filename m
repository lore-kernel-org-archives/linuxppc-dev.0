Return-Path: <fabien.oriede@yahoo.fr>
Received: from web27407.mail.ukl.yahoo.com (web27407.mail.ukl.yahoo.com
	[217.146.177.183]) by ozlabs.org (Postfix) with SMTP id BEBBDDDF17
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jul 2008 18:53:41 +1000 (EST)
Date: Tue, 29 Jul 2008 08:47:00 +0000 (GMT)
From: Fabien Oriede <fabien.oriede@yahoo.fr>
Subject: No output from SCC1 console
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-29168941-1217321220=:17571"
Message-ID: <828666.17571.qm@web27407.mail.ukl.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-29168941-1217321220=:17571
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,=0AI'm working with a custom board (MPC860T, 8MB FLASH, 4MB SDRAM, s=
erial port on SCC1). I have ported U-Boot on my board, SCC1 is used as UART=
 and I can see all messages on my terminal. Now I'm porting the Linux kerne=
l 2.6.24 and when I use the command "bootm ffa00000" (uImage is at 0xFFA000=
00), no message from linux appear on the terminal. I work with the base of =
the TQM860L.=C2=A0When I have compiled my kernel, I have activated the opti=
on to use SCC1 as UART, the console on the UART, and changed the IMMAP_ADDR=
 to get the same address as IMMR in U-Boot. In my U-Boot's environnement va=
riables, I have "bootargs=3Dconsole=3DttyS0,38400". Even if I don't have me=
ssages on the terminal, I have acces to the "log_buf" variable in SDRAM and=
 the contents is :< 5 > Linux version 2.6.24 (root@localhost.localdomain) (=
gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #25 Sun Feb 6 14:03:59 CET 2011 =
=E2=80=93 =0A< 7 > Entering add_active_range(0, 0, 1024) 0 entries of 256 u=
sed =E2=80=93 =0A< 4 > Zone PFN ranges: - =0A< 4 >=C2=A0=C2=A0=C2=A0=C2=A0 =
DMA0 ->1024 =E2=80=93 =0A< 4 >=C2=A0=C2=A0=C2=A0=C2=A0 Normal 1024 ->1024 =
=E2=80=93 =0A< 4 > Movable zone start PFN for each node =E2=80=93 =0A< 4 > =
early_node_map[1] active PFN ranges =E2=80=93 =0A< 4 >=C2=A0=C2=A0=C2=A0=C2=
=A0 0:0 -> 1024 =E2=80=93 =0A< 7 > On node0 total pages : 1024 =E2=80=93 =
=0A< 7 >=C2=A0=C2=A0=C2=A0=C2=A0 DMA zone : 8 pages used for memmap =E2=80=
=93 =0A< 7 > DMA zone : 0 pages reserved =E2=80=93 =0A< 7 > DMA zone : 1016=
 pages, LIFO batch : 0 =E2=80=93 =0A< 7 >=C2=A0=C2=A0=C2=A0=C2=A0 Normal zo=
ne : 0 pages used for memmap =E2=80=93 =0A< 7 > Movable zone : 0 pages used=
 for memmap =E2=80=93 =0A< 4 > Built1 zonelists in Zone order, mobility gro=
uping off. Total pages : 1016 =E2=80=93 =0A< 5 > Kernel command line :=C2=
=A0=C2=A0 - =0A< 4 > PID hash table entries : 16 (order : 4, 64 bytes) =E2=
=80=93 =0A< 4 > Decrementer Frequency =3D 150000000/60 =E2=80=93 =0A< 4 > C=
onsole : colour dummy device 80x25 =E2=80=93 =0A< 6 > console [tty0] enable=
d =E2=80=93 =0A< 6 > Dentry cache hash table entries : 1024 (order : 0, 409=
6 bytes) =E2=80=93 =0A< 6 > Inode-cache hash table entries : 1024 (order : =
0, 4096 bytes) =E2=80=93 =0A< 4 > Memory : 2636k available (1084k kernel co=
de, 260k data, 56k init, 0k highmem) =E2=80=93 =0A< 6 > SLUB : Genslabs=3D1=
1, HWalign=3D16, Order=3D0-1, MinObjects=3D4, CPUs=3D1, Nodes=3D1 =E2=80=93=
 =0A< 7 > Calibrating delay loop...39.55 BogoMIPS(lpj=3D79104) =E2=80=93 =
=0A< 4 > Mount-cache hashtable entries : 512 =E2=80=93 =0A< 6 > io schedule=
r noop registered =E2=80=93 =0A< 6 > io scheduler anticipatory registered =
=E2=80=93 =0A< 6 > io scheduler deadline registered =E2=80=93 =0A< 6 > io s=
cheduler cfq registered (default) =E2=80=93 =0A< 6 > Generic RTC Driver v1.=
07 =E2=80=93 =0A< 6 > Serial : CPM driver $Revision : 0.02 $ - =0A< 6 > cpm=
_uart : WARNING : no UART devices found on platorm bus! =E2=80=93 =0A< 6 > =
cpm_uart : the driver will guess configuration, but this mode is no longer =
supported. =E2=80=93 =0A< 6 > ttyCPM0 at MMIO 0xffe00a00 (irq =3D 46) is a =
CPM UART =E2=80=93 =0A< 3 > i8042.c : No controller found. =E2=80=93 =0A< 6=
 > mice : PS/2 mouse device common for all mice =E2=80=93 =0A< 4 > VFS : Ca=
nnot open rootdevice "<NULL>"or unknown-block(0,0) =E2=80=93 =0A< 4 > Pleas=
e append a correct "root=3D" boot option; here are the available partitions=
 : - =0A< 0 > Kernel panic =E2=80=93 notsyncing : VFS : Unable to mount roo=
t fs on unknown-block(0,0) =E2=80=93 =0A< 0 > Rebooting in 180seconds.. - -=
 - - - - - - - - - - - - - - - - - - - - -=C2=A0 =0AIn this log, it seems t=
hat I have 2 problems, UART and FileSystem. At this moment, I'm not using a=
n initrd image. I will use it in the futur, I hope that the problem with th=
e UART is not due to=C2=A0the non use of the initrd image.=0ASomeone can he=
lp me with my UART problem please ?=0AThanks.=0A=0A=0A      _______________=
______________________________________________________________ =0AEnvoyez a=
vec Yahoo! Mail. Une boite mail plus intelligente http://mail.yahoo.fr
--0-29168941-1217321220=:17571
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV>Hi all,</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>I'm working w=
ith a custom board (MPC860T, 8MB FLASH, 4MB SDRAM, serial port on SCC1). I =
have ported U-Boot on my board, SCC1 is used as UART and I can see all mess=
ages on my terminal. Now I'm porting the Linux kernel 2.6.24 and when I use=
 the command "bootm ffa00000" (uImage is at 0xFFA00000), no message from li=
nux appear on the terminal. I work with the base of the TQM860L.&nbsp;When =
I have compiled my kernel, I have activated the option to use SCC1 as UART,=
 the console on the UART, and changed the IMMAP_ADDR to get the same addres=
s as IMMR in U-Boot. In my U-Boot's environnement variables, I have "bootar=
gs=3Dconsole=3DttyS0,38400". Even if I don't have messages on the terminal,=
 I have acces to the "log_buf" variable in SDRAM and the contents is :</DIV=
>=0A<DIV>&nbsp;</DIV><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 12pt; FONT-FAMI=
LY: 'Times New Roman'; mso-fareast-font-family: 'MS Mincho'; mso-ansi-langu=
age: EN-GB; mso-fareast-language: FR; mso-bidi-language: AR-SA"><FONT size=
=3D2><SPAN style=3D"mso-spacerun: yes">=0A<P class=3DMsoPlainText style=3D"=
MARGIN: 0cm 0cm 0pt"><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'"><=
FONT face=3D"Courier New">&lt; 5 &gt; Linux version 2.6.24 (root@localhost.=
localdomain) (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #25 Sun Feb 6 14:03:=
59 CET 2011 =E2=80=93 <?xml:namespace prefix =3D o ns =3D "urn:schemas-micr=
osoft-com:office:office" /><o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPl=
ainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-farea=
st-font-family: 'MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Courie=
r New">&lt; 7 &gt; Entering add_active_range(0, 0, 1024) 0 entries of 256 u=
sed =E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=
=3D"MARGIN: 0cm 0cm 0pt"><SPAN style=3D"mso-fareast-font-family: 'MS Mincho=
'"><FONT face=3D"Courier New">&lt; 4 &gt; Zone PFN ranges: - <o:p></o:p></F=
ONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SP=
AN lang=3DEN-GB style=3D"mso-fareast-font-family: 'MS Mincho'; mso-ansi-lan=
guage: EN-GB"><FONT face=3D"Courier New">&lt; 4 &gt;<SPAN style=3D"mso-spac=
erun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>DMA0 -&gt;1024 =E2=80=93 <o:p></=
o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0=
pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-family: 'MS Mincho'; mso-a=
nsi-language: EN-GB"><FONT face=3D"Courier New">&lt; 4 &gt;<SPAN style=3D"m=
so-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>Normal 1024 -&gt;1024 =E2=
=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MAR=
GIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-family: 'MS =
Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&lt; 4 &gt; M=
ovable zone start PFN for each node =E2=80=93 <o:p></o:p></FONT></SPAN></P>=
=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=
 style=3D"mso-fareast-font-family: 'MS Mincho'; mso-ansi-language: EN-GB"><=
FONT face=3D"Courier New">&lt; 4 &gt; early_node_map[1] active PFN ranges =
=E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"=
MARGIN: 0cm 0cm 0pt"><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'"><=
FONT face=3D"Courier New">&lt; 4 &gt;<SPAN style=3D"mso-spacerun: yes">&nbs=
p;&nbsp;&nbsp;&nbsp; </SPAN>0:0 -&gt; 1024 =E2=80=93 <o:p></o:p></FONT></SP=
AN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN style=
=3D"mso-fareast-font-family: 'MS Mincho'"><FONT face=3D"Courier New">&lt; 7=
 &gt; On node0 total pages : 1024 =E2=80=93 <o:p></o:p></FONT></SPAN></P>=
=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=
 style=3D"mso-fareast-font-family: 'MS Mincho'; mso-ansi-language: EN-GB"><=
FONT face=3D"Courier New">&lt; 7 &gt;<SPAN style=3D"mso-spacerun: yes">&nbs=
p;&nbsp;&nbsp;&nbsp; </SPAN>DMA zone : 8 pages used for memmap =E2=80=93 <o=
:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm =
0cm 0pt"><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'"><FONT face=3D=
"Courier New">&lt; 7 &gt; DMA zone : 0 pages reserved =E2=80=93 <o:p></o:p>=
</FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt">=
<SPAN style=3D"mso-fareast-font-family: 'MS Mincho'"><FONT face=3D"Courier =
New">&lt; 7 &gt; DMA zone : 1016 pages, LIFO batch : 0 =E2=80=93 <o:p></o:p=
></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"=
><SPAN lang=3DEN-GB style=3D"mso-fareast-font-family: 'MS Mincho'; mso-ansi=
-language: EN-GB"><FONT face=3D"Courier New">&lt; 7 &gt;<SPAN style=3D"mso-=
spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>Normal zone : 0 pages used f=
or memmap =E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText=
 style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font=
-family: 'MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">=
&lt; 7 &gt; Movable zone : 0 pages used for memmap =E2=80=93 <o:p></o:p></F=
ONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SP=
AN lang=3DEN-GB style=3D"mso-fareast-font-family: 'MS Mincho'; mso-ansi-lan=
guage: EN-GB"><FONT face=3D"Courier New">&lt; 4 &gt; Built1 zonelists in Zo=
ne order, mobility grouping off. Total pages : 1016 =E2=80=93 <o:p></o:p></=
FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><S=
PAN lang=3DEN-GB style=3D"mso-fareast-font-family: 'MS Mincho'; mso-ansi-la=
nguage: EN-GB"><FONT face=3D"Courier New">&lt; 5 &gt; Kernel command line :=
<SPAN style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>- <o:p></o:p></FONT><=
/SPAN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN la=
ng=3DEN-GB style=3D"mso-fareast-font-family: 'MS Mincho'; mso-ansi-language=
: EN-GB"><FONT face=3D"Courier New">&lt; 4 &gt; PID hash table entries : 16=
 (order : 4, 64 bytes) =E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=
=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"m=
so-fareast-font-family: 'MS Mincho'; mso-ansi-language: EN-GB"><FONT face=
=3D"Courier New">&lt; 4 &gt; Decrementer Frequency =3D 150000000/60 =E2=80=
=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN=
: 0cm 0cm 0pt"><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'"><FONT f=
ace=3D"Courier New">&lt; 4 &gt; Console : colour dummy device 80x25 =E2=80=
=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN=
: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-family: 'MS Min=
cho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&lt; 6 &gt; cons=
ole [tty0] enabled =E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMso=
PlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-far=
east-font-family: 'MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Cour=
ier New">&lt; 6 &gt; Dentry cache hash table entries : 1024 (order : 0, 409=
6 bytes) =E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText =
style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-=
family: 'MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&=
lt; 6 &gt; Inode-cache hash table entries : 1024 (order : 0, 4096 bytes) =
=E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"=
MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-family: '=
MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&lt; 4 &gt=
; Memory : 2636k available (1084k kernel code, 260k data, 56k init, 0k high=
mem) =E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText styl=
e=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-fami=
ly: 'MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&lt; =
6 &gt; SLUB : Genslabs=3D11, HWalign=3D16, Order=3D0-1, MinObjects=3D4, CPU=
s=3D1, Nodes=3D1 =E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPl=
ainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-farea=
st-font-family: 'MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Courie=
r New">&lt; 7 &gt; Calibrating delay loop...39.55 BogoMIPS(lpj=3D79104) =E2=
=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MAR=
GIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-family: 'MS =
Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&lt; 4 &gt; M=
ount-cache hashtable entries : 512 =E2=80=93 <o:p></o:p></FONT></SPAN></P>=
=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=
 style=3D"mso-fareast-font-family: 'MS Mincho'; mso-ansi-language: EN-GB"><=
FONT face=3D"Courier New">&lt; 6 &gt; io scheduler noop registered =E2=80=
=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN=
: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-family: 'MS Min=
cho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&lt; 6 &gt; io s=
cheduler anticipatory registered =E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A=
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB st=
yle=3D"mso-fareast-font-family: 'MS Mincho'; mso-ansi-language: EN-GB"><FON=
T face=3D"Courier New">&lt; 6 &gt; io scheduler deadline registered =E2=80=
=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN=
: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-family: 'MS Min=
cho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&lt; 6 &gt; io s=
cheduler cfq registered (default) =E2=80=93 <o:p></o:p></FONT></SPAN></P>=
=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=
 style=3D"mso-fareast-font-family: 'MS Mincho'; mso-ansi-language: EN-GB"><=
FONT face=3D"Courier New">&lt; 6 &gt; Generic RTC Driver v1.07 =E2=80=93 <o=
:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm =
0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-family: 'MS Mincho'; =
mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&lt; 6 &gt; Serial : C=
PM driver $Revision : 0.02 $ - <o:p></o:p></FONT></SPAN></P>=0A<P class=3DM=
soPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-f=
areast-font-family: 'MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Co=
urier New">&lt; 6 &gt; cpm_uart : WARNING : no UART devices found on plator=
m bus! =E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText st=
yle=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-fa=
mily: 'MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&lt=
; 6 &gt; cpm_uart : the driver will guess configuration, but this mode is n=
o longer supported. =E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMs=
oPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fa=
reast-font-family: 'MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Cou=
rier New">&lt; 6 &gt; ttyCPM0 at MMIO 0xffe00a00 (irq =3D 46) is a CPM UART=
 =E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D=
"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-family: =
'MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&lt; 3 &g=
t; i8042.c : No controller found. =E2=80=93 <o:p></o:p></FONT></SPAN></P>=
=0A<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=
 style=3D"mso-fareast-font-family: 'MS Mincho'; mso-ansi-language: EN-GB"><=
FONT face=3D"Courier New">&lt; 6 &gt; mice : PS/2 mouse device common for a=
ll mice =E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText s=
tyle=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-f=
amily: 'MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&l=
t; 4 &gt; VFS : Cannot open rootdevice "&lt;NULL&gt;"or unknown-block(0,0) =
=E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=3D"=
MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-family: '=
MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&lt; 4 &gt=
; Please append a correct "root=3D" boot option; here are the available par=
titions : - <o:p></o:p></FONT></SPAN></P>=0A<P class=3DMsoPlainText style=
=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB style=3D"mso-fareast-font-famil=
y: 'MS Mincho'; mso-ansi-language: EN-GB"><FONT face=3D"Courier New">&lt; 0=
 &gt; Kernel panic =E2=80=93 notsyncing : VFS : Unable to mount root fs on =
unknown-block(0,0) =E2=80=93 <o:p></o:p></FONT></SPAN></P>=0A<DIV><SPAN lan=
g=3DEN-GB style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New Roman'; mso-far=
east-font-family: 'MS Mincho'; mso-ansi-language: EN-GB; mso-fareast-langua=
ge: FR; mso-bidi-language: AR-SA">&lt; 0 &gt; Rebooting in 180seconds.. - -=
 - - - - - - - - - - - - - - - - - - - - -<SPAN style=3D"mso-spacerun: yes"=
>&nbsp; </SPAN></SPAN></DIV>=0A<DIV><SPAN lang=3DEN-GB style=3D"FONT-SIZE: =
12pt; FONT-FAMILY: 'Times New Roman'; mso-fareast-font-family: 'MS Mincho';=
 mso-ansi-language: EN-GB; mso-fareast-language: FR; mso-bidi-language: AR-=
SA"><SPAN style=3D"mso-spacerun: yes"></SPAN></SPAN>&nbsp;</DIV>=0A<DIV><SP=
AN lang=3DEN-GB style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New Roman'; m=
so-fareast-font-family: 'MS Mincho'; mso-ansi-language: EN-GB; mso-fareast-=
language: FR; mso-bidi-language: AR-SA"><SPAN style=3D"mso-spacerun: yes">I=
n this log, it seems that I have 2 problems, UART and FileSystem. At this m=
oment, I'm not using an initrd image. I will use it in the futur, I hope th=
at the problem with the UART is not due to&nbsp;the non use of the initrd i=
mage.</SPAN></SPAN></DIV>=0A<DIV><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 12p=
t; FONT-FAMILY: 'Times New Roman'; mso-fareast-font-family: 'MS Mincho'; ms=
o-ansi-language: EN-GB; mso-fareast-language: FR; mso-bidi-language: AR-SA"=
><SPAN style=3D"mso-spacerun: yes">Someone can help me with my UART problem=
 please ?</SPAN></SPAN></DIV>=0A<DIV><SPAN lang=3DEN-GB style=3D"FONT-SIZE:=
 12pt; FONT-FAMILY: 'Times New Roman'; mso-fareast-font-family: 'MS Mincho'=
; mso-ansi-language: EN-GB; mso-fareast-language: FR; mso-bidi-language: AR=
-SA"><SPAN style=3D"mso-spacerun: yes">Thanks.</SPAN></SPAN></SPAN></FONT><=
/SPAN></DIV></div><br>=0A=0A=0A      <hr size=3D"1"> =0AEnvoy=C3=A9 avec <a=
 href=3D"http://us.rd.yahoo.com/mailuk/taglines/isp/control/*http://us.rd.y=
ahoo.com/evt=3D52423/*http://fr.docs.yahoo.com/mail/overview/index.html">Ya=
hoo! Mail</a>.<br>Une boite mail plus intelligente. </a></body></html>
--0-29168941-1217321220=:17571--
