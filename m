Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Remove bogus break statement 
In-Reply-To: Your message of "Thu, 28 Jun 2007 11:32:31 +1000."
	<20070628013231.GF15298@localhost.localdomain>
References: <20070628013231.GF15298@localhost.localdomain> 
Date: Mon, 02 Jul 2007 08:33:44 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1I5M2C-0005bM-M9@jdl.com>
Cc: linuxppc-dev@ozlabs.org, 5B@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> Commit 0738774fcc34b78a708a127fb4b2f193d08c94ba introduced some
> incorrect indentation / bracketing in unflatten_tree().  By luck, the
> extra break statement intended to be within an if block, but actually
> afterwards has no semantic effect.  Still, this patch gets rid of it
> for cleanliness.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
