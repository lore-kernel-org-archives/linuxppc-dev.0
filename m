Date: Mon, 3 Jun 2002 12:43:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Do we need tlbsx at finish_tlb_load?
Message-ID: <20020603024344.GA6765@zax>
References: <20020530080434.GY16537@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020530080434.GY16537@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 30, 2002 at 06:04:34PM +1000, David Gibson wrote:
> A question to Dan and Tom in particular:
>
> At the moment on 4xx, just after finish_tlb_load, which is called by
> both the TLB miss handlers, we do a tlbsx to see if an entry for this
> virtual address already exists.
>
> Since this code is only called from the TLB miss handler, I can't see
> how there could ever be a valid TLB entry present at this point.
> There is a comment claiming that this path can be hit under some
> circumstances, but it doesn't make sense to me.
>
> Is there any situation where we can reach this point with a valid TLB
> entry existing for the faulting address?

Ok, not seeing any replies here.  If no-one speaks up for this tlbsx
in the next couple of days, I'll remove it from 2_4_devel.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
