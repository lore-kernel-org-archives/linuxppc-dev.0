Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "barry.fisher" <barry.fisher@seranoa.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: 8260 Software Watchdog Timer and Linux Apps
Date: Tue, 5 Feb 2002 13:47:22 -0500
Message-ID: <000301c1ae75$8bd2f6f0$7d0110ac@Seranoa.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Everyone:
In reading the 8260 documentation, it appears that once the 8260
Software Watchdog timer is enabled, it cannot be disabled. Does anyone
know whether the watchdog timer count(SWTC) can be loaded with a
different value prior to the watchdog timer service sequence of 0x556C,
0xAA39? Thanks in advance.
Regards,
Barry O. Fisher
Seranoa Networks
Email: barry.fisher@seranoa.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
