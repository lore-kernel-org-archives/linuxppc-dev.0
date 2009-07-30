Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6494FB7B95
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 14:23:14 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9CD46DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 14:23:13 +1000 (EST)
Message-Id: <DAC36396-13DC-4910-B8AB-94CC994264BD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Mark Ware <mware@elphinstone.net>
In-Reply-To: <4A645A27.7040002@elphinstone.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [RFC/PATCH] powerpc: Don't use alloc_bootmem in cpm_uart_cpm2.c
Date: Wed, 29 Jul 2009 23:22:56 -0500
References: <4A645A27.7040002@elphinstone.net>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 20, 2009, at 6:51 AM, Mark Ware wrote:

> This is another alloc_bootmem() -> kzalloc() change, this time to
> fix the non-fatal badness caused when booting with a cpm2_uart  
> console.
>
> Signed-Off-By: Mark Ware <mware@elphinstone.net>
>
> ---
> drivers/serial/cpm_uart/cpm_uart_cpm2.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to merge (had to fix up patch by hand).

- k
