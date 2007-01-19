Return-Path: <Tom.Ziomek@motorola.com>
Received: from mail128.messagelabs.com (mail128.messagelabs.com
	[216.82.250.131]) by ozlabs.org (Postfix) with SMTP id 9FE88DDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 06:48:30 +1100 (EST)
Received: from il06exr02.mot.com (il06exr02.mot.com [129.188.137.132])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id l0JJmOHR018740
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 12:48:24 -0700 (MST)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by il06exr02.mot.com (8.13.1/8.13.0) with ESMTP id l0JJmNLa020492
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 13:48:24 -0600 (CST)
Date: Fri, 19 Jan 2007 13:48:22 -0600 (Central Standard Time)
From: T Ziomek <ctz001@email.mot.com>
To: Reyneke <reynekejunk@hotmail.com>
Subject: Re: Howto use PPC4xx memory to memory DMA
In-Reply-To: <BAY7-F166026572702AFA9F45B66BEA90@phx.gbl>
Message-ID: <Pine.WNT.4.61.0701191344190.2536@holyoke.labs.mot.com>
References: <BAY7-F166026572702AFA9F45B66BEA90@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: niklaus.giger@member.fsf.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 19 Jan 2007, - Reyneke wrote:
> Here are a few things to check:
>
> 1. Your memory destination and source addresses are contiguous. You can get 
> this using something like:
>
> mem = (void*)__get_free_pages(GFP_KERNEL | GFP_DMA, get_order(size));
>
> 2. Your source and dest addresses are _bus_ addresses. You can get these by:
>
> source = virt_to_bus((u32 *)mem);

The above contradicts an email by Ben H back on 22 Dec:
<http://ozlabs.org/pipermail/linuxppc-embedded/2006-December/025546.html>
But I don't know enough to resolve the conflict...

Tom
-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
