Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C89967BAD
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 00:34:39 +1000 (EST)
In-Reply-To: <4538DC0B.7060402@bplan-gmbh.de>
References: <453771E5.4090808@bplan-gmbh.de>
	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
	<453884F5.4000804@bplan-gmbh.de>
	<122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>
	<4538DC0B.7060402@bplan-gmbh.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6B8FAF75-44DF-4638-BD7D-AF6BB063F339@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
Date: Fri, 20 Oct 2006 09:34:34 -0500
To: Nicolas DET <nd@bplan-gmbh.de>
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com, sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 20, 2006, at 9:24 AM, Nicolas DET wrote:

> Kumar Gala wrote:
>
> >>
> >> > 4. look at replacing sram_allocator w/rheap
> >> >
> >>
> >> This SRAM allocator is the exact same from the original Linux  
> one. In
> >> fact, it is the original one. Would it be possible to accept  
> this code
> >> as it is and schedule rheap integration later ?
> >
> > I dont follow, what do you mean by 'original Linux one' ?
>
> There are already some kind of Bestcomm DMA engine supoprt for some  
> embbeded system (ARCH=ppc). In order to speed up the developement,  
> the API is (almost) compatible so we can use the drivers wrote for  
> this API. For example, the Ethernet driver enterily rely on this  
> API. However, the 'soon to be release' ATA driver has been rewritten.
>
> I did not at the time (yet) to look at rheap, but I know the  
> current allocator is not really good (it can not free!).
>
> I was just thinking, as this code is alraedy in some Linux tree, we  
> could still use it there, and plan to replace it by a much better  
> one (keeping the API compatible) later on.

Is this in the kernel tree already, I am not coming across it.

- k
