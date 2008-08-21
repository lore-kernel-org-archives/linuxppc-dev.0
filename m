Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73B98DF150
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 00:20:50 +1000 (EST)
Message-Id: <C72E63F0-AF40-46F4-B910-59EE9AADC5B0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080821234935.33de917e.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] math-emu: Fix compiler warnings
Date: Thu, 21 Aug 2008 09:20:26 -0500
References: <1219323021-7273-1-git-send-email-galak@kernel.crashing.org>
	<20080821234935.33de917e.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 21, 2008, at 8:49 AM, Stephen Rothwell wrote:

> Hi Kumar,
>
> On Thu, 21 Aug 2008 07:50:20 -0500 Kumar Gala <galak@kernel.crashing.org 
> > wrote:
>>
>> Fix warnings of the form:
>> arch/powerpc/math-emu/fsubs.c:15: warning: 'R_f1' may be used  
>> uninitialized in this function
>> arch/powerpc/math-emu/fsubs.c:15: warning: 'R_f0' may be used  
>> uninitialized in this function
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>>
>> I intend these patches to go via the powerpc.git tree if no one has  
>> issues.
>>
>> - k
>>
>> include/math-emu/op-2.h |    2 +-
>
> Are you modifying the right file here?  There is also
> arch/powerpc/math-emu/op-2.h which contains the same construct.

I forgot to mention this is a precursor to moving arch/powerpc to  
using the generic math-emu code in include/math-emu/

I don't see any reason to fixup the old code.

- k
