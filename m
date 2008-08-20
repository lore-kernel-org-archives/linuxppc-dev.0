Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D5E2DE06A
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 14:07:46 +1000 (EST)
Subject: Re: CONFIG_BOOTX_TEXT breaks PowerBook 3400 with BootX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Finn Thain <fthain@telegraphics.com.au>
In-Reply-To: <Pine.LNX.4.64.0808200148080.24338@loopy.telegraphics.com.au>
References: <Pine.LNX.4.64.0808200148080.24338@loopy.telegraphics.com.au>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 14:07:29 +1000
Message-Id: <1219205249.21386.7.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-20 at 03:23 +1000, Finn Thain wrote:
> Hi All,
> 
> When I build kernels with CONFIG_BOOTX_TEXT enabled I can't boot a PB 3400 
> with BootX. I get a black screen with "Welcome to Linux" at the top, then 
> it appears to hang. Debian kernels are configured this way and suffer the 
> same problem.
> 
> I don't know if Quik is affected. It is a bit of a hassle at install time 
> since the (mediabay) floppy drive can't co-exist with the (mediabay) 
> CDROM, so I'm using BootX to do the Debian install.
> 
> The Debian Sarge 2.6.8-4 kernel does not seem to have this problem though 
> kernel.org 2.6.16 and later versions do.
> 
> Any ideas?

How "late" have you tried ? I remember fixing something at one point...

Ben.
