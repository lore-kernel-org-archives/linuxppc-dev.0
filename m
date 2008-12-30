Return-Path: <nhorman@tuxdriver.com>
Received: from smtp.tuxdriver.com (charlotte.tuxdriver.com [70.61.120.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A5DFDDDDF
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 03:42:03 +1100 (EST)
Date: Tue, 30 Dec 2008 11:39:48 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] clean up of netif_rx_reschedule() changes in drivers
Message-ID: <20081230163948.GB2701@localhost.localdomain>
References: <20081229102509.GA11111@linux.vnet.ibm.com>
	<20081229214144.43be8c1d.sfr@canb.auug.org.au>
	<20081229153757.GA2857@localhost.localdomain>
	<20081229.181908.214463121.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081229.181908.214463121.davem@davemloft.net>
Cc: sfr@canb.auug.org.au, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 29, 2008 at 06:19:08PM -0800, David Miller wrote:
> From: Neil Horman <nhorman@tuxdriver.com>
> Date: Mon, 29 Dec 2008 10:37:57 -0500
> 
> > On Mon, Dec 29, 2008 at 09:41:44PM +1100, Stephen Rothwell wrote:
> > > Hi Kamalesh,
> > > 
> > > On Mon, 29 Dec 2008 15:55:29 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
> > > > greping through the sources for the changes missed out, we have
> > > > 
> > > 	.
> > > 	.
> > > > 
> > > > Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
>  ...
> > Thanks guys, not sure how my patch missed that.  I did an allmodconfig build
> > that passed successfully.  Thanks!
> 
> It's very simple, you're not building on powerpc or ARM :-)
> 
Doh!  Stupid of me.  apologies.

> > Acked-by: Neil Horman <nhorman@tuxdriver.com>
> 
> Applied, thanks everyone.
> 
