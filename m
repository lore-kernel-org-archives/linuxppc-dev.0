Return-Path: <brankok@dkts.co.yu>
Received: from dkts.co.yu (telis.dkts.co.yu [195.178.60.130])
	by ozlabs.org (Postfix) with ESMTP id 8A1992BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Nov 2004 18:41:36 +1100 (EST)
Received: from BRANKO (branko.sraz.dkts.co.yu [192.168.200.36])
	by dkts.co.yu (8.10.2+Sun/8.10.2) with SMTP id iAC7fCW02505
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Nov 2004 08:41:12 +0100 (MET)
Message-ID: <003001c4c88a$db63a840$24c8a8c0@sraz.dkts.co.yu>
From: "Branko on dkts" <brankok@dkts.co.yu>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 12 Nov 2004 08:40:18 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_002D_01C4C893.3CFF79A0"
Subject: Thread cancellation problem
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

------=_NextPart_000_002D_01C4C893.3CFF79A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello group!

I would be most grateful for your help.=20

I am developing a Linux application for ppc. The ppc Linux distribution =
I am using is ELDK 3.0. I am having a problem with canceling a thread =
blocked on read. The thread tries to read data from a HDLC device.=20

I tried to cancel the read thread with thread_cancel() called from =
another thread which did not work as I would like, because the reader =
thread remains blocked until there is data arrived. I also tried to set =
up a signal handler (SIGTERM) for the thread and then to call =
pthraed_kill() from another thread which would cause the read() to =
return -1 with an errno of EINTR which would indicate the reader thread =
to terminate itself. However, the read does not return and the reader =
thread remains blocked...=20

Any suggestions as to what to do next?

Kindest regards,
Branko



------=_NextPart_000_002D_01C4C893.3CFF79A0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello group!</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I would be most grateful for your help. =

</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am developing a Linux application for =
ppc. The=20
ppc Linux distribution I am using is ELDK 3.0. I am having a problem =
with=20
canceling a thread blocked on read. The thread tries to read data from a =
HDLC=20
device. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I&nbsp;tried </FONT><FONT face=3DArial =
size=3D2>to=20
cancel the read thread with thread_cancel() called from another=20
thread&nbsp;which did not work as I would&nbsp;like, because =
the&nbsp;reader=20
thread remains blocked until there&nbsp;is data arrived. I also tried to =
set up=20
a signal handler (SIGTERM) for the thread and then to call =
pthraed_kill() from=20
another thread&nbsp;which would cause the read() to return&nbsp;-1 with =
an errno=20
of EINTR which would&nbsp;indicate the reader thread&nbsp;to terminate =
itself.=20
However, the read does not return and the reader thread remains =
blocked...=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Any suggestions as to what to do =
next?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</DIV></FONT>
<DIV><FONT face=3DArial size=3D2>Kindest regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Branko</DIV></FONT>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_002D_01C4C893.3CFF79A0--
