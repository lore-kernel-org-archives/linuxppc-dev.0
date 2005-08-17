Return-Path: <SRS0+4f7dea7c1a1c06760337+724+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2678467FF9
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2005 08:32:52 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1124315089.8857.41.camel@gaston>
References: <1124209292.3869.5.camel@localhost.localdomain>
	<76E28B16-5706-48C8-B92A-349C4F40FA76@freescale.com>
	<1124315089.8857.41.camel@gaston>
Content-Type: text/plain
Date: Wed, 17 Aug 2005 23:30:50 +0100
Message-Id: <1124317852.24373.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: When are machine checks suppose to be recoverable?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-08-18 at 07:44 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2005-08-17 at 09:00 -0500, Kumar Gala wrote:
> > David's 8250 cleanup patch made me wondering when are machine checks  
> > suppose to recoverable?  General class of conditions is what I'm  
> > looking for here.
> > 
> > Is David's case due to some PCI master abort or something else?
> 
> Might be some issue on SMP machines... 

Yeah, that'll probably be the reason it turns out _not_ to be
recoverable despite our expectations. But that wasn't Kumar's question.

-- 
dwmw2
