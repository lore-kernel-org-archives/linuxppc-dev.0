Return-Path: <johan.derycke@barco.com>
Received: from kuuvir01.barco.com (unknown.barco.com [194.7.240.10])
	by ozlabs.org (Postfix) with SMTP id 9D21C6840D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 22:35:16 +1000 (EST)
Message-ID: <81A66F72DCACD511B0600002A551BFCB08D3A926@kuumex05.barco.com>
From: "Derycke, Johan" <johan.derycke@barco.com>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 28 Sep 2005 14:23:58 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5C427.7FAE9566"
Subject: mpc5200 and pcmcia
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

------_=_NextPart_001_01C5C427.7FAE9566
Content-Type: text/plain

Hi all,

I am working on a custom board based on the Lite5200.
It is expanded with a PCI1410 PC Card Controller on the PCI bus.

In the history of this list I found a patch against an older kernel version
to solve some issues:
http://ozlabs.org/pipermail/linuxppc-embedded/2004-December/016273.html

I took the old 2.4.23 kernel and applied the patch. 
I could get my 3c589 network adaptor to work.
Is this patch available for the current 2.4.25 kernel?

Br,

Johan Derycke


------_=_NextPart_001_01C5C427.7FAE9566
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.24">
<TITLE>mpc5200 and pcmcia</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hi all,</FONT>
</P>

<P><FONT SIZE=3D2>I am working on a custom board based on the =
Lite5200.</FONT>
<BR><FONT SIZE=3D2>It is expanded with a PCI1410 PC Card Controller on =
the PCI bus.</FONT>
</P>

<P><FONT SIZE=3D2>In the history of this list I found a patch against =
an older kernel version to solve some issues:</FONT>
<BR><FONT SIZE=3D2><A =
HREF=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-December/0162=
73.html" =
TARGET=3D"_blank">http://ozlabs.org/pipermail/linuxppc-embedded/2004-Dec=
ember/016273.html</A></FONT>
</P>

<P><FONT SIZE=3D2>I took the old 2.4.23 kernel and applied the patch. =
</FONT>
<BR><FONT SIZE=3D2>I could get my 3c589 network adaptor to work.</FONT>
<BR><FONT SIZE=3D2>Is this patch available for the current 2.4.25 =
kernel?</FONT>
</P>

<P><FONT SIZE=3D2>Br,</FONT>
</P>

<P><FONT SIZE=3D2>Johan Derycke</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5C427.7FAE9566--
