Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 9692A67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 03:35:23 +1100 (EST)
Date: Fri, 4 Mar 2005 09:35:16 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050304093515.A4471@cox.net>
References: <42282C83.9040707@jp.fujitsu.com>
	<baf2848b8e77015677749f9c4b90f73a@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <baf2848b8e77015677749f9c4b90f73a@freescale.com>;
	from kumar.gala@freescale.com on Fri, Mar 04, 2005 at 10:02:40AM
	-0600
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] WDT Driver for Book-E [2/2] Device driver part.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Mar 04, 2005 at 10:02:40AM -0600, Kumar Gala wrote:
> Matt,
> 
> Do you think this really needs a config option?  Should it not be  
> sufficient that if you enable watchdog you get this functionality on  
> 4xx/e500?

I see the 8xx example, however, there may be a case where somebody
wants to use another hardware watchdog mechanism.  In that case,
they probably don't want this facility automagically being enabled.
I think having the option can't hurt.

-Matt
