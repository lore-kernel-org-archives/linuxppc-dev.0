Return-Path: <vasbridge@sanblaze.com>
Received: from mail.gazungle.com (mail.gazungle.com [207.210.240.68])
	by ozlabs.org (Postfix) with ESMTP id 6C3C4DDFB4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jun 2008 01:52:23 +1000 (EST)
From: "Vince Asbridge" <vasbridge@sanblaze.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Migrating from 2.6.11 to 2.6.23 breaks pci-e with LSI 1068 SAS chip
Date: Tue, 24 Jun 2008 11:51:29 -0400
Message-ID: <13c601c8d612$2af82500$4b01a8c0@sanblaze.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_13C7_01C8D5F0.A3E68500"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_13C7_01C8D5F0.A3E68500
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

All,

I'm new to this mailing list, but have not had any luck finding information
on this issue.

Please be kind if I break the forum rules on my first post.

We recently tried to upgrade our Freescale CDS 8548 look-alike module (code
name ATCA1000) from the 2.6.11 based BSP to the 2.6.23 based BSP.

The upgrade went fairly smoothly, until we tried using SOME pci-e devices
(some work fine, some don't show up to lspci).

LSI pci-e controllers no longer show up at all!

We see the ixgbe (intel 10G), SiliconImage SATA controller but do not see
LSI devices (Specifically 1068 SAS, FC949-E fibrechannel).

We're guessing it's a resource issue behind the bridge, because the LSI
devices try to allocate 1 - 3M behind the bridge, but we can't find the bug,
or where we would debug such an issue.

The devices seem to "train" correctly, because we have an LED on the pci-e
switch (PLX 8 port pci-e switch), and it's ON indicating pci-e link between
the bridge and the 1068 device).

We're totally at a loss as to why this always worked on the 2.6.11 kernel
but doesn't work on 2.6.23.

Using lspci, the LSI adapters do not show up in the list at all, as though
they are not plugged into the system.

Is there something that needs to be done with respect to PCI-E devices that
is new in the 2.6.23 based BSP that did not need to be done in the 2.6.11
based kit?  For example, are pci resources allocated by a different piece of
code, that may have some issue allocating resources for the LSI adapters?

I currently do not have access to a pci-e analyzer.

Thanks for any help,
Vince Asbridge



------=_NextPart_000_13C7_01C8D5F0.A3E68500
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7036.0">
<TITLE>Migrating from 2.6.11 to 2.6.23 breaks pci-e with LSI 1068 SAS =
chip</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">All,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I'm new to this mailing list, but have =
not had any luck finding information on this issue.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Please be kind if I break the forum =
rules on my first post.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We recently tried to upgrade our =
Freescale CDS 8548 look-alike module (code name ATCA1000) from the =
2.6.11 based BSP to the 2.6.23 based BSP.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The upgrade went fairly smoothly, until =
we tried using SOME pci-e devices (some work fine, some don't show up to =
lspci).</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">LSI pci-e controllers no longer show up =
at all!</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We see the ixgbe (intel 10G), =
SiliconImage SATA controller but do not see LSI devices (Specifically =
1068 SAS, FC949-E fibrechannel).</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We're guessing it's a resource issue =
behind the bridge, because the LSI devices try to allocate 1 - 3M behind =
the bridge, but we can't find the bug, or where we would debug such an =
issue.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The devices seem to &quot;train&quot; =
correctly, because we have an LED on the pci-e switch (PLX 8 port pci-e =
switch), and it's ON indicating pci-e link between the bridge and the =
1068 device).</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We're totally at a loss as to why this =
always worked on the 2.6.11 kernel but doesn&#8217;t work on =
2.6.23.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Using lspci, the LSI adapters do not =
show up in the list at all, as though they are not plugged into the =
system.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Is there something that needs to be =
done with respect to PCI-E devices that is new in the 2.6.23 based BSP =
that did not need to be done in the 2.6.11 based kit?&nbsp; For example, =
are pci resources allocated by a different piece of code, that may have =
some issue allocating resources for the LSI adapters?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I currently do not have access to a =
pci-e analyzer.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks for any help,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Vince Asbridge</FONT>
</P>
<BR>

</BODY>
</HTML>
------=_NextPart_000_13C7_01C8D5F0.A3E68500--
