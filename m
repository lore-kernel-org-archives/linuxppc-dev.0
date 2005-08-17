Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D5EB67FC9
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2005 07:48:26 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <76E28B16-5706-48C8-B92A-349C4F40FA76@freescale.com>
References: <1124209292.3869.5.camel@localhost.localdomain>
	<76E28B16-5706-48C8-B92A-349C4F40FA76@freescale.com>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 07:44:47 +1000
Message-Id: <1124315089.8857.41.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: When are machine checks suppose to be recoverable?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-08-17 at 09:00 -0500, Kumar Gala wrote:
> David's 8250 cleanup patch made me wondering when are machine checks  
> suppose to recoverable?  General class of conditions is what I'm  
> looking for here.
> 
> Is David's case due to some PCI master abort or something else?

Might be some issue on SMP machines... 

Ben.
