Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 576EF67BB7
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 00:18:17 +1000 (EST)
In-Reply-To: <453884F5.4000804@bplan-gmbh.de>
References: <453771E5.4090808@bplan-gmbh.de>
	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
	<453884F5.4000804@bplan-gmbh.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
Date: Fri, 20 Oct 2006 09:18:12 -0500
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


On Oct 20, 2006, at 3:12 AM, Nicolas DET wrote:

> Kumar Gala wrote:
> >
> > On Oct 19, 2006, at 7:39 AM, Nicolas DET wrote:
> >
> >> This 'big' patch adds support for CHRP/MPC52xx based platform.  
> Here, this is the bPlan's Efika computer (http://www.bplan-gmbh.de/ 
> efika_spec_en.html)
> >
>
> > Some high level comments:
> > 1. lets stick with the 52xx naming, instead of 5k2
>
> Ok. Will be done
>
> > 2. PIC code needs to be updated for new interrupt model (as well  
> as remove of pt_regs)
>
> Ok.
>
> > 3. use standard kernel debug macros
>
> Loads of changes in the pipe line ;-)
>
> > 4. look at replacing sram_allocator w/rheap
> >
>
> This SRAM allocator is the exact same from the original Linux one.  
> In fact, it is the original one. Would it be possible to accept  
> this code as it is and schedule rheap integration later ?

I dont follow, what do you mean by 'original Linux one' ?

> > if you repost the patch broken up into driver and platform bits  
> it will be easier to provide more detailed comments.
>
> Ok. I'm alraedy working on it since I post the first one :-) .  
> Thank you very much for your comments. I hope to re submit a much  
> better patch today.
>
> Regads
> <nd.vcf>
