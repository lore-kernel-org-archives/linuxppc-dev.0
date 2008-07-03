Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35753DE12F
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 04:38:25 +1000 (EST)
Message-Id: <BE229B94-773D-4FA8-AFD0-E46F5887F8D3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40807031134s4ddd0cabj1b31d3ee2d9d2258@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: New fsl device bindings file
Date: Thu, 3 Jul 2008 13:38:17 -0500
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
	<486D1A58.8010403@freescale.com>
	<fa686aa40807031134s4ddd0cabj1b31d3ee2d9d2258@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 3, 2008, at 1:34 PM, Grant Likely wrote:

> On Thu, Jul 3, 2008 at 12:28 PM, Scott Wood  
> <scottwood@freescale.com> wrote:
>> Kumar Gala wrote:
>>>
>>> I'm sure you'll hate for doing this, but I've asked Kim to create  
>>> a new
>>> Documentation/powerpc/fsl-device-tree-bindings.txt as part of his  
>>> SEC patch.
>>>
>>> I'm going to move all the Freescale SoC related bindings into this  
>>> new
>>> file.  One of the aspects of the new file is we will NOT having an  
>>> ordinal
>>> heading index.
>
> Not at all.  This is much needed.  The current file is far to unwieldy
>
>>
>> How about splitting up like this:
>>
>> Documentation/powerpc/device-tree/fsl/cpm.txt
>> Documentation/powerpc/device-tree/fsl/cpm/uart.txt
>> Documentation/powerpc/device-tree/fsl/tsec.txt
>> Documentation/powerpc/device-tree/interrupts.txt
>> Documentation/powerpc/device-tree/dtb.txt
>
> May I suggest moving it to Documentation/of-bindings/ instead?  Some
> of these bindings (granted, not the fsl ones) will be used by
> non-powerpc platforms (sparc, microblaze).

I think the powerpc bindings should still be under Docs/powerpc/of- 
bindings/

It makes it cleaner in that each arch/sub-arch maintainer can maintain  
Docs/<arch>/of-bindings and we can all vet changes to Docs/of-bindings

- k
