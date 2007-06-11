Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id C03A7DDF10
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jun 2007 05:03:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7AC5B.33EB3487"
Subject: cat MyFile > /dev/ttyS1 hangs second time it is launched
Date: Mon, 11 Jun 2007 21:00:43 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E26499A@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
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

------_=_NextPart_001_01C7AC5B.33EB3487
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I tried to execute the command in the subject.
First time I launch it, it is successfull.
Second time it hangs when closing /dev/ttyS1, third time and subsequent =
times it clocks on opening /dev/ttyS1.
The same happen on /dev/ttyS0.
Is it necessary to save termios and restore them before closing the =
serial port?

Why?

Bye,
Antonio.

------_=_NextPart_001_01C7AC5B.33EB3487
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7235.2">
<TITLE>cat MyFile &gt; /dev/ttyS1 hangs second time it is =
launched</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>I tried to execute the command in the subject.<BR>
First time I launch it, it is successfull.<BR>
Second time it hangs when closing /dev/ttyS1, third time and subsequent =
times it clocks on opening /dev/ttyS1.<BR>
The same happen on /dev/ttyS0.<BR>
Is it necessary to save termios and restore them before closing the =
serial port?<BR>
<BR>
Why?<BR>
<BR>
Bye,<BR>
Antonio.<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7AC5B.33EB3487--
