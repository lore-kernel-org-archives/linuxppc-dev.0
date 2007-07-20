Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA2F2DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jul 2007 20:40:57 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IBpup-0000ai-1a
	for linuxppc-embedded@ozlabs.org; Fri, 20 Jul 2007 03:40:55 -0700
Message-ID: <11705912.post@talk.nabble.com>
Date: Fri, 20 Jul 2007 03:40:55 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Problem faced while using workqueue in the character driver.
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


Hi all,

I am working on a character driver for FPGA, in which i am using a blocked
read call on workqueue. The read call will be unblocked by the Interrupt
from the Fpga to PPC Cpu.

The problem is that if the process is in blocked mode and then an Interrupt
occurs the system gives kernel Panic where as it get unblocked and start
reading the data but very soon it gets crashed.

Please send me your suggessins regarding the mentioned problem.
Thanks in advance 
with regard
Misbah
-- 
View this message in context: http://www.nabble.com/Problem-faced-while-using-workqueue-in-the-character-driver.-tf4116327.html#a11705912
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
