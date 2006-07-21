Return-Path: <claus.gindhart@kontron.com>
Received: from mail.kontron-modular.com (mail.e2brain.de [62.159.155.200])
	by ozlabs.org (Postfix) with ESMTP id 609F167BA5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 19:35:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6ACA8.FEA81E0A"
Subject: Boot strategies and Boot Image formats in arch/powerpc
Date: Fri, 21 Jul 2006 11:35:25 +0200
Message-ID: <DADA32856852FC458E0F96B664A6F55E011E239F@kom-mailsrv1.kontron-modular.com>
From: "Claus Gindhart" <claus.gindhart@kontron.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Olaf Wepner <olaf.wepner@kontron.com>,
	Sabine Bielski <sabine.bielski@kontron.com>,
	Stefan Nickl <stefan.nickl@kontron.com>
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

------_=_NextPart_001_01C6ACA8.FEA81E0A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

currently i am trying to migrate our existing PowerPC board supports =
from the arch/ppc - directory into the new arch/powerpc. I am directly =
working within a cloned paulus_powerpc git repository on the most recent =
status.

We (Kontron) want to bring our kernel sources into the appropriate for =
an open source submission. We are modifying both our proprietary =
Bootloader, and the Linux Kernel, to make them fit to the new =
conventions, e.g. the flattened device tree.

However, i dont understand the following:

In the old structure, the kernel provided a bunch of sub directories =
(simple,openfirmware,...) to create a wrapper around the Linux kernel =
for brining it into the format, which is appropriate for the boot loader =
used.
This structure was easily adaptable for custom image formats.

Now, these dirs dont exist any more.

What is the strategy here (i could assume one the 3 variants below ?

a) Is it now in the responsibility of the bootloader, to support one of =
the image formats,=20
    which can be generated here currently ?

b) Will these subdirs (e.g. "simple") come here, but just where not =
ported yet ?

c) Or, shall such wrapper around the kernel, and/or bringing the kernel =
into a particular file format
    be performed outside the kernel source, by proprietary tools
    (e.g. like U-boot does it with the mkimage tool) ?

--=20
Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D
Kontron Modular Computers
phone :++49 (0)8341-803-374
mailto:claus.gindhart@kontron-modular.com
http://www.kontron.com

-----BEGIN GEEK CODE BLOCK-----
  Version: 3.1
  GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o?
  K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++
  D-- G e++> h--- !r x+++
------END GEEK CODE BLOCK------







------_=_NextPart_001_01C6ACA8.FEA81E0A
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>Boot strategies and Boot Image formats in arch/powerpc</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi all,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">currently i am trying to migrate our =
existing PowerPC board supports from the arch/ppc - directory into the =
new arch/powerpc. I am directly working within a cloned paulus_powerpc =
git repository on the most recent status.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We (Kontron) want to bring our kernel =
sources into the appropriate for an open source submission. We are =
modifying both our proprietary Bootloader, and the Linux Kernel, to make =
them fit to the new conventions, e.g. the flattened device =
tree.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">However, i dont understand the =
following:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">In the old structure, the kernel =
provided a bunch of sub directories (simple,openfirmware,...) to create =
a wrapper around the Linux kernel for brining it into the format, which =
is appropriate for the boot loader used.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">This structure was easily adaptable for =
custom image formats.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Now, these dirs dont exist any =
more.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">What is the strategy here (i could =
assume one the 3 variants below ?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">a) Is it now in the responsibility of =
the bootloader, to support one of the image formats, </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; which can be =
generated here currently ?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">b) Will these subdirs (e.g. =
&quot;simple&quot;) come here, but just where not ported yet ?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">c) Or, shall such wrapper around the =
kernel, and/or bringing the kernel into a particular file format</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; be performed =
outside the kernel source, by proprietary tools</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; (e.g. like U-boot =
does it with the mkimage tool) ?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">-- </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Mit freundlichen Gruessen / Best =
regards</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Claus Gindhart</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">SW R&amp;D</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Kontron Modular Computers</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">phone :++49 =
(0)8341-803-374</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New"><A =
HREF=3D"mailto:claus.gindhart@kontron-modular.com">mailto:claus.gindhart@=
kontron-modular.com</A></FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New"><A =
HREF=3D"http://www.kontron.com">http://www.kontron.com</A></FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">-----BEGIN GEEK CODE =
BLOCK-----</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; Version: 3.1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; GU d- s++:&gt;++:+ a+ =
C++$ !U !P L++&gt;$ E-- W+(-) N- o?</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; K? w !O !M V !PS PE- Y+ =
PGP+ t 5? X R* tv- b+ DI+++</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; D-- G e++&gt; h--- !r =
x+++</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">------END GEEK CODE =
BLOCK------</FONT>
</P>
<BR>
<BR>
<BR>
<BR>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C6ACA8.FEA81E0A--
