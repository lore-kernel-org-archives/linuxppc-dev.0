Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE676679A6
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Mar 2006 10:52:32 +1100 (EST)
Subject: Re: i2c-bus@0 twice?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1142447397.4670.12.camel@localhost>
References: <1142447397.4670.12.camel@localhost>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 10:52:25 +1100
Message-Id: <1142553145.14988.37.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-03-15 at 19:29 +0100, Johannes Berg wrote:
> johannes@quad:/proc/device-tree/ht@0,f2000000/pci@8/mac-io@7/i2c@18000$ ls
> AAPL,address       built-in     i2c-bus@0         linux,phandle
> AAPL,address-step  compatible   interrupt-parent  name
> AAPL,i2c-rate      device_type  interrupts        reg
> #address-cells     i2c-bus@0    linux,device      #size-cells
> 
> Somewhat odd that i2c-bus@0 exists twice :) Anyone have an explanation?

It's a bug in OF on these machines. We need to workaround that,
especially since only one of them contains all the useful infos

Ben
