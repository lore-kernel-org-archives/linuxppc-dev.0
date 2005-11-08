Return-Path: <mguertin@macdiscussion.com>
Received: from lax.l-calh-stingco.net (lax.l-calh-stingco.net [70.85.101.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E309B6867C
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2005 13:08:18 +1100 (EST)
In-Reply-To: <17263.58185.110462.536522@cargo.ozlabs.ibm.com>
References: <1131264050.10031.265.camel@baythorne.infradead.org>
	<17261.57380.473046.69200@cargo.ozlabs.ibm.com>
	<1131356850.27347.17.camel@baythorne.infradead.org>
	<17263.58185.110462.536522@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4F4652E5-1977-47E8-B301-B143B9393348@macdiscussion.com>
From: Mark Guertin <mguertin@macdiscussion.com>
Date: Mon, 7 Nov 2005 20:38:31 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Fix ppc32 smp build.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7-Nov-05, at 6:29 PM, Paul Mackerras wrote:

> David Woodhouse writes:
>
>> We make no attempt to sync the timebases on quad powersurge, as  
>> far as I
>> can tell -- and we never set smp_tb_synchronized there.
>
> Hmmm.  Does anyone still have one of those?  I have a dual but not a
> quad.
>

I have one that is collecting dust currently.  I'd be willing to get  
it to someone that can work with it for the cost of shipping (not  
cheap, it's heavy).  Even has an RJ45 jack on the CPU card -- most  
I've seen don't.  Or if there's someone in the Toronto area that  
wants to pick it up is fine too, as long as it goes to a good home to  
help kernel development :)

Mark
