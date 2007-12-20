Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0DCD4DDE38
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 10:56:50 +1100 (EST)
Message-Id: <AD8BE998-401D-4109-8DD0-F26760C0E980@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 0/4] arch/powerpc support for SBC8560 board
Date: Thu, 20 Dec 2007 17:56:45 -0600
References: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 3) Add device tree source for Wind River SBC8560 board
>
> This is probably the most interesting part of the group, given that  
> the
> board doesn't use the CPM2 to provide the serial console.  I've made a
> duart dts entry that is kind of similar to what is done for the tsi108
> on the mpc7448/hpc-ii board, and made sure that the serial had their
> parent marked as "soc" (found out the hard way that UARTs were ignored
> as possible consoles unless they were soc or tsi108 children...)
>
> b/arch/powerpc/boot/dts/sbc8560.dts |  203 ++++++++++++++++++++++++++ 
> +++++++++-

we need to figure out to fix this so we don't need the parent marked  
as 'soc'.

Out of interest how exactly are the duart's wired on the 8560.  Are  
they off localbus?


> I'd quickly spun together a u-boot 1.2.0 for testing this -- since  
> that was
> the quickest route to getting a powerpc capable version.  I'll see  
> what
> can be done for getting a u-boot 1.3.1 patchset out so the local-mac- 
> address
> vs address thing in the dtb isn't an issue.

Probably should add a boot wrapper to work with old non-device tree  
aware u-boots.

- k
