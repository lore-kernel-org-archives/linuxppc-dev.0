Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 2C5AC67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Mar 2005 16:53:24 +1100 (EST)
In-Reply-To: <1111523269.2987.58.camel@ad.doubleclick.net>
References: <1111523269.2987.58.camel@ad.doubleclick.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9b9c4447ceb975b7b6dd1498ec686e41@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 22 Mar 2005 23:53:24 -0600
To: "Jason McMullan" <jason.mcmullan@timesys.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] CPM2 cleanups
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Some additional comments:

* Did you actually try setting CPM_IRQ_OFFSET to a non-zero value?  I'm 
guessing this doesnt work since you are not offset the irq passed into 
the other functions.  For example, if CPM_IRQ_OFFSET is 64, will 
cpm2_mask_irq() work?

* what is SA_NOTHREAD all about?

- kumar

On Mar 22, 2005, at 2:27 PM, Jason McMullan wrote:

> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> Date: March 22, 2005 2:28:51 PM CST
> Subject:
>
>
>
> Date: March 22, 2005 2:28:51 PM CST
> Subject:
>
>
> <ATT128341.txt><cpu-ppc-cpm2.patch>
>
> <signature.asc>
>
