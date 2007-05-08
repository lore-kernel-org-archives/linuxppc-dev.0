Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 25B99DDD05
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 May 2007 07:15:01 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C791B5.EEF0628C"
Subject: Time generation MPC8xx
Date: Tue, 8 May 2007 23:11:28 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E26497B@aquib01a>
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

------_=_NextPart_001_01C791B5.EEF0628C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Anyone knows how the time() function works on Linux on MPC8xx? I don't =
have an external RTC circuit but I think is emulated.
I thought that it used /dev/rtc but it doesn't seem so, furthermore =
/dev/rtc is really too fast. It gains 5-6 seconds per minute.

Any help is appreciated.

Bye,
Antonio.

------_=_NextPart_001_01C791B5.EEF0628C
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7234.20">
<TITLE>Time generation MPC8xx</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Anyone knows how the time() function works on Linux on =
MPC8xx? I don't have an external RTC circuit but I think is =
emulated.<BR>
I thought that it used /dev/rtc but it doesn't seem so, furthermore =
/dev/rtc is really too fast. It gains 5-6 seconds per minute.<BR>
<BR>
Any help is appreciated.<BR>
<BR>
Bye,<BR>
Antonio.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C791B5.EEF0628C--
