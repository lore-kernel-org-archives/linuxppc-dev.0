Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <A1C99F4731CAD111BA5400A024FC3B0CCD0938@ESBILMA01EDCGE>
From: "Billalabeitia, Jose Carlos (IndSys, GEPM)" <jc.billalabeitia@indsys.ge.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: sh: tcsetpgrp: Inappropriate ioctl for device
Date: Thu, 11 Jul 2002 09:18:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody:

	I have a custom board with kernel 2-4-4-2002-02-14 from
denx and busybox 0.51. Every time an script is executed in
the console I get the message:

	"sh: tcsetpgrp: Inappropriate ioctl for device"

It doesn´t happen when the script is executed from a telnet
session. This is not harmful for the script but it´s very annoying.
Can anyone out there tell me how I can eliminate this message.

					Thanks
						Billa

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
