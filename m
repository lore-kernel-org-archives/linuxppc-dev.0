Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 5DFE2681BD
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 08:28:33 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 12 Jan 2006 14:28:31 -0700
To: Wolfram Joost <pegasos@frokaschwei.de>
Message-ID: <20060112212831.GA30939@xyzzy.farnsworth.org>
References: <20060112190900.23594.qmail@farnsworth.org>
	<200601122216.18481@mail.frokaschwei.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200601122216.18481@mail.frokaschwei.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: mv643xx_eth.c: Multicast and IPv6 support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 12, 2006 at 10:16:18PM +0100, Wolfram Joost wrote:
> > > currently, the driver mv643xx_eth.c doesn't support receiving of
> 
> > Thanks.  On December 28th, I posted a patch to netdev@vger.kernel.org that
> > adds multicast support to the mv643xx driver.  I'll ping jgarzik
> > about it.
> 
> Oh, didn't find that patch yesterday.
> 
> > The IPv6 changes look good.  Would you please re-submit these without
> > the multicast changes and with a Signed-off-by line?
> 
> Here it comes. However, IPv6 uses multicasting for address resolution
> (replacement for ARP), so IPv6 doesn't work until the multicast patch is applied, too.

Thanks Wolfram.  I'll put it in my queue for testing and if all goes well,
I'll forward it to Jeff Garzik this weekend.

-Dale
