Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 60273DDE18
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 03:12:42 +1000 (EST)
Message-ID: <4720CE3E.5030204@ru.mvista.com>
Date: Thu, 25 Oct 2007 21:11:26 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [linux-usb-devel] [PATCH 1/2] USB: Rework OHCI PPC OF for new
	bindings
References: <20071024163412.GA17785@ru.mvista.com>	
	<471FC191.6020704@genesi-usa.com>	
	<200710241850.05467.david-b@pacbell.net>	
	<fa686aa40710241941w16fe3e75hb8ede9f9c8464e94@mail.gmail.com>	
	<47208273.8050601@ru.mvista.com>
	<fa686aa40710250721m54dda956qe7c8986416d0dfa2@mail.gmail.com>
In-Reply-To: <fa686aa40710250721m54dda956qe7c8986416d0dfa2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: David Brownell <david-b@pacbell.net>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 10/25/07, Valentine Barshak <vbarshak@ru.mvista.com> wrote:
>> Grant Likely wrote:
>>> On 10/24/07, David Brownell <david-b@pacbell.net> wrote:
>>>> On Wednesday 24 October 2007, Matt Sealey wrote:
>>>>> Can we just make sure real quickly that the changing of compatibles
>>>>> doesn't break existing, not-easily-flashable firmwares?
>>>> Yeah, I'm not keen on such breakage either...
>>> Add my voice to the chorus.  It's okay to change the binding, but make
>>> sure the old binding is still supported.
>>>
>>> Cheers,
>>> g.
>>>
>> Actually, I thought that changing the DTS stuff for mpc52xx boards would
>> suffice. Sorry, I was unaware of Efika firmware here. I'll keep old
>> bindings as well.
> 
> Even if that were the case; I'm nervous about breaking compatibility
> with old device trees.

If we keep the old bindings intact in the driver code then the old dts 
files should work fine. But I'm starting to doubt we really need any new 
bindings for this if we still have to keep the old ones.
BTW, does anybody know of any ohci-le devices on OF bus?
Thanks,
Valentine.

> 
> We probably need a formal guideline here.  ie. When is it okay to drop
> compatibility with old dts files?
> 
>> Does the device tree have "ohci-bigendian" or "ohci-be" compatible
>> property on Efika?
> 
> If it doesn't, it can be added during prom_init.c  We're already doing
> a bunch of efika fixups there anyway.
> 
> Cheers,
> g.
> 
