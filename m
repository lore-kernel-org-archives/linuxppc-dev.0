Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40E79DE0CD
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 19:12:42 +1100 (EST)
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200903120905.11542.sr@denx.de>
References: <49B58779.9040905@lebon.org.ua> <200903120702.03286.sr@denx.de>
	<1236843157.7086.83.camel@pasglop>  <200903120905.11542.sr@denx.de>
Content-Type: text/plain
Date: Thu, 12 Mar 2009 19:12:29 +1100
Message-Id: <1236845549.7086.86.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, lebon@lebon.org.ua
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-03-12 at 09:05 +0100, Stefan Roese wrote:
> 
> Both is possible. Older U-Boot versions only passed the bd_t struct to the 
> kernel. For those U-Boot's the wrapper is needed. More recent U-Boot versions 
> support passing a device-tree blob to the kernel. U-Boot patches the correct 
> memory size in this blob.
> 
> As a matter of fact, I never used the wrapper before. U-Boot supports passing 
> the device-tree blob to Linux since quite some time now.

Yes, that's also how I use it on canyonlands... now, the wrapper could
probably be used to look at the bd_t anyways, no ? Either get the mem
size from there or some flag or version in there can indicate if it's
been "fixed".

Ben.
