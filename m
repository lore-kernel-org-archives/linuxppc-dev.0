Return-Path: <graham@mknod.org>
Received: from mknod.org (mknod.org [66.101.58.166])
	by ozlabs.org (Postfix) with ESMTP id 0884667A6D
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2005 08:45:57 +1000 (EST)
Date: Tue, 29 Mar 2005 16:45:54 -0600
From: Graham Wilson <graham@mknod.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050329224554.GA17057@mknod.org>
References: <1111964111.6099.19.camel@gaston>
	<20050329190703.GA15755@mknod.org>
	<1112133877.6577.35.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112133877.6577.35.camel@gaston>
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

On Wed, Mar 30, 2005 at 08:04:37AM +1000, Benjamin Herrenschmidt wrote:
> > I've been having various trouble with my iBook lately, including random
> > freezes, not waking up after going to sleep sometimes, and sometimes not
> > going to sleep. Since applying the patch you posted, everything seems
> > fine, though I may be speaking too soon.
> 
> Can you also check my other patch which fixes cpufreq as well ? And test
> if it's reliable wether you sleep at low or high speed ?

I haven't had any trouble with cpufreq (and I use powernowd with the
userspace governor), but I will apply your other patch this evening and
see what happens.

-- 
gram
