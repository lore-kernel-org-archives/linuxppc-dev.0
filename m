Return-Path: <graham@mknod.org>
Received: from mknod.org (mknod.org [66.101.58.166])
	by ozlabs.org (Postfix) with ESMTP id F143D67A46
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2005 05:29:57 +1000 (EST)
Date: Tue, 29 Mar 2005 13:07:03 -0600
From: Graham Wilson <graham@mknod.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050329190703.GA15755@mknod.org>
References: <1111964111.6099.19.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1111964111.6099.19.camel@gaston>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
Subject: Re: [PATCH] Fix sleep/wakeup problems on iBook G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 28, 2005 at 08:55:11AM +1000, Benjamin Herrenschmidt wrote:
> There have been various reports lately of sleep beeing broken on iBook
> G3. Frank (no name provided here) found a typo in my code that cleans
> the L1 cache on these CPU models. This patch fixes it, I'd appreciate
> some feedback about wether that fixes the problem or not.

I've been having various trouble with my iBook lately, including random
freezes, not waking up after going to sleep sometimes, and sometimes not
going to sleep. Since applying the patch you posted, everything seems
fine, though I may be speaking too soon.

My /proc/cpuinfo for reference:
 processor	: 0
 cpu		: 750FX
 temperature 	: 0-3 C (uncalibrated)
 clock		: 400MHz
 revision	: 2.3 (pvr 7000 0203)
 bogomips	: 793.71
 machine		: PowerBook4,3
 motherboard	: PowerBook4,3 MacRISC2 MacRISC Power Macintosh
 detected as	: 257 (iBook 2 rev. 2)
 pmac flags	: 0000001b
 L2 cache	: 512K unified
 memory		: 256MB
 pmac-generation	: NewWorld

Note that the maximum CPU speed is 900 MHz.

-- 
gram
