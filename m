Return-Path: <anton@ozlabs.org>
Date: Wed, 17 Feb 2010 20:43:14 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH 6/6] powerpc: Use lwsync for acquire barrier if CPU
	supports it
Message-ID: <20100217094314.GC24270@kryten>
References: <20100210105728.GA3399@kryten> <20100210110236.GB3399@kryten>
	<20100210110306.GC3399@kryten> <20100210110406.GD3399@kryten>
	<20100210110719.GE3399@kryten> <20100210111025.GF3399@kryten>
	<20100211070914.GB6735@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100211070914.GB6735@laptop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi Nick,

> Ah, good to see this one come back. I also tested tbench over localhost
> btw which actually did show some speedup on the G5. 
> 
> BTW. this was the last thing left:
> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg29738.html
> 
> Don't know if you took a look at that again, but maybe it's worth
> looking at. Hmm, we do actually seem to be growing number of smp_mb*
> calls in core kernel too.

Interesting idea! I do worry we will get a late night visit from the
architecture police. From memory they want the complete larx, stcwx, bne,
isync sequence to guarantee an acquire barrier.

Anton
