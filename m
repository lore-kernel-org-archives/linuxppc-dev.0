Return-Path: <jsaari@mc.com>
Received: from mc.com (iris-63.mc.com [63.96.239.141])
	by ozlabs.org (Postfix) with ESMTP id 9BEB96884E
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Dec 2005 09:51:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5F923.8630B8DE"
Date: Sun, 4 Dec 2005 17:39:02 -0500
Message-ID: <9CE608B28EA97C489DF1A47D8C6E71530C62AF@ad-email1.ad.mc.com>
From: "Saari, James" <jsaari@mc.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: problem during kernel init with mmu_off
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

------_=_NextPart_001_01C5F923.8630B8DE
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable


I would seem to be in much the same bad place; can you tell my how you
resolved your issue?


problem during kernel init with mmu_off

Stuart Yoder stuart.yoder at conformative.com
<mailto:linuxppc-embedded%40ozlabs.org?Subject=3Dproblem%20during%20kerne=
l
%20init%20with%20mmu_off&In-Reply-To=3D>=20
Fri Mar 12 01:28:25 EST 2004=20

*	Previous message: unable to input in u-boot at Lite5200
<http://ozlabs.org/pipermail/linuxppc-embedded/2004-March/013598.html>=20
*	Next message: Can't set the schedual parameter of threads in
linux
<http://ozlabs.org/pipermail/linuxppc-embedded/2004-March/013592.html>=20
*	Messages sorted by: [ date ]
<http://ozlabs.org/pipermail/linuxppc-embedded/2004-March/date.html#1359
1>  [ thread ]
<http://ozlabs.org/pipermail/linuxppc-embedded/2004-March/thread.html#13
591>  [ subject ]
<http://ozlabs.org/pipermail/linuxppc-embedded/2004-March/subject.html#1
3591>  [ author ]
<http://ozlabs.org/pipermail/linuxppc-embedded/2004-March/author.html#13
591> =20

  _____ =20

I am trying to boot the 2.4 PPC kernel on a PPC750FX eval board.   The
bootloader in the boards firmware has the mmu _on_ with block addr
translation enabled.  It seems that all the BAT mappings are 1:1.

The kernel source as well as comments in the archive of this mailing
list
indicate that the mmu being on during kernel initialization should not
be an
issue.

However, I've determined through leds and uart that the kernel makes it
to
the RFI in mmu_off, but from that point goes into never-never land (I
can't
tell exactly what happened).

I've verified that the values in SRR0 and SRR1 are what is expected
prior to
the RFI which is supposed to turn the mmu off.

I also tried using MTMSR instead of RFI to turn the mmu off but the
processor seems to halt at that instruction.

I don't have a jtag debugger (yet) so I'm relying on leds and uart to
debug.
I really have no idea of the state of the chip after the RFI or MTMSR.

Anyone out there have any ideas?   Anything about the 750FX that is
different than other processors?

Thanks,

Stuart Yoder



=20

----------------------------------------------------------------=20
James E P Saari, Systems Engineer, Defense Electronics Group
Mercury Computer Systems, Inc. http://www.mc.com
<blocked::blocked::blocked::http://www.mc.com/> =20
1800 Alexander Bell Drive, Suite 100, Reston VA 20191
O: 703-673-2700 800-969-6702 D: 703-673-2717
F: 703-673-2727 800-969-8578
E-Mail mailto:jsaari@mc.com
<blocked::blocked::blocked::mailto:jsaari@mc.com>  (Personal)
mailto:jamesepsaari@cox.net
<blocked::blocked::blocked::mailto:jamesepsaari@cox.net> =20
Internal: x2717 http://home.mc.com/~jsaari
<blocked::blocked::blocked::http://home.mc.com/~jsaari> =20
-- [ ] --
Website of the week: http://biz.yahoo.com/special/drucker05.html
"Exploit change as an opportunity, and don't view it as a threat." -
Peter Drucker

=20

------_=_NextPart_001_01C5F923.8630B8DE
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1522" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>
<H1><SPAN class=3D607103821-04122005><FONT size=3D2>I would seem to be =
in much the=20
same bad place; can you tell my how you resolved your =
issue?</FONT></SPAN></H1>
<H1><SPAN class=3D607103821-04122005></SPAN>problem during kernel init =
with=20
mmu_off</H1><STRONG>Stuart Yoder</STRONG> <A=20
title=3D"problem during kernel init with mmu_off"=20
href=3D"mailto:linuxppc-embedded%40ozlabs.org?Subject=3Dproblem%20during%=
20kernel%20init%20with%20mmu_off&amp;In-Reply-To=3D">stuart.yoder=20
at conformative.com </A><BR><I>Fri Mar 12 01:28:25 EST 2004</I>=20
<P>
<UL>
  <LI>Previous message: <A=20
  =
href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-March/013598.h=
tml">unable=20
  to input in u-boot at Lite5200 </A>
  <LI>Next message: <A=20
  =
href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-March/013592.h=
tml">Can't=20
  set the schedual parameter of threads in linux </A>
  <LI><B>Messages sorted by:</B> <A=20
  =
href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-March/date.htm=
l#13591">[=20
  date ]</A> <A=20
  =
href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-March/thread.h=
tml#13591">[=20
  thread ]</A> <A=20
  =
href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-March/subject.=
html#13591">[=20
  subject ]</A> <A=20
  =
href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-March/author.h=
tml#13591">[=20
  author ]</A> </LI></UL>
<HR>
<!--beginarticle--><PRE>I am trying to boot the 2.4 PPC kernel on a =
PPC750FX eval board.   The
bootloader in the boards firmware has the mmu _on_ with block addr
translation enabled.  It seems that all the BAT mappings are 1:1.

The kernel source as well as comments in the archive of this mailing =
list
indicate that the mmu being on during kernel initialization should not =
be an
issue.

However, I've determined through leds and uart that the kernel makes it =
to
the RFI in mmu_off, but from that point goes into never-never land (I =
can't
tell exactly what happened).

I've verified that the values in SRR0 and SRR1 are what is expected =
prior to
the RFI which is supposed to turn the mmu off.

I also tried using MTMSR instead of RFI to turn the mmu off but the
processor seems to halt at that instruction.

I don't have a jtag debugger (yet) so I'm relying on leds and uart to =
debug.
I really have no idea of the state of the chip after the RFI or MTMSR.

Anyone out there have any ideas?   Anything about the 750FX that is
different than other processors?

Thanks,

Stuart Yoder


</PRE></FONT></DIV>
<DIV>&nbsp;</DIV>
<P dir=3Dltr align=3Dleft><FONT face=3DArial=20
size=3D1>----------------------------------------------------------------=
=20
<BR>James<SPAN class=3D690455914-17032004> E P </SPAN>Saari, Systems =
Engineer,=20
</FONT><FONT size=3D1><FONT face=3DArial>Defense Electronics =
Group<BR>Mercury=20
Computer Systems, Inc.<U> <A title=3Dblocked::http://www.mc.com/=20
href=3D"blocked::blocked::blocked::http://www.mc.com/" =
target=3D_blank><FONT=20
color=3D#000000>http://www.mc.com</FONT></A></U> <BR><SPAN=20
class=3D868421714-18022005>1800 Alexander Bell Drive, Suite 100,=20
</SPAN></FONT></FONT><FONT size=3D1><FONT face=3DArial><SPAN=20
class=3D868421714-18022005>Reston VA 20191<BR></SPAN><SPAN=20
class=3D868421714-18022005>O: 703-673-2700 </SPAN></FONT></FONT><FONT =
size=3D1><FONT=20
face=3DArial><SPAN class=3D868421714-18022005>800-969-6702 D:=20
703-673-2717<BR></SPAN><SPAN class=3D868421714-18022005>F: 703-673-2727=20
</SPAN></FONT></FONT><FONT size=3D1><FONT face=3DArial><SPAN=20
class=3D868421714-18022005>800-969-8578<BR></SPAN>E-Mail =
</FONT></FONT><A=20
title=3Dblocked::mailto:jsaari@mc.com=20
href=3D"blocked::blocked::blocked::mailto:jsaari@mc.com"><FONT =
face=3DArial=20
color=3D#000000 size=3D1>mailto:jsaari@mc.com</FONT></A><FONT =
face=3DArial size=3D1>=20
(Personal) </FONT><A title=3Dblocked::mailto:jamesepsaari@cox.net=20
href=3D"blocked::blocked::blocked::mailto:jamesepsaari@cox.net"><FONT =
face=3DArial=20
color=3D#000000 size=3D1>mailto:jamesepsaari@cox.net</FONT></A><FONT =
face=3DArial=20
size=3D1> <BR>Internal: x<SPAN class=3D571331515-11032005>2717</SPAN><U> =
<A=20
title=3Dblocked::http://home.mc.com/~jsaari=20
href=3D"blocked::blocked::blocked::http://home.mc.com/~jsaari" =
target=3D_blank><FONT=20
color=3D#000000>http://home.mc.com/~jsaari</FONT></A></U> <BR>-- [ ]=20
--<BR></FONT><SPAN class=3D926004613-08042005><FONT face=3DArial =
size=3D1>Website of=20
the week: <A=20
href=3D"http://biz.yahoo.com/special/drucker05.html">http://biz.yahoo.com=
/special/drucker05.html</A><BR></FONT></SPAN><SPAN=20
class=3D926004613-08042005><FONT face=3DArial size=3D1>"Exploit change =
as an=20
opportunity, and don&#8217;t view it as a threat." - Peter =
Drucker</P></FONT></SPAN>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C5F923.8630B8DE--
