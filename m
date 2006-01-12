Return-Path: <Ahsan.Kabir@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id A6BCF688D6
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 09:52:14 +1100 (EST)
Received: from de01smr01.am.mot.com (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k0D03j3Z021324
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 17:03:45 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr01.am.mot.com (8.13.1/8.13.0) with ESMTP id k0CN3jah023142
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 17:03:45 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C617CA.CF002098"
Subject: init does not run on 405GP system
Date: Thu, 12 Jan 2006 15:51:57 -0700
Message-ID: <351763BE49AC8743AFCCF925821FF6BE04A503@az33exm22.fsl.freescale.net>
From: "Kabir Ahsan-r9aahw" <Ahsan.Kabir@freescale.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C617CA.CF002098
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi
I found this thread on the web. The reason I am writing is that I am
also seeing some problem with my /sbin/init. Can you elaborate on the
solution? You mentioned that "The On Chip Memory was mapped to an
address below 0x8000'0000 - what we didn't know was that this is a
_virtual_ address, because the OCM is not simply located "behind" the
MMU."=20
What do you mean by OCM? What do you mean by address below 0x80000000?
So you had to redefine your MMU definition to get through this error?
Regard,
Ahsan
=20
On Tue, Jun 10, 2003 at 04:10:47PM +0200, Robert Schwebel wrote:
> Nevertheless, the kernel runs smoothly. I can ping the machine, I can
> even floodping it with 0% packet loss. Only that there is no
userspace> running.
>
> Has anybody seen something like this before?

It is solved. The On Chip Memory was mapped to an address below
0x8000'0000 - what we didn't know was that this is a _virtual_ address,
because the OCM is not simply located "behind" the MMU. After changing
the mapping it works smoothly now.

Robert
--
Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
<http://www.pengutronix.de/>=20
Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/




------_=_NextPart_001_01C617CA.CF002098
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D942414822-12012006><FONT face=3DArial=20
size=3D2>Hi</FONT></SPAN></DIV>
<DIV><SPAN class=3D942414822-12012006><FONT face=3DArial size=3D2>I =
found this thread=20
on the web. The reason I am writing is that I am also seeing some =
problem with=20
my /sbin/init. Can you elaborate on the solution? You mentioned that =
<FONT=20
face=3D"Times New Roman" size=3D3>"The On Chip Memory was mapped to an =
address below=20
0x8000'0000 - what we didn't know was that this is a _virtual_ address, =
because=20
the OCM is not simply located "behind" the MMU." =
</FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D942414822-12012006>What do you mean by OCM? What do =
you mean by=20
address below 0x80000000? So you had to redefine your MMU definition to =
get=20
through this error?</SPAN></DIV>
<DIV><SPAN class=3D942414822-12012006>Regard,</SPAN></DIV>
<DIV><SPAN class=3D942414822-12012006>Ahsan</SPAN></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>On Tue, Jun 10, 2003 at 04:10:47PM +0200, Robert Schwebel =
wrote:<BR>&gt;<I>=20
Nevertheless, the kernel runs smoothly. I can ping the machine, I=20
can<BR></I>&gt;<I> even floodping it with 0% packet loss. Only that =
there is no=20
userspace</I>&gt;<I> running.<BR></I>&gt;<I><BR></I>&gt;<I> Has anybody =
seen=20
something like this before?<BR></I><BR>It is solved. The On Chip Memory =
was=20
mapped to an address below<BR>0x8000'0000 - what we didn't know was that =
this is=20
a _virtual_ address,<BR>because the OCM is not simply located "behind" =
the MMU.=20
After changing<BR>the mapping it works smoothly =
now.<BR><BR>Robert<BR>--<BR>=20
Dipl.-Ing. Robert Schwebel | <A=20
href=3D"http://www.pengutronix.de/">http://www.pengutronix.de</A><BR> =
Pengutronix=20
- Linux Solutions for Science and Industry<BR>&nbsp;&nbsp; =
Braunschweiger Str.=20
79,&nbsp; 31134 Hildesheim, Germany<BR>&nbsp;&nbsp; =
Handelsregister:&nbsp;=20
Amtsgericht Hildesheim, HRA 2686<BR>&nbsp;&nbsp;&nbsp; Phone: =
+49-5121-28619-0=20
|&nbsp; Fax: +49-5121-28619-4<BR><BR>** Sent via the linuxppc-dev mail =
list. See=20
<A=20
href=3D"http://lists.linuxppc.org/">http://lists.linuxppc.org/</A><BR><BR=
><BR></DIV></BODY></HTML>

------_=_NextPart_001_01C617CA.CF002098--
