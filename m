Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B74C5B7B68
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 21:18:25 +1000 (EST)
Subject: Re: 2.6.31-git5 kernel boot hangs on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4AB214C3.4040109@in.ibm.com>
References: <4AB0D947.8010301@in.ibm.com>  <4AB214C3.4040109@in.ibm.com>
Content-Type: text/plain
Date: Thu, 17 Sep 2009 21:13:13 +1000
Message-Id: <1253185994.8375.352.camel@pasglop>
Mime-Version: 1.0
Cc: Tejun Heo <tj@kernel.org>, Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-17 at 16:21 +0530, Sachin Sant wrote:
> The problem seems to have been introduced with
> commit ada3fa15057205b7d3f727bba5cd26b5912e350f.
> 
> Specifically this patch : 
> powerpc64: convert to dynamic percpu allocator
> 
> If i revert this patch i am able to boot latest git
> on a powerpc box.
> 
> The kernel is configured with 64K pages.
> Have again attached the config file used.

Thanks for tracking the commit down. I've tried it today but your config
has everything as modules and that didn't work out very well with my
netboot setup. I'll dig a bit more tomorrow.

It's probably my fault for not properly getting the time to test Tejun
patches... oh well, that's what being too busy does to you.

Cheers,
Ben.
