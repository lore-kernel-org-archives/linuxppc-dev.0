Date: Fri, 31 May 2002 14:31:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
Message-ID: <20020531043142.GE16537@zax>
References: <20020531042153.GD16537@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020531042153.GD16537@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 31, 2002 at 02:21:53PM +1000, David Gibson wrote:
>
> The patch below (against 2_4_devel) implements using large parge TLB
> entries to map kernel pages on the 40x.  paulus did the basic design,
> and I tweaked and degubbed it. It's a bit ugly in places (particularly
> the handling of iopa()) and will need cleaning up, but it does seem to
> work.

Oh, yeah, after applying the patch compile with CONFIG_PIN_TLB=n.  I'm
not sure how they'd interact, but probably not well.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
