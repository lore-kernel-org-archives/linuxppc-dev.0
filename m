Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E51DBDDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Nov 2007 08:09:27 +1100 (EST)
Subject: Re: Latest paulus.git PCI broken on mpc8540?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <A4E1A594-5A31-4EFE-B4F9-E4B24F9207F7@kernel.crashing.org>
References: <473C7FCC.7050307@anagramm.de>
	<4E0EFED3-8697-4768-9D89-A2443AEC82A5@kernel.crashing.org>
	<1195191333.28865.140.camel@pasglop>
	<A4E1A594-5A31-4EFE-B4F9-E4B24F9207F7@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 17 Nov 2007 08:09:17 +1100
Message-Id: <1195247357.28865.178.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-16 at 13:18 -0600, Kumar Gala wrote:
> 
> 
> Well, for one the generic pci code will complain if its not able to  
> allocate the resource which is the true failure.
> 
> I'm thinking maybe we just make these pr_debug() instead of standard  
> printk?

I was thinking about changing the message to "cannot allocate initial
resource, will reallocate" or something like that. That is, make it
clear it's non fatal.

Ben.
