Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CEC51B7B72
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 17:01:26 +1000 (EST)
Subject: Re: [PATCH] Fix build of cpm_uart due to core changes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <1253772553.7103.402.camel@pasglop>
References: <1253772553.7103.402.camel@pasglop>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 17:01:18 +1000
Message-Id: <1253775678.7103.423.camel@pasglop>
Mime-Version: 1.0
Cc: alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-24 at 16:09 +1000, Benjamin Herrenschmidt wrote:
> Commit ebd2c8f6d2ec4012c267ecb95e72a57b8355a705
> "serial: kill off uart_info"
> 
> broke the build of this driver, possibly because the driver isn't
> in drivers/serial and thus was missed by Alan. This fixes it.

I must have a serious amount of shit in my eyes :-) For some reason
I was persuaded the driver was in arch/powerpc .. well, it -is- in
drivers/serial, so yes, Alan did miss it somewhat but not because
it was in the wrong place :-)

Patch is still good tho, I'll fix up the comment in my tree.

Sorry,
Ben.
