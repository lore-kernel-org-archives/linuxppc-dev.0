Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13441DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 14:04:37 +1100 (EST)
Message-Id: <46F4AA25-B5D1-42C1-B4EE-3EDE35D99782@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1234923772.14060.322.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Please pull from 'next' branch
Date: Tue, 17 Feb 2009 21:04:31 -0600
References: <Pine.LNX.4.64.0902171551460.23647@blarg.am.freescale.net>
	<1234923772.14060.322.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 17, 2009, at 8:22 PM, Benjamin Herrenschmidt wrote:

>
>> I'd also like the opcode patch to go in since several patches  
>> depend on
>> that (doorbell, tlbilx).  If you want to ack the patch I can put it  
>> into
>> my next branch for you.
>
> It's already in my test branch, which for some reason I forgot to push
> out... Doing some updates now, you'll get it.

ok. I was hoping for that one patch to migrate from test to next ;)

- k
