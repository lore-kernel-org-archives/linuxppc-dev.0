Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 88EC367A6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 02:21:04 +1100 (EST)
Date: Thu, 3 Mar 2005 08:20:44 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050303082044.A7915@cox.net>
References: <4226FF62.30007@jp.fujitsu.com>
	<c56d8feba0d803d74d77ab20f54287e9@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c56d8feba0d803d74d77ab20f54287e9@freescale.com>;
	from kumar.gala@freescale.com on Thu, Mar 03, 2005 at 08:53:15AM
	-0600
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

On Thu, Mar 03, 2005 at 08:53:15AM -0600, Kumar Gala wrote:
> One thing the code needs is a general name cleanup.  Its just confusing 
> to me for e500 to have 4xx references.

I suggest booke_wdt* since the Book E spec is where this feature
came from.

Since you already picked up the bug-fix patch, we just need a two
part patch with the name cleanup where 1) arch-specific code
2) driver portion.

-Matt
