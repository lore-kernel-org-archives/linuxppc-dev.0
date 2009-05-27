Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3FEA7DDFBD
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 08:12:10 +1000 (EST)
Message-Id: <E6F31282-646E-46B6-9D5B-B39D4595C984@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Ian Campbell <Ian.Campbell@eu.citrix.com>
In-Reply-To: <1243456159.4399.42.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
Date: Wed, 27 May 2009 17:11:57 -0500
References: <1242340949-16369-1-git-send-email-beckyb@kernel.crashing.org>
	<1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
	<20090519142656T.fujita.tomonori@lab.ntt.co.jp>
	<19E48A70-3332-423C-ACAD-390F940EE81C@kernel.crashing.org>
	<4A1592CF.8000208@goop.org>
	<E6DAA792-9923-4B76-9759-6955AABE3EAB@kernel.crashing.org>
	<1242990702.22654.253.camel@zakaz.uk.xensource.com>
	<0628DF07-E085-4CC8-ADFC-1B0798343159@kernel.crashing.org>
	<1243456159.4399.42.camel@localhost.localdomain>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 27, 2009, at 3:29 PM, Ian Campbell wrote:

> On Wed, 2009-05-27 at 15:05 -0400, Becky Bruce wrote:
>> On May 22, 2009, at 6:11 AM, Ian Campbell wrote:
>>>
>>>
>>> BTW do you need swiotlb_bus_to_virt to be __weak or is the fact that
>>> it
>>> is implemented in terms of swiotlb_bus_to_phys sufficient?
>>
>> The default one in swiotlb calls phys_to_virt on the result of
>> swiotlb_bus_to_phys, which only works on lowmem.
>
> Perhaps we can simply enhance the default one to handle highmem  
> instead
> of making it arch specific?

That's fine by me - as long as what I've got will work for you guys  
I'm happy to stick it in the standard one (inside a nice pretty #ifdef  
CONFIG_HIGHMEM, of course).

Cheers,
B
