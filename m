Return-Path: <martyn.welch@gefanuc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AA830B7B7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 19:25:24 +1000 (EST)
Received: from exprod5og111.obsmtp.com (exprod5og111.obsmtp.com [64.18.0.22])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A53DDDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 19:25:22 +1000 (EST)
Message-ID: <4A697E22.2080609@gefanuc.com>
Date: Fri, 24 Jul 2009 10:25:54 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/5] Generic NVRAM support for large MMIO devices
References: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<1248335077.3367.79.camel@pasglop>
In-Reply-To: <1248335077.3367.79.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2009-07-02 at 17:12 +0100, Martyn Welch wrote:
>   
>> The following series allows the generic NVRAM driver to access MMIO
>> based NVRAMs. In addition it enables support for NVRAMs of sizes
>> differing from those found on PowerPC Macs (providing a safe
>> fallback). Patches are also included to enable support for the NVRAM
>> found on the GE Fanuc PPC9A, SBC310 and SBC610.
>>
>> If this patch series is unsuitable this late in the day for 2.6.31,
>> please concider it for 2.6.32.
>>     
>
> No major issue with the series other than the change to the generic
> nvram code which needs to not break other architectures :-) Also,
> it will probably need to go through Andrew Morton, unless there's
> a maintainer for that driver, is there ?
>   
I'm not aware of a maintainer for the "generic nvram" driver. As 
mentioned in my other email, I'm fairly confident that this driver 
(/drivers/char/generic_nvram.c) is only used on PowerPC. I'm beginning 
to enter what is for me uncharted territory :-) How should I proceed? 
Are you happy to take the entire patch series, do I send the entire 
patch series to Andrew and LKML or just patch 2/5?

Martyn
> Once you sort out that aspect of the patch series, I'm happy to take
> the rest in powerpc.git
>
> Cheers,
> Ben.
>
>   


-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 927559189
