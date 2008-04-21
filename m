Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20AA6DE71D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 01:25:15 +1000 (EST)
Message-Id: <5422E8EE-4AFA-491B-8920-BDEBF596FF00@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40804191114i2cef26eegabfe9bc28d8ecc18@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [PPC] Remove mpc8272 ads board from arch/ppc
Date: Mon, 21 Apr 2008 10:25:09 -0500
References: <Pine.LNX.4.64.0804191051420.20132@blarg.am.freescale.net>
	<fa686aa40804191114i2cef26eegabfe9bc28d8ecc18@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 19, 2008, at 1:14 PM, Grant Likely wrote:
> On Sat, Apr 19, 2008 at 9:52 AM, Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>> We have a board port in arch/powerpc so we dont need this one  
>> anymore.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> Personally, I'd rather not do the piecemeal removal of board ports
> from arch/ppc.  We've only got one release left anyway.  Removing them
> just generates more churn and has the risk of causing other side
> effects.

I can understand it, but I think removing them makes it obvious to  
anyone that's lurking.  Call in maintainer prerogative :)

- k
