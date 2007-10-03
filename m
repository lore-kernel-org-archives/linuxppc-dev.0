Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3314EDDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Oct 2007 06:50:03 +1000 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0371EFE9@ismail.innsys.innovsys.com>
References: <20071003190140.GA19169@xyzzy.farnsworth.org>
	<DCEAAC0833DD314AB0B58112AD99B93B0371EFE9@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0B763FCF-9EFD-48E5-B2D9-53EAB0396522@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] PPC 85xx failure with odd memory sizes and CONFIG_HIGHMEM
Date: Wed, 3 Oct 2007 15:49:43 -0500
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 3, 2007, at 2:34 PM, Rune Torgersen wrote:

>> From: Dale Farnsworth
>>
>> The CONFIG_FSL_BOOKE mmu setup code fails when CONFIG_HIGHMEM=y
>> and the 3 fixed TLB entries cannot exactly map the lowmem size.
>> Each TLB entry can map 4MB, 16MB, 64MB or 256MB, so the failure
>> is observed when the kernel lowmem size is not equal to the
>> sum of up to 3 of those values.
>
> Does this mean you cannot run 1G of lowmem on a 85xx?
>
> On 82xx I run 1G of lowmem, and when we finaly upgrade our product  
> to a
> 85xx something, Iw was planning on doing the same.

The code would have to change to allow for 1G of lowmem.

Max lowmem with KERNELBASE @ 0xc000_0000 is 768M.

- k
