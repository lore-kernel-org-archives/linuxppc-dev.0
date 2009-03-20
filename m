Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 718F1DDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 06:33:35 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LkkTD-0007Ht-7M
	for linuxppc-dev@ozlabs.org; Fri, 20 Mar 2009 12:33:31 -0700
Message-ID: <22627440.post@talk.nabble.com>
Date: Fri, 20 Mar 2009 12:33:31 -0700 (PDT)
From: davidastro <davidastro@hotmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Fix for __div64_32 locks when using some 64 bit numbers
In-Reply-To: <1237330984.25062.164.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <22567864.post@talk.nabble.com>
	<1237330984.25062.164.camel@pasglop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Ben:

I was wondering if you have any change to look into and test the propose fix
I suggested in my previous post.
I'd like to know if the fix is correct.

Thanks for your attention,


Benjamin Herrenschmidt wrote:
> 
> On Tue, 2009-03-17 at 14:15 -0700, davidastro wrote:
>> I found a bug when using the function __div64_32 in assembly in a 32 bit
>> ppc
>> architecture unit.
>> 
>> I tried the numbers 55834565048000000 for the dividend and 4294967079 for
>> the divisor. When passing these two numbers to the function  __div64_32,
>> I
>> had a software lock. I searched for possible patches online and in
>> different
>> forums but I could not find anything related to the assembly
>> implementation
>> to this function (I would have to apologize if somebody already found a
>> fix
>> :-) ).
>> 
>> Anyway, when analyzing the assembly code, I found out with gdb the
>> problem.
>> I am not an expert in ppc architecture but I read the documentation and I
>> am
>> pretty sure I solved the issue (I have been testing for couple of days
>> using
>> random 64 to 32 number combinations with good results).
>> 
>> Who or Where should I post the fix to be reviewed.
> 
> Here is fine :-)
> 
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/Fix-for-__div64_32-locks-when-using-some-64-bit-numbers-tp22567864p22627440.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
