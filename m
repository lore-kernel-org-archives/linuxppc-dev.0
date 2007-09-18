Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99A9ADDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 02:19:03 +1000 (EST)
In-Reply-To: <20070918152302.GB788@ld0162-tx32.am.freescale.net>
References: <20070917165746.GP6563@loki.buserror.net>
	<58472170-34D3-43F4-A816-87AF0020A086@kernel.crashing.org>
	<20070918151147.GB736@ld0162-tx32.am.freescale.net>
	<027F3363-3154-4A16-A251-C56D8DC339A1@kernel.crashing.org>
	<20070918152302.GB788@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B8233543-C036-47F8-BB8B-EB0EF3AED256@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 16/28] 8xx: Don't call non-existent Soft_emulate_8xx from
	SoftwareEmulation.
Date: Tue, 18 Sep 2007 11:21:59 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 18, 2007, at 10:23 AM, Scott Wood wrote:

> On Tue, Sep 18, 2007 at 10:19:05AM -0500, Kumar Gala wrote:
>> Mainly that 8xx has been doing this for a vast number of years and I
>> see no reason to stop doing it at this point.
>>
>> While I can see that it might be misleading, clearly 8xx linux users
>> haven't had issues with it.
>
> Or they haven't said anything. :-P

:)

> How about a three-way choice of full emulation, minimal emulation,  
> and no
> emulation?

I think I'd be ok with that.

- k
