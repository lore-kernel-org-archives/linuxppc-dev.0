Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C9AADDF91
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 05:14:08 +1000 (EST)
In-Reply-To: <20071009135235.1026bb23@vader.jdub.homelinux.org>
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
	<470AA224.7050709@freescale.com>
	<20071009030729.GI12499@localhost.localdomain>
	<470BA6ED.3020504@freescale.com>
	<20071009135235.1026bb23@vader.jdub.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <25EEFA45-3488-4BE1-9DE8-9037946E3F0B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Build failure on treeboot-walnut.cg
Date: Tue, 9 Oct 2007 14:14:05 -0500
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Timur Tabi <timur@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 9, 2007, at 1:52 PM, Josh Boyer wrote:

> On Tue, 09 Oct 2007 11:06:05 -0500
> Timur Tabi <timur@freescale.com> wrote:
>
>> David Gibson wrote:
>>
>>> Policy.  Compiling everything means build bugs - like this one - can
>>> be found by everybody, not just those building for the specific
>>> obscure platform.
>>
>> Is this a new policy?  Modules in the kernel are not built unless  
>> you want
>> them.  Even in arch/powerpc/platforms, only the specific platform  
>> file I'm
>> targeting is built.  So I don't really understand why you claim  
>> it's normal
>> for platform-specific files to be built, regardless of the actual  
>> platform.
>>
>> And frankly, I don't like this "policy".  Build bugs for 4xx  
>> should not
>> interfere in my 83xx development.  I can't build any kernels now  
>> because of
>> this bug!
>
> I fixed this bug.  It should be in Paul's latest tree.  You seem to be
> having a different issue with your binutils though.

Just to clarify this is an issue with the particular patched binutils  
Timur is using.

I'll leave it to you guys to fight over if we should be building  
everything or not.

- k
