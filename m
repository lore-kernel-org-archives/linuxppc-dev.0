Return-Path: <iluri@fagorautomation.es>
Received: from smtp2.sarenet.es (orhi.sarenet.es [192.148.167.5])
	by ozlabs.org (Postfix) with ESMTP id A38F5679E0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 19:10:36 +1000 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by smtp2.sarenet.es (Postfix) with ESMTP id D068C17740
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 10:53:19 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C675A1.82C4851B"
Subject: Linux doesn't boot if USB is enabled
Date: Fri, 12 May 2006 10:53:15 +0200
Message-ID: <918EB199DDDFFA42BEA2EB3A1C6021F3CE19E2@correo.fagorautomation.net>
From: "IGOR LURI" <iluri@fagorautomation.es>
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

------_=_NextPart_001_01C675A1.82C4851B
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

We have a mpc5200 Icecube board with u-boot 1.1.3 and linux 2.4.25 from =
Denx where linux boots with USB enabled.=20

We also have a mpc5200liteB evaluation board with u-boot 1.1.4 and linux =
2.4.25 from Denx. We have realized that when USB is enabled linux =
doen=B4t boot, it hungs after u-boot uncompresses linux image.

				=3D> usb reset
				(Re)start USB...
				USB:   scanning bus for devices... 1 USB Device(s) found
				       scanning bus for storage devices... 0 Storage Device(s) found
				=3D>run bootcmd
				BOOTP broadcast 1
				DHCP client bound to address 10.0.17.102
				Using FEC ETHERNET device
				TFTP from server 10.0.7.228; our IP address is 10.0.17.102
				Filename 'vmlinux.UBoot'.
				Load address: 0x500000
				Loading: =
#################################################################
				         =
#################################################################
				         =
#################################################################
				         #
				done
				Bytes transferred =3D 1000231 (f4327 hex)
				=3D> bootm 0x500000
				## Booting image at 00500000 ...
				   Image Name:   Linux-2.4.25-rthal5-TRACE
				   Created:      2006-05-11  15:08:31 UTC
				   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
				   Data Size:    1000167 Bytes =3D 976.7 kB
				   Load Address: 00000000
				   Entry Point:  00000000
				   Verifying Checksum ... OK
				   Uncompressing Kernel Image ... OK
				Memory BAT mapping: BAT2=3D256Mb, BAT3=3D0Mb, residual: 0Mb
				Linux version 2.4.25-rthal5-TRACE (igor@ILURI_LINUX) (gcc version =
3.3.6) #301 jue may 11 17:08:00 CEST 2006
				On node 0 totalpages: 65536
				zone(0): 65536 pages.
				zone(1): 0 pages.
				zone(2): 0 pages.
				Kernel command line: root=3D/dev/nfs rw console=3DttyS0 =
console=3DttyS0 init=3D/sbin/init ip=3Don
				Console: colour dummy device 80x25
				Calibrating delay loop... 307.20 BogoMIPS
				Memory: 256012k available (1824k kernel code, 612k data, 96k init, =
0k highmem)
				Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)


If we disable USB with the command=20

				=3D> usb stop
				stopping USB..

linux boots as usual.

I don't found changes in USB part between u-boot 1.1.3 and u-boot 1.1.4. =
I have readen MPC5200 revision B chip errata and there is nothing about =
USB. But I have found  a  manual named  U-Boot Bootloader for MPL Single =
Board Computer that says the following:

	Warning: Please make sure to stop the USB subsystem before booting an =
OS. This can be done by
	adding the command usb stop to the variable bootcmd:

This board uses a ppc405 and also it has the same problem.


Someone knows why linux doesn't boot with USB enabled on a mpc5200liteB =
board? Is this a hardware  problem?Is a revision B chip errata? Or, a =
software problem?


Thanks in advance.


Igor Luri
R&D Software Department
Fagor Automation S. Coop.
P. O. Box 144
E-20500 Mondrag=F3n-Arrasate
Tel. 	++34 943 71 92 00=20
	++34 943 71 92 01 (Ext. 44124)
Fax. 	++34 943 79 92 03
www.fagorautomation.com

------_=_NextPart_001_01C675A1.82C4851B
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7232.36">
<TITLE>Linux doesn't boot if USB is enabled</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi all,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We have a mpc5200 Icecube board with =
u-boot 1.1.3 and linux 2.4.25 from Denx where linux boots with USB =
enabled. </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We also have a mpc5200liteB evaluation =
board with u-boot 1.1.4 and linux 2.4.25 from Denx. We have realized =
that when USB is enabled linux doen=B4t boot, it hungs after u-boot =
u</FONT><FONT SIZE=3D2 FACE=3D"Courier New">ncompresses linux =
image.</FONT></P>
<UL><UL><UL><UL>
<P><FONT SIZE=3D2 FACE=3D"Courier New">=3D&gt; usb reset</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">(Re)start USB...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">USB:&nbsp;&nbsp; scanning bus =
for devices... 1 USB Device(s) found</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scanning bus for storage =
devices... 0 Storage Device(s) found</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">=3D&gt;run bootcmd</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">BOOTP broadcast 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">DHCP client bound to address =
10.0.17.102</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Using FEC ETHERNET device</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">TFTP from server 10.0.7.228; our =
IP address is 10.0.17.102</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Filename 'vmlinux.UBoot'.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Load address: 0x500000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Loading: =
#################################################################</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">done</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Bytes transferred =3D 1000231 =
(f4327 hex)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">=3D&gt; bootm 0x500000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">## Booting image at 00500000 =
...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; Image =
Name:&nbsp;&nbsp; Linux-2.4.25-rthal5-TRACE</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; =
Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-05-11&nbsp; 15:08:31 =
UTC</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; Image =
Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; Data =
Size:&nbsp;&nbsp;&nbsp; 1000167 Bytes =3D 976.7 kB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; Load Address: =
00000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; Entry Point:&nbsp; =
00000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; Verifying Checksum =
... OK</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; Uncompressing =
Kernel Image ... OK</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Memory BAT mapping: =
BAT2=3D256Mb, BAT3=3D0Mb, residual: 0Mb</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Linux version =
2.4.25-rthal5-TRACE (igor@ILURI_LINUX) (gcc version 3.3.6) #301 jue may =
11 17:08:00 CEST 2006</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">On node 0 totalpages: =
65536</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">zone(0): 65536 pages.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">zone(1): 0 pages.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">zone(2): 0 pages.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Kernel command line: =
root=3D/dev/nfs rw console=3DttyS0 console=3DttyS0 init=3D/sbin/init =
ip=3Don</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Console: colour dummy device =
80x25</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Calibrating delay loop... 307.20 =
BogoMIPS</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Memory: 256012k available (1824k =
kernel code, 612k data, 96k init, 0k highmem)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Dentry cache hash table entries: =
32768 (order: 6, 262144 bytes)</FONT>
</P>
<BR>
</UL></UL></UL></UL>
<P><FONT SIZE=3D2 FACE=3D"Arial">If we disable USB with the command =
</FONT>
</P>
<UL><UL><UL><UL>
<P><FONT SIZE=3D2 FACE=3D"Courier New">=3D&gt; usb stop</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">stopping USB..</FONT>
</P>
</UL></UL></UL></UL>
<P><FONT SIZE=3D2 FACE=3D"Arial">linux boots as usual.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I don't found changes in USB part =
between u-boot 1.1.3 and u-boot 1.1.4. I have readen MPC5200 revision B =
chip errata and there is nothing about USB. But I have found&nbsp; =
a&nbsp; manual named&nbsp;<B></B></FONT><B> <FONT SIZE=3D2 =
FACE=3D"Arial">U-Boot Bootloader for MPL Single Board =
Computer</FONT></B> <FONT SIZE=3D2 FACE=3D"Arial">that says the =
following:</FONT></P>
<UL>
<P><B><FONT SIZE=3D2 FACE=3D"Arial,Bold">Warning: Please make sure to =
stop the USB subsystem before booting an OS. This can be done =
by</FONT></B>

<BR><B><FONT SIZE=3D2 FACE=3D"Arial,Bold">adding the command</FONT> =
<FONT SIZE=3D2 FACE=3D"Courier-Bold">usb stop</FONT> <FONT SIZE=3D2 =
FACE=3D"Arial,Bold">to the variable bootcmd:</FONT></B>
</P>
</UL>
<P><FONT SIZE=3D2 FACE=3D"Arial">This board uses a ppc405 and also it =
has the same problem.</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Someone knows why linux doesn't boot =
with USB enabled on a mpc5200liteB board? Is this a hardware&nbsp; =
problem?Is a revision B chip errata? Or, a software problem?</FONT></P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks in advance.</FONT>
</P>
<BR>

<P><B><FONT SIZE=3D2 FACE=3D"Arial">Igor Luri</FONT></B>

<BR><FONT SIZE=3D2 FACE=3D"Arial">R&amp;D Software =
Department</FONT><B></B>

<BR><B><FONT FACE=3D"Arial">Fagor Automation S. Coop.</FONT></B>

<BR><FONT SIZE=3D2 FACE=3D"Arial">P. O. Box 144</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">E-20500 Mondrag=F3n-Arrasate</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Tel. &nbsp;&nbsp; ++34 943 71 92 00 =
</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">++34 943 71 92 01 (Ext. 44124)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Fax. &nbsp;&nbsp; ++34 943 79 92 =
03</FONT>

<BR><U><B><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">www.fagorautomation.com</FONT></B></U><B></B>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C675A1.82C4851B--
