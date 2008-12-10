Return-Path: <monstr@seznam.cz>
Received: from smtp.seznam.cz (smtp.seznam.cz [77.75.72.43])
	by ozlabs.org (Postfix) with ESMTP id 647E7474D4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Dec 2008 03:34:54 +1100 (EST)
Message-ID: <493FEFA7.9050703@seznam.cz>
Date: Wed, 10 Dec 2008 17:34:47 +0100
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net>
	<493D2B22.4000601@seznam.cz>	<493ED4B6.7010605@dlasys.net>
	<493F89F2.60702@seznam.cz>	<87iqpsme9j.fsf@macbook.be.48ers.dk>
	<493FD3EC.3060305@seznam.cz> <87wse8m6p0.fsf@macbook.be.48ers.dk>
In-Reply-To: <87wse8m6p0.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dhlii@dlasys.net, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: monstr@seznam.cz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Peter,

>>>>>> "Michal" == Michal Simek <monstr@seznam.cz> writes:
> 
> Hi,
> 
>  >> Why? Have you swapped your A0 / A1?
> 
>  Michal> I found that ml40x designs have different connection that
>  Michal> ml505 usb design. This is no problem for me. But I think that
>  Michal> in David case is that problem.
> 
> OK. If this is something common, then maybe we should add support for
> it in the driver?

I think this is not necessary. Swapped A0/A1 is hw solution. And change which I
described is sw solution.

>  Michal> We used 2.6.20 kernel because we have this kernel well tested.
>  Michal> I found where the problem was.
> 
> Ahh, what was it?

Problem was in different status handling for older kernel and I extend some
timeout value before. I am reverting my debug messages. Maybe I did any other
change which do some work too.

Thanks,
Michal

> 
>  Michal> Thanks for your driver and help,
> 
> You're welcome.
> 
