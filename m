Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 632A7DDE26
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jan 2008 10:05:38 +1100 (EST)
Message-Id: <041B1E64-51C3-414A-AC1B-0C4E2114BC24@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1200089015.6896.56.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: RFC: Only deal with apple fix if res is memory
Date: Sat, 12 Jan 2008 17:05:26 -0600
References: <Pine.LNX.4.64.0801111038380.17281@blarg.am.freescale.net>
	<1200089015.6896.56.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 11, 2008, at 4:03 PM, Benjamin Herrenschmidt wrote:

>
> On Fri, 2008-01-11 at 10:38 -0600, Kumar Gala wrote:
>> Ben,
>>
>> Will this impact the apple fix?  I'm getting some _IO cases hitting  
>> this.
>
> No, your fix is right, it's a bug to compare against pci_mem_offset  
> and
> not check if it's a memory resource in the first place. I would  
> suggest
> that you do the res->flags test first in the if () statement for  
> clarity
> though.

ok, will clean up the patch and resend.

- k
