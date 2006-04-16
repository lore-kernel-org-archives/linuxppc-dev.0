Return-Path: <kernel@andred.net>
Received: from andred.net (sushi.andred.net [217.160.180.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 633FE679E7
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Apr 2006 11:32:38 +1000 (EST)
Message-ID: <44419EAC.3070302@andred.net>
Date: Sun, 16 Apr 2006 03:32:28 +0200
From: Andre Draszik <kernel@andred.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Slab errors on 4xx (STB04)
References: <44398BD4.60904@andred.net>
	<20060410071457.GA16898@gate.ebshome.net>
	<443AB696.7080205@andred.net>
In-Reply-To: <443AB696.7080205@andred.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Andre Draszik wrote:
> Eugene Surovegin wrote:
>> You can try changing __dma_sync() to do flush_dcache_range() even for 
>> DMA_FROM_DEVICE case. However, do this only to check this theory, not 
>> as a permanent solution :).
> 
> OK, I will play with the cache later today... I wanted DEBUG_SLAB turned
> on for some other unrelated problem, so just for debugging, this hack
> would be fine if it worked :)

Eugene, your workaround works, thx!

Andre'
