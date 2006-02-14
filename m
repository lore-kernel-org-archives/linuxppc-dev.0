Return-Path: <lagrange@fr.oleane.com>
Received: from smtp3.clb.oleane.net (smtp3.clb.oleane.net [213.56.31.19])
	by ozlabs.org (Postfix) with ESMTP id D52E3679FC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 03:09:33 +1100 (EST)
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: "'Pantelis Antoniou'" <pantelis.antoniou@gmail.com>
Subject: RE: Gianfar is slower than fcc_enet on MPC8541 ???
Date: Tue, 14 Feb 2006 17:14:59 +0100
Message-ID: <000201c63181$cf2c3180$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0003_01C6318A.30F09980"
In-Reply-To: <449c76a00602140728g3a9eb46sd70f23b894c4b96@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
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

------=_NextPart_000_0003_01C6318A.30F09980
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Pantelis,

Thanks for the express reply.

I know that what I say seems incredible. But I don't understand what NAPI
does.
My measure is very simple. I display a message on the client when 1000
exchanges are done.
I already check the ifconfig stats on the board after some seconds.
The measures seems the same with or without NAPI.

More details ?
Thanks again
Laurent


  -----Message d'origine-----
  De : Pantelis Antoniou [mailto:pantelis.antoniou@gmail.com]
  Envoyé : mar. 14 février 2006 16:29
  À : Laurent Lagrange
  Cc : linuxppc-embedded@ozlabs.org
  Objet : Re: Gianfar is slower than fcc_enet on MPC8541 ???


  Hi Laurent,

  I found that pretty hard to believe.

  What are you measuring exactly?

  Speed of replies? If so it's explainable since the TSECs use
  NAPI.

  Regards

  Pantelis


  On 2/14/06, Laurent Lagrange <lagrange@fr.oleane.com> wrote:

    Hello,

    I work on a cutom MPC8541 board with Linux 2.6.9.
    The kernel activates the L1 cache (instructions and data)
    and the L2 cache (entirely used as cache and not as sram).

    I configure
    1 FCC (FCC1),
    2 TSECs with or without NAPI (no effect) but without stashing in L2
sram.
    All PHYs are automatically configured in 100MB full duplex.

            eth0: Gianfar Ethernet Controller Version 1.1, 00:10:cd:48:48:e0
            eth0: Running with NAPI disabled
            eth0: 64/64 RX/TX BD ring size
            eth1: Gianfar Ethernet Controller Version 1.1, 00:10:cd:48:48:e1
            eth1: Running with NAPI disabled
            eth1: 64/64 RX/TX BD ring size
            eth2: FCC ENET Version custom, 00:10:cd:48:48:e2

    Then I launch 3 simple TCP servers, one on each ports.

    From remote machines I runs 3 TCP clients.
    The client sends messages of 1000 bytes,
    The server receives and echoes the message
    The client receives the echoed message, check the content
    and sends a new message again.

    The result is that the 2 TSECs are 2 times slower than the FCC.

    If I run a "top" application on the board, I use less than 10% of the
CPU
    Each port consumes about 1/3 of the CPU.

    Any idea on how to configure the gianfar driver ?

    Thanks
    Laurent


    _______________________________________________
    Linuxppc-embedded mailing list
    Linuxppc-embedded@ozlabs.org
    https://ozlabs.org/mailman/listinfo/linuxppc-embedded



------=_NextPart_000_0003_01C6318A.30F09980
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =
size=3D2>Hi=20
Pantelis,</FONT></SPAN></DIV>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =
size=3D2>Thanks=20
for the express reply.</FONT></SPAN></DIV>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =
size=3D2>I know=20
that what I say seems incredible. </FONT></SPAN><SPAN=20
class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =
size=3D2>But I don't=20
understand what NAPI does.</FONT></SPAN></DIV>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =
size=3D2>My=20
measure is very simple. I display a message </FONT></SPAN><SPAN=20
class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =
size=3D2>on the client=20
when 1000 exchanges are done.</FONT></SPAN></DIV>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =
size=3D2>I=20
already check the ifconfig stats on the board after some=20
seconds.</FONT></SPAN></DIV>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =
size=3D2>The=20
measures seems the same with or without NAPI.</FONT></SPAN></DIV>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =
size=3D2>More=20
details ?</FONT></SPAN></DIV>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =
size=3D2>Thanks=20
again</FONT></SPAN></DIV>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =

size=3D2>Laurent</FONT></SPAN></DIV>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D609480116-14022006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid">
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Message d'origine-----<BR><B>De&nbsp;:</B> Pantelis =
Antoniou=20
  [mailto:pantelis.antoniou@gmail.com]<BR><B>Envoy=E9&nbsp;:</B> mar. 14 =
f=E9vrier=20
  2006 16:29<BR><B>=C0&nbsp;:</B> Laurent Lagrange<BR><B>Cc&nbsp;:</B>=20
  linuxppc-embedded@ozlabs.org<BR><B>Objet&nbsp;:</B> Re: Gianfar is =
slower than=20
  fcc_enet on MPC8541 ???<BR><BR></FONT></DIV>Hi Laurent,<BR><BR>I found =
that=20
  pretty hard to believe.<BR><BR>What are you measuring =
exactly?<BR><BR>Speed of=20
  replies? If so it's explainable since the TSECs=20
  use<BR>NAPI.<BR><BR>Regards<BR><BR>Pantelis<BR><BR>
  <DIV><SPAN class=3Dgmail_quote>On 2/14/06, <B =
class=3Dgmail_sendername>Laurent=20
  Lagrange</B> &lt;<A=20
  href=3D"mailto:lagrange@fr.oleane.com">lagrange@fr.oleane.com</A>&gt;=20
  wrote:</SPAN>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid"><BR>Hello,<BR><BR>I=20
    work on a cutom MPC8541 board with Linux 2.6.9.<BR>The kernel =
activates the=20
    L1 cache (instructions and data)<BR>and the L2 cache (entirely used =
as cache=20
    and not as sram).<BR><BR>I configure<BR>1 FCC (FCC1), <BR>2 TSECs =
with or=20
    without NAPI (no effect) but without stashing in L2 sram.<BR>All =
PHYs are=20
    automatically configured in 100MB full=20
    duplex.<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth0: =
Gianfar=20
    Ethernet Controller Version 1.1,=20
    =
00:10:cd:48:48:e0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth0=
:=20
    Running with NAPI=20
    disabled<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth0: =
64/64=20
    RX/TX BD ring =
size<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth1:=20
    Gianfar Ethernet Controller Version 1.1,=20
    =
00:10:cd:48:48:e1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth1=
:=20
    Running with NAPI=20
    disabled<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth1: =
64/64=20
    RX/TX BD ring size =
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth2:=20
    FCC ENET Version custom, 00:10:cd:48:48:e2<BR><BR>Then I launch 3 =
simple TCP=20
    servers, one on each ports.<BR><BR>From remote machines I runs 3 TCP =

    clients.<BR>The client sends messages of 1000 bytes,<BR>The server =
receives=20
    and echoes the message <BR>The client receives the echoed message, =
check the=20
    content<BR>and sends a new message again.<BR><BR>The result is that =
the 2=20
    TSECs are 2 times slower than the FCC.<BR><BR>If I run a "top" =
application=20
    on the board, I use less than 10% of the CPU <BR>Each port consumes =
about=20
    1/3 of the CPU.<BR><BR>Any idea on how to configure the gianfar =
driver=20
    =
?<BR><BR>Thanks<BR>Laurent<BR><BR><BR>___________________________________=
____________<BR>Linuxppc-embedded=20
    mailing list<BR><A=20
    =
href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org=
</A><BR><A=20
    =
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR></BLOCKQUOTE></DIV><BR=
></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0003_01C6318A.30F09980--
