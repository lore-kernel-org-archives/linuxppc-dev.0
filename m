Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0224ADDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Nov 2007 08:00:01 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IuaCN-0004hn-0Z
	for linuxppc-embedded@ozlabs.org; Tue, 20 Nov 2007 12:59:59 -0800
Message-ID: <13865715.post@talk.nabble.com>
Date: Tue, 20 Nov 2007 12:59:59 -0800 (PST)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Debugging with gdbserver slow
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


Hi everyone,

Im using gdbserver to debug Linux apps on my embedded board, but it takes
like 3-6 sec to step one line of code.  Its about the same to go from
breakpoint to breakpont.  Im using TCP to connect the host to the target. 
Is this typical or is there some setting wrong or was it built wrong.  Its a
PPC405 in a Xilinx FPGA.

Thanks

khollan
-- 
View this message in context: http://www.nabble.com/Debugging-with-gdbserver-slow-tf4846374.html#a13865715
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
