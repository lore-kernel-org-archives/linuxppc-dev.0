Return-Path: <pavan_savoy@indiatimes.com>
Received: from omta2.indiatimes.com (logs.indiatimes.com [203.199.93.25])
	by ozlabs.org (Postfix) with SMTP id 8C9DDDDF35
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 17:35:11 +1000 (EST)
Date: Thu, 15 May 2008 12:45:07 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: linuxppc-dev@ozlabs.org
Message-ID: <1655903468.17841210835707224.JavaMail.root@mbv7.indiatimes.com>
Subject: Hi Question on External Interrupts
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Hi,

being new to low level details of PPC, I have this doubt on the external Interrupt openPIC of some platform like mpc8540ads.

If at all, I request_irq on IRQ_EXT2 [say an example], and the interrupt handler is called, how do I know the line state of such an interrupt ? i.e is it low or high ?

Actually I want to interface a spi or i2c slave device which also connects via an external Interrupt which generates and interrupt and my actions are based upon knowing the line status.

[ Earlier interface was with arm architecture & GPIO and question must be naive].

Thanks
