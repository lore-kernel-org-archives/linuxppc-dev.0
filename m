Return-Path: <mfend@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id D46566834E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 17:10:32 +1000 (EST)
Message-ID: <8D4C69676E66D511A1CB00508BBBB192052D42EF@ranmx1.cs.myharris.net>
From: "Fend, Matthias" <mfend@harris.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 29 Sep 2005 02:53:26 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5C4C2.7DA567FE"
Subject: mpc8xx and LCD
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

------_=_NextPart_001_01C5C4C2.7DA567FE
Content-Type: text/plain

hello,

We want to use mpc860/855 with a 320x240 graphic lcd module.
Now there are many possibilities to interface such a module, but I guess this is
not the first time
someone will need a LCD display. So I'm trying to find out the most common way
to implement the 
desired functionality. 

At the moment I think we should use a lcd controller from Epson (S1D13700 or
S1D13305) since they are 
working on Linux framebuffer device driver for it. But I'm not sure how to
design the hardware interface ... all
the LCD modules I found provide only a reduced number of port pins so that the
controller only can be used
in indirect-mode, so I'm not sure whether to connect the module directly to the
CPUs bus or use some
GPIO pins for this...

Has anybody else implemented a LCD into a mpc8xx (not 823) board successfully ?
Are there some good resources somewhere in the web about this topic ?

thanks for your recommendations,
 mattthias


------_=_NextPart_001_01C5C4C2.7DA567FE
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2657.73">
<TITLE>mpc8xx and LCD</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2 FACE=3D"Arial">hello,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We want to use mpc860/855 with a =
320x240 graphic lcd module.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Now there are many possibilities to =
interface such a module, but I guess this is not the first time</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">someone will need a LCD display. So =
I'm trying to find out the most common way to implement the </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">desired functionality. </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">At the moment I think we should use a =
lcd controller from Epson (S1D13700 or S1D13305) since they are </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">working on Linux framebuffer device =
driver for it. But I'm not sure how to design the hardware interface =
... all</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">the LCD modules I found provide only =
a reduced number of port pins so that the controller only can be =
used</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">in indirect-mode, so I'm not sure =
whether to connect the module directly to the CPUs bus or use =
some</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">GPIO pins for this...</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Has anybody else implemented a LCD =
into a mpc8xx (not 823) board successfully ?</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Are there some good resources =
somewhere in the web about this topic ?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">thanks for your =
recommendations,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;mattthias</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5C4C2.7DA567FE--
