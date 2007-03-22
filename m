Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA757DDF22
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 01:46:45 +1100 (EST)
In-Reply-To: <1174573524.6595.509.camel@ld0161-tx32>
References: <1174573524.6595.509.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <30EF1C22-12B8-4236-8427-A78B3134F3BF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [Fwd: [PATCH Resend 01/02] Add Linux ASMP support for MPC8641D]
Date: Thu, 22 Mar 2007 09:46:08 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 22, 2007, at 9:25 AM, Jon Loeliger wrote:

> Kumar,
>
> As I indicated on IRC to you a few days ago, here is a copy
> of the Asymmetric Multi-Processor support patch for 8641 HPCN.
> For completeness and reference, the corresponding U-Boot patch
> will be posted to the U-Boot list as well.
>
> This patch is directly split in two due to apparently mailer
> issues with the full patch.  Apologies if you have received
> this patch twice.
>
> This is the first half of the patch, everything but the defconfig.
>
> Thanks,
> jdl

This isn't nearly as much change as I was expecting :)

Can you elaborate on what the changes to mpic and gfar are doing.

I assume that memory is split between the two cores.  So if you have  
512M of memory 0-256 is for core0 and 256-512 for core1, or do you  
handle this some other way (excluding the magic hw hack for exception  
vectors)?

thanks

- k
