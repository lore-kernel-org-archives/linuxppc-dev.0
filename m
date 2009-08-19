Return-Path: <beckyb@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ED2DEB707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 07:00:01 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B87BDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 07:00:00 +1000 (EST)
Message-Id: <16251558-DDF6-46C3-98C2-2FC7CD8A398B@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1250634800.4810.1.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH/RFC] powerpc/mm: Cleanup handling of execute permission
Date: Wed, 19 Aug 2009 15:59:39 -0500
References: <1248766373.30993.50.camel@pasglop>
	<FBB5798A-EE85-4B18-8883-F6182B203996@kernel.crashing.org>
	<20090818205621.GB2530@zod.rchland.ibm.com>
	<1250634800.4810.1.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 18, 2009, at 5:33 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2009-08-18 at 16:56 -0400, Josh Boyer wrote:
>> On Fri, Aug 14, 2009 at 05:39:42PM -0500, Becky Bruce wrote:
>>> Ben,
>>>
>>> This breaks the boot on 8572.  I don't know why yet (and I'm  
>>> probably
>>> not going to figure it out before I go home, because, frankly,  
>>> it's late
>>> on a Friday afternoon and I need a glass of wine or, perhaps, a  
>>> beer).
>>>
>>> Kumar and I will poke into this more and let you know what we find  
>>> out -
>>> in the meantime, if you have any brilliant flashes, pony up!
>>
>> I tested this on a 440EPx NFS rootfs boot too.  It doesn't cause  
>> init itself
>> to crap out with a SIGILL like Becky's board, but it does do weird  
>> things
>> and cause a SIGILL elsewhere during my boot.
>>
>> Reverting this patch from your testing branch allows things to work  
>> just fine.
>
> Becky found my thinko, I'll send a new patch later today.

Ben,

FYI, I pulled your updated test branch this morning, booted, and did a  
full LTP run on 8572.  The results are consistent with the baseline I  
have, so it looks like the issue is properly fixed.

-Becky
