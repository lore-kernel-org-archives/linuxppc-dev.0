Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 13D212BF44
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Nov 2004 09:06:14 +1100 (EST)
Date: Wed, 10 Nov 2004 15:06:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <galak@somerset.sps.mot.com>
Message-ID: <20041110220608.GB26631@smtp.west.cox.net>
References: <Pine.LNX.4.61.0411092016370.16462@blarg.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0411092016370.16462@blarg.somerset.sps.mot.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][PPC32] Update cpu_spec for performance monitor counters,
	C99, and e500 userland CPU features
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 09, 2004 at 08:30:43PM -0600, Kumar Gala wrote:

> Andrew,
> 
> This patch replaces the previous patch for adding performance monitor 
> counters to cpu_spec.
> 
> -
> 
> Adds the number of performance monitor counters on each PowerPC processor 
> has to the cpu table.  Makes oprofile support a bit cleaner since we dont 
> need a case statement on processor version to determine the number of 
> counters.
> 
> Reformatted cpu_spec to use C99 initialization.
> 
> Added userland CPU features for SPE, Embedded Floating Point Single 
> precision, and Embedded Floating Point Double precision on e500.
> 
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com> 
[snip]

Now that we're doing C99 inits, can we just drop the empty fields
finally (And if __setup_cpu_8xx really is empty, just kill it) ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
