Return-Path: <hch@lst.de>
Date: Wed, 14 Sep 2005 15:43:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050914134347.GB9700@lst.de>
References: <1126643920.11056.53.camel@cashmere.sps.mot.com>
	<20050914110506.GA7049@lst.de>
	<1126705294.14036.4.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1126705294.14036.4.camel@cashmere.sps.mot.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: PATCH powerpc: Merge asm-ppc*/hardirq.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 14, 2005 at 08:41:34AM -0500, Jon Loeliger wrote:
> > I'd suggest just using a DECLARE_PER_CPU variable for last_jiffy_stamp.
> > In facct I plan to get rid of irq_cpustat_t completely at some point.
> 
> Hmmm... So, I don't want to mess that up.  How about I leave it
> as I've suggested and leave that step up to you as a follow on?

ok.
