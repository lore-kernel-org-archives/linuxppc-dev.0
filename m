Message-ID: <CA78D1B723D8D411AF0300508BDCF74FF0C566@NTCORREO>
From: GOTZON ASTONDOA <gastondoa@fagorautomation.es>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Fast shutdown
Date: Tue, 12 Nov 2002 16:04:39 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all:

	Our custom board has to microprocessors: 68K and PowerPC. We have
instaled Linux in the PowerPc side.
	When the user suddenly shutdowns the board, the 68K sends an
interrupt to the PowerPC.We have more or less 8 mSeg to close all the Linux
system (it has hard disk, ethernet, ftp and our own application).

	Can somebody tell me any idea to close the Linux system in the
fastest way? We are thinking in capture the interrupt signal, but, is it
enough fast?

Thanks for your help in advance.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
