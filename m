Return-Path: <kenneth@southpole.se>
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id 52C7EB7BDE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 01:51:05 +1100 (EST)
Subject: Re: Acceleration for map_copy_from on powerpc 512x
From: Kenneth Johansson <kenneth@southpole.se>
To: Fortini Matteo <matteo.fortini@mta.it>
In-Reply-To: <4ADC1AAD.60606@mta.it>
References: <4ADC1AAD.60606@mta.it>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 21 Oct 2009 16:30:53 +0200
Message-Id: <1256135453.22238.27.camel@kenjo-laptop>
Mime-Version: 1.0
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-10-19 at 09:52 +0200, Fortini Matteo wrote:

> I didn't find a cleaner way than just #ifdef'ing the map_copy_from call 
> and substitute with my call on relevant cases. I wonder if there is a 
> cleaner way.

Remove the call to simple_map_init() and do it manually in your driver
with your own functions.

> And yes, as soon as I've cleaned up the code a little bit, I will 
> definitely post a patch about it.
> 
> Moreover: a huge benefit would come from exploiting DMA on these 
> transfers, 

probably depends on the block size if it's a gain or not. What is the
size you normally see. 
