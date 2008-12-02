Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id D556BDDD01
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Dec 2008 21:19:14 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1L7SLX-0001go-K2
	for linuxppc-embedded@ozlabs.org; Tue, 02 Dec 2008 02:19:11 -0800
Message-ID: <20789399.post@talk.nabble.com>
Date: Tue, 2 Dec 2008 02:19:11 -0800 (PST)
From: vadik <vadikml@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: virtex4 RTOS with hw FPU.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I have implementation of Virtex4 with hw FPU trough APU .

Is there any Real Time OS that directly supports this implementation without
relying on sw floating point emulation.

Xilinx Relesed GCC build of their own that is patched to support the apu fpu
implementation , but this helps me on the application level but if the
kernel doesn't support this implemntation i have a problem .

linux is not RT enough , does the linuxwoks supports this kind of
implementation ?

Thank you.
Vadim.


-- 
View this message in context: http://www.nabble.com/virtex4-RTOS-with-hw-FPU.-tp20789399p20789399.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
