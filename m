Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 9B4CD67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 04:12:29 +1100 (EST)
Date: Thu, 3 Mar 2005 10:11:46 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Takeharu KATO <takeharu1219@ybb.ne.jp>
Message-ID: <20050303101146.A8869@cox.net>
References: <4226FF62.30007@jp.fujitsu.com>
	<c56d8feba0d803d74d77ab20f54287e9@freescale.com>
	<42272B69.8000303@ybb.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42272B69.8000303@ybb.ne.jp>;
	from takeharu1219@ybb.ne.jp on Fri, Mar 04, 2005 at 12:21:13AM
	+0900
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: PowerPC4xx Watchdog
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Mar 04, 2005 at 12:21:13AM +0900, Takeharu KATO wrote:
> Hi Kumar,
> 
> Thank you for your suggestion.
> Kumar Gala wrote:
> > One thing the code needs is a general name cleanup.  Its just confusing 
> > to me for e500 to have 4xx references.
> > 
> How about the use of booke instead of 4xx?

Yes, please. :)

> I seem to use ``booke'' for common name for them like 
> arch/ppc/kernel/head_booke.h in the kernel source.
> 
> Strictly speaking, PowerPC4xx series may not be called booke.
> But I think that it is more preferable than current name.

440 is strictly Book E, 405 is a hybrid that pulled borrowed
from Green book and Book E.

-Matt
