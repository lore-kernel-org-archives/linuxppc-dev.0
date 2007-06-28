Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B0D8DDF55
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 12:10:00 +1000 (EST)
In-Reply-To: <20070628101401.6790aafd.sfr@canb.auug.org.au>
References: <11829683583721-git-send-email-galak@kernel.crashing.org>
	<11829683604166-git-send-email-galak@kernel.crashing.org>
	<11829683612573-git-send-email-galak@kernel.crashing.org>
	<11829683631074-git-send-email-galak@kernel.crashing.org>
	<11829683663762-git-send-email-galak@kernel.crashing.org>
	<20070628101401.6790aafd.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A5AD5E4E-BDDD-4B23-A70E-60F7891502A0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/8] [POWERPC] Use global_number in ppc32 pci_controller
Date: Wed, 27 Jun 2007 21:09:36 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 27, 2007, at 7:14 PM, Stephen Rothwell wrote:

> Hi Kumar,
>
> All this stuff looks good, thanks.
>
> On Wed, 27 Jun 2007 13:19:14 -0500 Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/ 
>> kernel/pci-common.c
>> new file mode 100644
>> index 0000000..3ca8cfb
>> --- /dev/null
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -0,0 +1,53 @@
>> +/*
>> + * Contains common pci routines for ALL ppc platform
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>
> This needs some copyright notice presumably based on the code you are
> moving to here.

Will do.  The ppc32 doesn't have anything.  The only copyright is on  
the ppc64 code for Anton.  Not really sure how to deal with 'Port for  
PPC64 David Engebretsen, IBM Corp.'  Suggestions?

- k
