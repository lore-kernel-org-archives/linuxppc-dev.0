Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0E0067A67
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 23:41:33 +1000 (EST)
In-Reply-To: <200606291525.53254.arnd.bergmann@de.ibm.com>
References: <1151570165.28229.15.camel@localhost.localdomain>
	<200606291525.53254.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7B386893-BE8E-4E3A-A351-7A785AEF462F@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: new IRQ work status
Date: Thu, 29 Jun 2006 15:41:21 +0200
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>  /* Get an IRQ number from the pending state register of the IIC */
>> -int iic_get_irq(struct pt_regs *regs)
>> +unsigned int iic_get_irq(struct pt_regs *regs)
>
> Is unsigned the right thing here? NO_IRQ is defined as (-1).

It used to be -1, it's 0 now...


Segher
