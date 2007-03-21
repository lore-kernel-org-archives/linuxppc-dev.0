Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4DB48DDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 01:17:51 +1100 (EST)
In-Reply-To: <1174359820.10827.8.camel@concordia.ozlabs.ibm.com>
References: <11740199151814-git-send-email-wei.zhang@freescale.com>
	<11740199152595-git-send-email-wei.zhang@freescale.com>
	<11740199154116-git-send-email-wei.zhang@freescale.com>
	<11740199152381-git-send-email-wei.zhang@freescale.com>
	<1174359820.10827.8.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <65a42fd7d277db5f565849a07d8dea90@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/4] Add irq debugfs and virq_mapping for getting the virq
	to irq host's hwirq mapping list.
Date: Wed, 21 Mar 2007 15:17:45 +0100
To: michael@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, r54964@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> This patch adds 'irq' directory into the root debugfs and 
>> virq_mapping for getting the virq to
>> irq host's hwirq mapping list.
>
> Minor nit. Should we be creating a 'powerpc' directory first, and
> putting the 'irq' file under that? Otherwise we risk clashing with some
> generic code that creates a file called 'irq' in debugfs.

Or put the whole IRQ tree under sysfs generically...


Segher
