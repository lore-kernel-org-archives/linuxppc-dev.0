Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7581F67A30
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Feb 2005 16:14:16 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <42011E77.6040906@nortel.com>
References: <42011E77.6040906@nortel.com>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 16:13:33 +1100
Message-Id: <1107407613.2363.9.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: new binutils breaks "tlbie" instruction in kernel?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-02-02 at 12:39 -0600, Chris Friesen wrote:
> The "tlbie" instruction has a bit which may be set to indicate regular 
> or large page size.  This used to be set via an optional second parameter.
> 
> Apparently some time between binutils versions 2.15.91.0.2 and 
> 2.15.92.0.2 a change went in to make this second parameter mandatory, 
> which breaks the kernel ppc code.
> 
> What is the recommended way to fix this?  Do all binutils versions 
> understand the second parameter, or will "sufficiently old" versions 
> choke on it?

Wasn't it fixed ?

Ben.
