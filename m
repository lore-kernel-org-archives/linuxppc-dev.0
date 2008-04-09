Return-Path: <benh@ozlabs.org>
Subject: Re: [PATCH 5/6] [POWERPC] properly declare onstack completion in
	iseries veth
From: Benjamin Herrenschmidt <benh@ozlabs.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20080409083616.GA24712@lst.de>
References: <20080409072230.C861EDDED0@ozlabs.org>
	<20080409083616.GA24712@lst.de>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 07:03:22 +1000
Message-Id: <1207775002.9079.25.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-09 at 10:36 +0200, Christoph Hellwig wrote:
> On Wed, Apr 09, 2008 at 05:21:34PM +1000, Benjamin Herrenschmidt wrote:
> > The iSeries veth driver uses an on-stack struct completion that
> > it initializes using the COMPLETION_INITIALIZER instead of
> > COMPLETION_INITIALIZER_ONSTACK macro, causing problems with
> > lockdep.
> 
> should probably go in ASAP independent of the lockdep series.

I don't think there's any difference between the _ONSTACK variant
and the normal one without lockdep, is there ?

Cheers,
Ben.
