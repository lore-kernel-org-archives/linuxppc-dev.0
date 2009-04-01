Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E667DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 09:24:53 +1100 (EST)
Subject: Re: Problem with module_init?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090401112756.GA14171@yoda.jdub.homelinux.org>
References: <20090331143742.083c6cb0@lappy.seanm.ca>
	<20090331231153.256d1bf4@lappy.seanm.ca>
	<20090401112756.GA14171@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Thu, 02 Apr 2009 09:24:43 +1100
Message-Id: <1238624683.17330.138.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-04-01 at 07:27 -0400, Josh Boyer wrote:
> 
> I'm assuming this is the result of a git-bisect run?
> 
> Can I also assume you were loading the module on your Warp board?
> 
> Ben, have you tested module loads on 4xx since you redid this?
> 
I must shamefully admit almost never testing modules ... I always
netboot zImages with all the drivers I need built-in.

I suspect I just screwed up the definition of PAGE_KERNEL_EXEC or
something like that. I'll have a look.

Cheers,
Ben.
