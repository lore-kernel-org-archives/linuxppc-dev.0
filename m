Return-Path: <benh@ozlabs.org>
Subject: Re: [PATCH 5/6] [POWERPC] properly declare onstack completion in
	iseries veth
From: Benjamin Herrenschmidt <benh@ozlabs.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20080410105636.GA10048@lst.de>
References: <20080409072230.C861EDDED0@ozlabs.org>
	<20080409083616.GA24712@lst.de> <1207775002.9079.25.camel@pasglop>
	<20080410105636.GA10048@lst.de>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 22:21:39 +1000
Message-Id: <1207830099.6958.9.camel@pasglop>
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


On Thu, 2008-04-10 at 12:56 +0200, Christoph Hellwig wrote:
> On Thu, Apr 10, 2008 at 07:03:22AM +1000, Benjamin Herrenschmidt wrote:
> > I don't think there's any difference between the _ONSTACK variant
> > and the normal one without lockdep, is there ?
> 
> No there's not.  Thus it's a guaranteed no-op and can easily go in.

Heh, I won't argue either way :-) It's Paul's call at this stage.

Cheers,
Ben.
