Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id AB0C8DDEF3
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 11:13:45 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KAx6L-0007yf-RX
	for linuxppc-dev@ozlabs.org; Mon, 23 Jun 2008 18:13:41 -0700
Message-ID: <18081728.post@talk.nabble.com>
Date: Mon, 23 Jun 2008 18:13:41 -0700 (PDT)
From: jumpingProgrammer <rabbitzp@163.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: a question of mpc8313, maybe simple
In-Reply-To: <20080623170956.GA6978@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18067094.post@talk.nabble.com>
	<20080623170956.GA6978@loki.buserror.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Thanks a lot for answer my question.
But i am newhand and not very clear about it.
Do you mean:
1. in this case i do not need to include DMA when i "make menuconfig" ?
        The path is Device Drivers->DMA.
2. in this case i do not need add any DMA information in mpc8313erdb.dts?

Now i am reading PCI driver in kernel 2.6.20 to catch your meaning.


Scott Wood-2 wrote:
> 
> On Mon, Jun 23, 2008 at 05:48:07AM -0700, jumpingProgrammer wrote:
>> i am working with a board of mpc8313 using default mpc8313erdb.dts.
>> But i do not know how can i correctly use DMA to transport data from
>> memory
>> to a PCI device.
>> i tryed this
>> {
>>      .....
>>      request_irq(IRQ,....);
>>      request_dma(.....);
>>      ....
>> }
>> 
>> In request_irq() , i do not know what is the parameter IRQ.
> 
> Use pci_dev->irq.
> 
>> And , i did not find any words about DMA in mpc8313erdb.dts .
> 
> PCI devices can do bus-mastering DMA themselves; request_dma() is for ISA
> devices.
> 
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/a-question-of-mpc8313%2C-maybe-simple-tp18069331p18081728.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
