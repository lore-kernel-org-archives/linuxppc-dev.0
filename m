Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id 2EF76DDEDE
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 02:55:52 +1000 (EST)
Date: Wed, 17 Oct 2007 18:55:49 +0200
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] bestcomm: Restrict disabling of bus prefetch to original
	mpc5200 silicon.
Message-ID: <20071017165549.GA16354@powerlinux.fr>
References: <20071017163555.24992.40095.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071017163555.24992.40095.stgit@trillian.cg.shawcable.net>
From: Sven Luther <sven@powerlinux.fr>
Cc: linuxppc-dev@ozlabs.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 17, 2007 at 10:36:27AM -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Only the MPC5200 needs this bug fix.  MPC5200B is okay.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> Sven, Domen;
> 
> Can you please test this patch?

I will test it tomorrow. For some obscure reason, my efika refuses to
get the console=ttyPSC0 appended, so i have a hard time testing it.

Friendly,

Sven Luther
