Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9A195B70C8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 04:16:32 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E61A5DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 04:16:31 +1000 (EST)
Message-Id: <C1B3311B-B3D3-422A-A4DE-9A319AE90CDC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1244328124.31984.40.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [RFC][PATCH v5] MPC5121 TLB errata workaround
Date: Mon, 8 Jun 2009 13:16:16 -0500
References: <200903161652.09747.david.jander@protonic.nl>
	<20090606220723.A38DA832E416@gemini.denx.de>
	<1244328124.31984.40.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Jander <david.jander@protonic.nl>,
	Wolfgang Denk <wd@denx.de>, gunnar@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 6, 2009, at 5:42 PM, Benjamin Herrenschmidt wrote:

> On Sun, 2009-06-07 at 00:07 +0200, Wolfgang Denk wrote:
>> Dear David Jander,
>>
>> In message <200903161652.09747.david.jander@protonic.nl> you wrote:
>>> Complete workaround for DTLB errata in e300c2/c3/c4 processors.
>>>
>>> Due to the bug, the hardware-implemented LRU algorythm always goes  
>>> to way
>>> 1 of the TLB. This fix implements the proposed software workaround  
>>> in
>>> form of a LRW table for chosing the TLB-way.
>>>
>>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>>> Signed-off-by: David Jander <david@protonic.nl>
>>
>> What is the actual status of this patch?
>>
>> Patchwork (http://patchwork.ozlabs.org/patch/24502/) says it's
>> "superseded" - but by what?
>>
>> I can't see such code in mainline - what happened to it?
>
> I can see the code in mainline ... but only in the -data- TLB miss
> handler, not the instruction one...
>
> Kumar ? Shouldn't we have the workaround in both ?

The errata was only for the d-side.  The patch is in the mainline  
kernel.

- k
