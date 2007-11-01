Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 17AFDDDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 03:47:41 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IndCj-0002CV-DU
	for linuxppc-embedded@ozlabs.org; Thu, 01 Nov 2007 09:47:37 -0700
Message-ID: <13532592.post@talk.nabble.com>
Date: Thu, 1 Nov 2007 09:47:37 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: serial GDBServer PPC405  problems
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi everyone
I want to thank everyone for all of my problems so far, you have been a
great help.

Im trying to get a debug session with gdbserver over a serial connection on
my Xilinx ML410 using a uartlite set at Baud 115200.  When I issue the
command on the target "./gdbserver /dev/ttyUL1 test" I get this error:
Remote debugging using /dev/ttyUL1
readchar: Socet operation on non-socket
Remote Side has terminated connection.  GDBserver will reopen connection.

This error just repeats until I kill the process.  I know that gdbserver
works because debugging over TCP works fine.
Thanks for your help
-- 
View this message in context: http://www.nabble.com/serial-GDBServer-PPC405--problems-tf4732593.html#a13532592
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
