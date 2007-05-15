Return-Path: <dgibson@ozlabs.org>
Date: Tue, 15 May 2007 10:26:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Fix bug adding properties with flatdevtree.c's ft_set_prop()
Message-ID: <20070515002648.GA31585@localhost.localdomain>
References: <20070514031357.GM6517@localhost.localdomain>
	<20070514162816.GB371@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070514162816.GB371@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 11:28:16AM -0500, Scott Wood wrote:
> On Mon, May 14, 2007 at 01:13:57PM +1000, David Gibson wrote:
> > This patch corrects ft_set_prop() so that it adds new properties
> > before the first subnode, instead of before the END_NODE tag.
> 
> Is there any reason not to just insert at the beginning of the node?

Only that we have to search through the node first to see if the
property already exists, so we've already reached the end by the time
we know we need to insert.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
