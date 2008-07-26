Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 2DB36DDDFB
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 22:39:03 +1000 (EST)
Subject: Re: [PATCH] powerpc/mpc5200: Fix locking on mpc52xx_spi driver
From: Daniel Walker <dwalker@mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20080726062226.10506.65539.stgit@trillian.secretlab.ca>
References: <20080726062226.10506.65539.stgit@trillian.secretlab.ca>
Content-Type: text/plain
Date: Sat, 26 Jul 2008 08:35:50 -0400
Message-Id: <1217075750.3970.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: spi-devel-general@lists.sourceforge.net, dbrownell@users.sourceforge.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-07-26 at 02:24 -0400, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Locking was incorrect for the state machine processing since there are
> conditions where both the work queue and the IRQ can be active.  This
> patch fixes the handling to ensure the spin lock is held whenever the
> state machine is being processed.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> Hi Daniel,
> 
> Here is the incremental change to the mpc52xx_spi driver to fix up the
> locking.  It should be safe and unambiguous now.


Thank you, it looks much better..

Daniel
