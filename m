Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id B161567E9E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 01:13:43 +1000 (EST)
Date: Tue, 9 Aug 2005 10:13:33 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "Vikas Aggarwal" <va824363@albany.edu>
Message-Id: <20050809101333.62e1ef40.kim.phillips@freescale.com>
In-Reply-To: <24431.198.22.236.230.1123594721.squirrel@198.22.236.230>
References: <32704.198.22.236.230.1122651627.squirrel@198.22.236.230>
	<20050729153323.3f2c62ad.kim.phillips@freescale.com>
	<32798.24.92.61.26.1122694772.squirrel@24.92.61.26>
	<20050730183217.3310585b.kim.phillips@freescale.com>
	<33216.24.92.61.26.1122857296.squirrel@24.92.61.26>
	<20050801123728.62764c7e.kim.phillips@freescale.com>
	<53547.198.22.236.230.1122997515.squirrel@198.22.236.230>
	<20050803114749.739ae51e.kim.phillips@freescale.com>
	<30177.198.22.236.230.1123094006.squirrel@198.22.236.230>
	<20050803153540.3530e114.kim.phillips@freescale.com>
	<24431.198.22.236.230.1123594721.squirrel@198.22.236.230>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8248  SEC -- interrupt handler 'is' invoked
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 9 Aug 2005 09:38:41 -0400 (EDT)
"Vikas Aggarwal" <va824363@albany.edu> wrote:

> Does that still use the DMA if i bypass channel infrastructure.?

no.

> Do i have to  implement channel-infrastructure in software driver.

it depends on what you want the SEC to do.  If you only want RNG, then no, but if you want to use all the EU's at the same time, then you're probably better off fixing the channel error.

Have you been able to trace the register writes with a wrapper function?  No zero pointers being written to the SEC?  Also, on the 82xx, some bus errors get reported in the PQ2 SUI registers, so you might want to check them, too.

-- 
Kim
