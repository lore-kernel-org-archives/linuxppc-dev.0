Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id A5B1FDE029
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 22:48:11 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KAlSp-0003Xn-SJ
	for linuxppc-dev@ozlabs.org; Mon, 23 Jun 2008 05:48:07 -0700
Message-ID: <18067094.post@talk.nabble.com>
Date: Mon, 23 Jun 2008 05:48:07 -0700 (PDT)
From: jumpingProgrammer <rabbitzp@163.com>
To: linuxppc-dev@ozlabs.org
Subject: a question of mpc8313, maybe simple
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


i am working with a board of mpc8313 using default mpc8313erdb.dts.
But i do not know how can i correctly use DMA to transport data from memory
to a PCI device.
i tryed this
{
     .....
     request_irq(IRQ,....);
     request_dma(.....);
     ....
}

In request_irq() , i do not know what is the parameter IRQ.
And , i did not find any words about DMA in mpc8313erdb.dts .
So 
1. please tell me what should be the parameter IRQ?
      Is it the irq requested when DMA initialized or another one?
2. If i want initialize DMA, how should i do with mpc8313erdb.dts?


-- 
View this message in context: http://www.nabble.com/a-question-of-mpc8313%2C-maybe-simple-tp18067094p18067094.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
