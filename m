Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id B18CDDE0C3
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 01:31:37 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so957177yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 08:31:36 -0700 (PDT)
Date: Thu, 10 Jul 2008 09:31:01 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [BUG] fec_mpc52xx: Don't call mpc52xx_fec_reset() in ISR
Message-ID: <20080710153101.GD446@secretlab.ca>
References: <20080710123909.GA4275@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080710123909.GA4275@pengutronix.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 10, 2008 at 02:39:09PM +0200, Wolfram Sang wrote:
> Hello,
> 
> today, I was debugging a kernel crash on a board with a MPC5200B using
> 2.6.26-rc9. I found the following code in drivers/net/fec_mpc52xx.c:
<snip>
> I assume the proper thing to do is to set a flag in the ISR and handle
> the soft reset later in some other context. Having never dealt with the
> network core and its drivers so far, I am not sure which place would be
> the right one to perform the soft reset. To not make things worse, I
> hope people with more insight to network stuff can deliver a suitable
> solution to this problem.

Thanks for the bug report.  I'll take a look.

g.
