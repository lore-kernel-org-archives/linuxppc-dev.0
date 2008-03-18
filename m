Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AE556DDF51
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 11:27:51 +1100 (EST)
Date: Tue, 18 Mar 2008 03:27:37 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [Patch] 8xx: MGSUVD support
Message-ID: <20080318032737.7945c670@kernel.crashing.org>
In-Reply-To: <20080317223821.GA3622@loki.buserror.net>
References: <47D3B44D.8070909@denx.de>
	<20080309195914.69d51e68@kernel.crashing.org>
	<20080317223821.GA3622@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Mar 2008 17:38:21 -0500
Scott Wood wrote:

> On Sun, Mar 09, 2008 at 07:59:14PM +0300, Vitaly Bordug wrote:
> > I would like all the comments to be consistent C style (because
> > that's it for the most other dts'es).
> 
> $ fgrep -rI // arch/powerpc/boot/dts/ | wc -l
> 539
> 
So, we should go ahead and add a bit more hassle :) ?

By consistent C style I mean:

+			clock-frequency = <0>; /* Filled in by u-boot */ */
+			interrupts = <f 2>;	// decrementer interrupt

using either one or other way for same-type comments.

-Vitaly
