Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	by ozlabs.org (Postfix) with ESMTP id CF5CDDE136
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 22:02:49 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
Date: Thu, 12 Mar 2009 12:02:44 +0100
References: <49B58779.9040905@lebon.org.ua> <200903120924.13378.sr@denx.de>
	<20090312104543.GB3788@zod.rchland.ibm.com>
In-Reply-To: <20090312104543.GB3788@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903121202.44406.sr@denx.de>
Cc: lebon@lebon.org.ua, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 12 March 2009, Josh Boyer wrote:
> >> Yes, that's also how I use it on canyonlands... now, the wrapper could
> >> probably be used to look at the bd_t anyways, no ?
> >
> >Sure.
>
> Do newer U-Boot versions pass both the dtb and the bd_t?

Both is possible. The user can choose by using different boot commands (with 
or without device tree blob). When using the wrapper, the boot command has to 
be without the device tree and therefor the bd_t is passed to the kernel.

Best regards,
Stefan
