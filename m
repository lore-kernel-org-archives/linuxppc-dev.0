Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BC74DDEE9
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 15:55:05 +1100 (EST)
Subject: Re: Problem with module_init?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20090402005126.1b30dacd@lappy.seanm.ca>
References: <20090331143742.083c6cb0@lappy.seanm.ca>
	<20090331231153.256d1bf4@lappy.seanm.ca>
	<20090401112756.GA14171@yoda.jdub.homelinux.org>
	<1238624683.17330.138.camel@pasglop>
	<20090402000803.087600da@lappy.seanm.ca>
	<1238646362.17330.186.camel@pasglop>
	<20090402003905.317431e5@lappy.seanm.ca>
	<20090402005126.1b30dacd@lappy.seanm.ca>
Content-Type: text/plain
Date: Thu, 02 Apr 2009 15:54:58 +1100
Message-Id: <1238648098.17330.187.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-02 at 00:51 -0400, Sean MacLennan wrote:
> On Thu, 2 Apr 2009 00:39:05 -0400
> "Sean MacLennan" <sean.maclennan@ottawa.kanatek.ca> wrote:
> 
> > Although, that *could* be unrelated bug.
> 
> It *is* an unrelated bug. dma_alloc_coherent now requires a device
> where before it was optional. Carry on.

Right, that's new in .30

Cheers,
Ben.

> Cheers,
>    Sean
