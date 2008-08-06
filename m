Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 7205DDDDEC
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 12:34:56 +1000 (EST)
Message-ID: <48990D0F.6050909@hypersurf.com>
Date: Tue, 05 Aug 2008 19:31:43 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: inline assembly & r0 SOS
References: <4898EE60.9080206@hypersurf.com> <200808061041.50577.jk@ozlabs.org>
In-Reply-To: <200808061041.50577.jk@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeremy Kerr wrote:
> Hi Kevin,
> 
> 
>>         /*
>>          * Turn r3 (range) into a rotate count for the selected
>>range. * 0 -> 23, 1 -> 31
>>          */
>>         __asm__ __volatile__ (  "slwi %0,%0,3\n"
>>                                 "addi %0,%0,23\n"
>>                                 "rlwnm %0,%1,%0,30,31\n":
>>                 "=r"(ret):
>>                 "r"(config),"0"(range)
>>         );
> 
> 
> Wouldn't this be much simpler in plain C?
> 
I just knew someone was gonna try to rain on my rlwnm'in fun parade! 
Wonder if the C code can be made to compile down to 3 instructions?

> However, if you really do need to do this in inline asm, you can use 
> the "b" modifier rather than "r" to avoid using r0.
> 
Oh cool! Thanks! You to Ben!

> Cheers,
> 
> 
> Jeremy
> 

kevin
