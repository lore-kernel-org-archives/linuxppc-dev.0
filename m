Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 90E1767BDF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 09:04:53 +1000 (EST)
In-Reply-To: <1156371402.17977.21.camel@saruman.qstreams.net>
References: <1156371402.17977.21.camel@saruman.qstreams.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AB150E9C-6BB3-46C1-980D-311D3277BFC1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: CompactFlash on PQII Pro
Date: Wed, 23 Aug 2006 18:04:44 -0500
To: bwarren@qstreams.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 23, 2006, at 5:16 PM, Ben Warren wrote:

> Hello,
>
> I have a custom board where we've hung a CompactFlash on the local bus
> of an MPC8349 processor, intending to use it in 'True IDE' mode.  The
> closest thing I've found in the kernel tree is
> drivers/ide/ppc/ide-m8xx.c, although it's *very* possible I'm not
> looking in the right place.
>
> I believe my chip's local bus is similar to the 8xx, so making this
> driver work with my hardware doesn't seem like that big a deal.  I  
> fully
> expect to have to monkey with UPM timings among other things.  On the
> other hand, this seems like something other people would have done,
> maybe with one of the other PQ families like 82xx or 85xx.
>
> Does anyone have a patch, suggestions or flames they can throw my way?

I know I posted a patch for cf-ide.c to lkml some time ago, this was  
to do a CF in true ide mode using the 83xx localbus.

http://marc.theaimsgroup.com/?l=linux-kernel&m=113877891224982&w=2

We did some UPM setup in u-boot to use two CS on Localbus for this.

- kumar
