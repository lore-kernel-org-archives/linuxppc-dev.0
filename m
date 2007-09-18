Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2A12DDE1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 01:09:54 +1000 (EST)
In-Reply-To: <46EFE849.7080508@ru.mvista.com>
References: <20070918144426.GA22102@ru.mvista.com>
	<2E339F78-F42B-4FCE-A97E-FFE9AE4C44F1@kernel.crashing.org>
	<46EFE849.7080508@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DF9456FB-459D-4800-B994-D9B198096069@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] [PATCH] PowerPC: Add 64-bit phys addr support to 32-bit pci.
Date: Tue, 18 Sep 2007 10:13:03 -0500
To: Valentine Barshak <vbarshak@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 18, 2007, at 10:01 AM, Valentine Barshak wrote:

> Kumar Gala wrote:
>> On Sep 18, 2007, at 9:44 AM, Valentine Barshak wrote:
>>> Add 64-bit physical address support to PCI.
>> Can you expand on your commit message.  for example why do this?  
>> is it address a bug fix, etc..
>>>
>>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>>> ---
>>>  arch/powerpc/kernel/iomap.c  |    4 +--
>>>  arch/powerpc/kernel/pci_32.c |   56 ++++++++++++++++++++++++++++ 
>>> +--------------
>>>  2 files changed, 41 insertions(+), 19 deletions(-)
>> - k
>
> Currently 32-bit pci code doesn't support 64-bit physical addresses.
> We have to add 64-bit addr support in order to bring-up pci on  
> PowerPC 440. Actually, this refers to the conversation started here:

I can guess as to why, but its useful for the commit messages to be  
more descriptive so when some goes back a year from now they know why  
someone added this patch.

- k
