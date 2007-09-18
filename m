Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9A329DDF97
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 01:02:33 +1000 (EST)
Message-ID: <46EFE849.7080508@ru.mvista.com>
Date: Tue, 18 Sep 2007 19:01:29 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] [PATCH] PowerPC: Add 64-bit phys addr support to 32-bit pci.
References: <20070918144426.GA22102@ru.mvista.com>
	<2E339F78-F42B-4FCE-A97E-FFE9AE4C44F1@kernel.crashing.org>
In-Reply-To: <2E339F78-F42B-4FCE-A97E-FFE9AE4C44F1@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Sep 18, 2007, at 9:44 AM, Valentine Barshak wrote:
> 
>> Add 64-bit physical address support to PCI.
> 
> Can you expand on your commit message.  for example why do this? is it 
> address a bug fix, etc..
> 
>>
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>> ---
>>  arch/powerpc/kernel/iomap.c  |    4 +--
>>  arch/powerpc/kernel/pci_32.c |   56 
>> +++++++++++++++++++++++++++++--------------
>>  2 files changed, 41 insertions(+), 19 deletions(-)
> 
> - k
> 

Currently 32-bit pci code doesn't support 64-bit physical addresses.
We have to add 64-bit addr support in order to bring-up pci on PowerPC 
440. Actually, this refers to the conversation started here:

http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042267.html
Thanks,
Valentine.
