Return-Path: <bharathg@hcltech.com>
Received: from rose.ctd.hcltech.com (rose.ctd.hcltech.com [202.54.64.23])
	by ozlabs.org (Postfix) with ESMTP id F28332BF0E
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2005 17:34:50 +1100 (EST)
Message-ID: <012301731C23DE4DBFE035647C68F1CC73F0F9@sindhu.ctd.hcltech.com>
From: "Bharath G - CTD , Chennai" <bharathg@hcltech.com>
To: <linuxppc-dev@ozlabs.org>
Date: Thu, 6 Jan 2005 11:46:42 +0530 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Any Patches for MPC 8270 ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi All,
		This is my fist mail to this mailing list. New year
greetings to all on the list.

	I am working on a MPC8270 Based board with a montavista linux
kernel.Now i seem to have bumped into a lot of problems with this =
kernel.I
dont seem have support for USB-1.0 or I2C on the controller in this
distribution.=20

	I was wondering where should i kick start my porting effort on a
2.4.X and a 2.6.x kernel, if anyone has any patches for the MPC8270 i =
would
be much obliged to use the same.=20

	I am also using a PCI-USB 2.0 on my board.I have seen some nasty
problems in 2.4.X with a EPIA-M board on the USB 2.0 bus , are these =
issues
relevant in the PPC 2.4.X kernel ? I know that a backport has been done =
for
the 2.4.X kernel series, but still wanted to check with forum if anyone =
has
had any problems on the 2.4.X kernel with USB 2.0.

Any pointers on this would be really helpful,

Waiting for a reply,

Thanks in advance,

.Bharath.


	Be warned that typing \fBkillall \fIname\fP may not have the desired
effect on non-Linux systems, especially when done by a privileged user.
-From the killall manual page.=20
DISCLAIMER=20
This message and any attachment(s) contained here are information that =
is confidential, proprietary to HCL Technologies=20
and its customers. Contents may be privileged or otherwise protected by =
law. The information is solely intended for the=20
individual or the entity it is addressed to. If you are not the intended =
recipient of this message, you are not authorized to=20
read, forward, print, retain, copy or disseminate this message or any =
part of it. If you have received this e-mail in error,=20
please notify the sender immediately by return e-mail and delete it from =
your computer
