Return-Path: <Benjamin.Dubb@ipc.com>
Received: from stsnycon1.corp.root.ipc.com (ipcny.ipc.com [65.244.37.61])
	by ozlabs.org (Postfix) with ESMTP id 2D6FD68A73
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jan 2006 11:13:50 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C625FB.34EA9A03"
Subject: m82xx usb host error
Date: Mon, 30 Jan 2006 19:13:48 -0500
Message-ID: <9A63F321BC93984690A3CA6A1652C2ED091017D3@exnanycmbx1.corp.root.ipc.com>
From: "Dubb, Benjamin" <Benjamin.Dubb@ipc.com>
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

------_=_NextPart_001_01C625FB.34EA9A03
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Folks,
=20
I'm seeing the following with 2.4.20 kernel running on mpc8270. The host =
never shows any activity when I plug usb devices. What's the best way to =
debug this? Thanks,
=20
 - Ben
=20
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
Looking up port of RPC 100003/2 on 10.0.0.1
Looking up port of RPC 100005/1 on 10.0.0.1
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 88k init
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 0, 12 Mb/s
hub.c: new USB device m82xxhci-1, assigned address 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3D2 (error=3D-110)
hub.c: port 1, portstatus 103, change 0, 12 Mb/s
hub.c: new USB device m82xxhci-1, assigned address 3
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3D3 (error=3D-110)



DISCLAIMER:
Important Notice *************************************************
This e-mail may contain information that is confidential, privileged or =
otherwise protected from disclosure. If you are not an intended =
recipient of this e-mail, do not duplicate or redistribute it by any =
means. Please delete it and any attachments and notify the sender that =
you have received it in error. Unintended recipients are prohibited from =
taking action on the basis of information in this e-mail.E-mail messages =
may contain computer viruses or other defects, may not be accurately =
replicated on other systems, or may be intercepted, deleted or =
interfered with without the knowledge of the sender or the intended =
recipient. If you are not comfortable with the risks associated with =
e-mail messages, you may decide not to use e-mail to communicate with =
IPC. IPC reserves the right, to the extent and under circumstances =
permitted by applicable law, to retain, monitor and intercept e-mail =
messages to and from its systems.

------_=_NextPart_001_01C625FB.34EA9A03
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Message</TITLE>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2919.6307" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D081500900-31012006>Folks,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D081500900-31012006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D081500900-31012006>I'm =
seeing the=20
following with 2.4.20 kernel running on mpc8270. The host never shows =
any=20
activity when I plug usb devices. What's the best way to debug this?=20
Thanks,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D081500900-31012006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D081500900-31012006>&nbsp;-=20
Ben</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>hub.c: port 1, portstatus 101, change =
1, 12=20
Mb/s<BR>hub.c: port 1 connection change<BR>hub.c: port 1, portstatus =
101, change=20
1, 12 Mb/s<BR>Looking up port of RPC 100003/2 on 10.0.0.1<BR>Looking up =
port of=20
RPC 100005/1 on 10.0.0.1<BR>hub.c: port 1, portstatus 101, change 0, 12=20
Mb/s<BR>hub.c: port 1, portstatus 101, change 0, 12 Mb/s<BR>VFS: Mounted =
root=20
(nfs filesystem).<BR>Mounted devfs on /dev<BR>Freeing unused kernel =
memory: 88k=20
init<BR>hub.c: port 1, portstatus 101, change 0, 12 Mb/s<BR>hub.c: port =
1,=20
portstatus 101, change 0, 12 Mb/s<BR>hub.c: port 1, portstatus 103, =
change 0, 12=20
Mb/s<BR>hub.c: new USB device m82xxhci-1, assigned address=20
2<BR>usb_control/bulk_msg: timeout<BR>usb.c: USB device not accepting =
new=20
address=3D2 (error=3D-110)<BR>hub.c: port 1, portstatus 103, change 0, =
12=20
Mb/s<BR>hub.c: new USB device m82xxhci-1, assigned address=20
3<BR>usb_control/bulk_msg: timeout<BR>usb.c: USB device not accepting =
new=20
address=3D3 =
(error=3D-110)<BR></DIV></FONT><p></p><p>DISCLAIMER:<br>Important Notice =
************************************************* <br>This e-mail may =
contain information that is confidential, privileged or otherwise =
protected from disclosure. If you are not an intended recipient of this =
e-mail, do not duplicate or redistribute it by any means. Please delete =
it and any attachments and notify the sender that you have received it =
in error. Unintended recipients are prohibited from taking action on the =
basis of information in this e-mail.E-mail messages may contain computer =
viruses or other defects, may not be accurately replicated on other =
systems, or may be intercepted, deleted or interfered with without the =
knowledge of the sender or the intended recipient. If you are not =
comfortable with the risks associated with e-mail messages, you may =
decide not to use e-mail to communicate with IPC. IPC reserves the =
right, to the extent and under circumstances permitted by applicable =
law, to retain, monitor and intercept e-mail messages to and from its =
systems.</BODY></HTML>

------_=_NextPart_001_01C625FB.34EA9A03--
