Return-Path: <hollis@penguinppc.org>
Received: from smtpauth10.mail.atl.earthlink.net
	(smtpauth10.mail.atl.earthlink.net [209.86.89.70])
	by ozlabs.org (Postfix) with ESMTP id 9C9266876B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2005 02:30:14 +1100 (EST)
In-Reply-To: <20051118074237.GA14865@suse.de>
References: <20051117210902.GB31775@suse.de>
	<437D0A21.4090803@smiths-aerospace.com>
	<20051118074237.GA14865@suse.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <322e5a1c14e0e7a08d88868f23ec7c73@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Fri, 18 Nov 2005 09:30:03 -0600
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc boot: replace string labels with numbers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 18, 2005, at 1:42 AM, Olaf Hering wrote:

>  On Thu, Nov 17, Jerry Van Baren wrote:
>
>> While I'm being dumb, I gotta ask, how big is zImage and why does 117
>> bytes make a difference?
>
> Because we can.
>
>> My 2c: if you are going to use inscrutable labels (1,2,3,4), please 
>> put
>> comments in.  At least the previous labels gave hints as to what was
>> happening.
>
> The code should be obvious.

I hope the above was a joke, Olaf.

I too am wondering where the savings come from. Regardless, IMHO 117 
bytes is not a worthwhile tradeoff for less maintainable assembly.

BTW, Jerry, the size of the instructions themselves will not change. I 
suspect the savings is from things like the symbol table, but I can't 
replicate it with a simple "hello world" testcase.

-Hollis
