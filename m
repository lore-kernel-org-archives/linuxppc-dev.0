Return-Path: <dgibson@ozlabs.org>
Date: Sat, 20 Oct 2007 19:06:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 3/4] DTC: Appease the printf() format $Gods with a correct
	type.
Message-ID: <20071020090633.GH26642@localhost.localdomain>
References: <E1IivsP-00078Q-Hf@jdl.com>
	<20071020071920.GF26642@localhost.localdomain>
	<jesl46yxri.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <jesl46yxri.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 20, 2007 at 10:51:29AM +0200, Andreas Schwab wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
> 
> > What compiler/platform is this?  I can't off the top of my head think
> > of one where size_t shouldn't be promoted to int automatically.
> 
> Only types narrower than int are subject to integer promotion.

Duh, yes.  Sorry.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
