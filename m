Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jan 2008 15:05:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [DTC PATCH 2/2] Preserve scanner state when /include/ing.
Message-ID: <20080110040517.GA19088@localhost.localdomain>
References: <20080107202751.GB17782@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080107202751.GB17782@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 07, 2008 at 02:27:51PM -0600, Scott Wood wrote:
> This allows /include/s to work when in non-default states,
> such as PROPNODECHAR.
> 
> We may want to use state stacks to get rid of BEGIN_DEFAULT() altogether...

And we should, if we're going to go to stacked states at all.  I was
anticipating we might need to use stacked states for handling
propnamestate as we need expression support.  I just hadn't realised
we already needed it for includes.


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
