Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A9F0DE046
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 02:05:05 +1000 (EST)
Message-Id: <4A56CEAC-E3B3-49BC-953D-A457C7E919D1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20080513193350.8B90C26F8D4@magilla.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: how to check for "optional" ppc chip features (MSR_BE)
Date: Wed, 11 Jun 2008 11:05:00 -0500
References: <20080502012118.96ED926FA07@magilla.localdomain>
	<DC173CDE-FBC4-4EA0-8022-3F993B6466BF@kernel.crashing.org>
	<1209937549.21644.2.camel@pasglop>
	<20080504231207.8377E26FA08@magilla.localdomain>
	<18473.33194.781010.826872@cargo.ozlabs.ibm.com>
	<20080513193350.8B90C26F8D4@magilla.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 13, 2008, at 2:33 PM, Roland McGrath wrote:

>> So it looks like we need to define a new feature bit to mean  
>> "supports
>> block-step".  Is this something that userspace will expect to be told
>> about via the AT_HWCAP entry in the aux vector?
>
> I don't care to have userland know about it.  I'm just concerned  
> with the
> arch_has_block_step() definition being right.  But, you did  
> previously tell
> me that userland can set its own MSR_SE via sigreturn or setcontext or
> something.  If it can set its own MSR_BE the same way, then perhaps
> userland wants to know.

Did we close on this, I'm going to test Roland's patch on book-e and  
will post results.

- k
