Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53FA5DE019
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Dec 2007 15:46:25 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Izm9N-0005df-Mv
	for linuxppc-embedded@ozlabs.org; Tue, 04 Dec 2007 20:46:21 -0800
Message-ID: <14165265.post@talk.nabble.com>
Date: Tue, 4 Dec 2007 20:46:21 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: problem in creation of .ko file while compiling the kernel
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


Hi ...

I am using Montavista kernel which has USB driver support. In make
menuconfig i am making the driver to selected as module but after compiling
and installing on the board i could not be able to find the .ko file .

Even if i am selecting the USB driver (not as module)i could not find the
driver presence.

what could be the probable reason and the solution to it ???

I need to select USB support in the kernel for PPC8272 board. Source code is
already present and montavista provides the support for it .

-----Misbah <><
-- 
View this message in context: http://www.nabble.com/problem-in-creation-of-.ko-file-while-compiling-the-kernel-tf4947452.html#a14165265
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
