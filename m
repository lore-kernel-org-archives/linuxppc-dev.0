Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 2D212DE2CC
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 21:29:19 +1000 (EST)
Date: Fri, 19 Oct 2007 13:29:16 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] bestcomm: Restrict disabling of bus prefetch to original
	mpc5200 silicon.
Message-ID: <20071019112916.GE27403@nd47.coderock.org>
References: <20071017163555.24992.40095.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071017163555.24992.40095.stgit@trillian.cg.shawcable.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 17/10/07 10:36 -0600, Grant Likely wrote:
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

I found no obvious problems with it on Efika (mpc5200b)


	Domen
