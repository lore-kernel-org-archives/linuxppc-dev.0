Return-Path: <Albert.David@barco.com>
Received: from kuuvir04.barco.com (unknown.barco.com [194.7.240.10])
	by ozlabs.org (Postfix) with SMTP id C6E1467A6B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Feb 2005 19:46:18 +1100 (EST)
Message-ID: <EF7A806FA57EF5448A0885E06E1DB5CC07DEAE@noifps03.barco.com>
From: "David, Albert" <Albert.David@barco.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Sat, 12 Feb 2005 09:19:19 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C510DB.8C6E3B26"
Subject: Memory Size Requirement to Run Linux on Embedded Environment
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C510DB.8C6E3B26
Content-Type: text/plain

Hi everyone!
I am new to linux and my current project is to port linux on our custom
hardware based on PPC405EP(AMCC).
Currently we are in a hardware design phase but I am finding it hard to
decide the Flash and SDRAM Memory size.
We are planning to us 2.6 Kernel, with minimum hardware interfaces.

Should we use Kernel 2.4 or 2.6?

Main components of my target device are as follows..

1)AMCC PPC405EP processor operating at 66.66Mhz External Oscillator(Hope we
can go for higher operating frequencies by configuring internal registers of
PPC).
2)Virtex-2 Pro FPGA - memory mapped to PPC405.
3)Ethernet Connectivity.
4)IrDA.
5)Two RS232 Serial Ports.
6) IIC Bus.


I assume the binary size of my application that will run on linux would be
around 2 to 3 MB. By considering these facts of my hardware, what would be
the size of kernel? And how many drivers I may require? What would be the
size of my root file system? 

Is it necessary to have a NAND Flash to handle the power failures? Or any
CFI compliant NOR Flash would do!

There will be parameters of about 65KB are to be used and these parameters
can be changed in the field. This parameter block will have 2 copies to
avoid data corruption due to power fail. Hence to avoid the use of NAND
Flash I will be using 2 Parameter files to read and write(into flash) in a
linux environment during normal operation. Am I right??

In this mailing list I have read the typical size of U-BOOT will be around
256KB as suggested by Wolfgang Denk.

A rough approximation of Flash and SDRAM size would help me a lot to proceed
with my hardware design. 

Pardon me If I am asking too basic questions, I know I have to do lot of
reading before I proceed. 
Your inputs are valuable to me!

Thanks in advance for your support,
BR,
Albert David.

- - - - - - - DISCLAIMER - - - - - - - - 
Unless indicated otherwise, the information contained in this message is
privileged and confidential, and is intended only for the use of the
addressee(s) named above and others who have been specifically authorized to
receive it. If you are not the intended recipient, you are hereby notified
that any dissemination, distribution or copying of this message and/or
attachments is strictly prohibited. The company accepts no liability for any
damage caused by any virus transmitted by this email. Furthermore, the
company does not warrant a proper and complete transmission of this
information, nor does it accept liability for any delays. If you have
received this message in error, please contact the sender and delete the
message. Thank you.

------_=_NextPart_001_01C510DB.8C6E3B26
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2657.88">
<TITLE>Memory Size Requirement to Run Linux on Embedded =
Environment</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2 FACE=3D"Verdana">Hi everyone!</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Verdana">I am new to linux and my current =
project is to port linux on our custom hardware based on =
PPC405EP(AMCC).</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Verdana">Currently we are in a hardware =
design phase but I am finding it hard to decide the Flash and SDRAM =
Memory size.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Verdana">We are planning to us 2.6 Kernel, =
with minimum hardware interfaces.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">Should we use Kernel 2.4 or =
2.6?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">Main components of my target device =
are as follows..</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">1)AMCC PPC405EP processor operating =
at 66.66Mhz External Oscillator(Hope we can go for higher operating =
frequencies by configuring internal registers of PPC).</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">2)Virtex-2 Pro FPGA - memory mapped =
to PPC405.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Verdana">3)Ethernet Connectivity.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Verdana">4)IrDA.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Verdana">5)Two RS232 Serial Ports.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Verdana">6) IIC Bus.</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Verdana">I assume the binary size of my =
application that will run on linux would be around 2 to 3 MB. By =
considering these facts of my hardware, what would be the size of =
kernel? And how many drivers I may require? What would be the size of =
my root file system? </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">Is it necessary to have a NAND Flash =
to handle the power failures? Or any CFI compliant NOR Flash would =
do!</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">There will be parameters of about =
65KB are to be used and these parameters can be changed in the field. =
This parameter block will have 2 copies to avoid data corruption due to =
power fail. Hence to avoid the use of NAND Flash I will be using 2 =
Parameter files to read and write(into flash) in a linux environment =
during normal operation. Am I right??</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">In this mailing list I have read the =
typical size of U-BOOT will be around 256KB as suggested by Wolfgang =
Denk.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">A rough approximation of Flash and =
SDRAM size would help me a lot to proceed with my hardware design. =
</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">Pardon me If I am asking too basic =
questions, I know I have to do lot of reading before I proceed. </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Verdana">Your inputs are valuable to =
me!</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">Thanks in advance for your =
support,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Verdana">BR,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Verdana">Albert David.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">- - - - - - - DISCLAIMER - - - - - - - =
- </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Unless indicated otherwise, the =
information contained in this message is privileged and confidential, =
and is intended only for the use of the addressee(s) named above and =
others who have been specifically authorized to receive it. If you are =
not the intended recipient, you are hereby notified that any =
dissemination, distribution or copying of this message and/or =
attachments is strictly prohibited. The company accepts no liability =
for any damage caused by any virus transmitted by this email. =
Furthermore, the company does not warrant a proper and complete =
transmission of this information, nor does it accept liability for any =
delays. If you have received this message in error, please contact the =
sender and delete the message. Thank you.</FONT></P>

</BODY>
</HTML>
------_=_NextPart_001_01C510DB.8C6E3B26--
