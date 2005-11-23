Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 27D89687FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 05:24:31 +1100 (EST)
Date: Wed, 23 Nov 2005 10:53:26 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vitaly Bordug <vbordug@dev.rtsoft.ru>,
	Kumar Gala <galak@kernel.crashing.org>
Message-ID: <20051123125326.GB4526@logos.cnet>
References: <437E048B.2020605@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437E048B.2020605@dev.rtsoft.ru>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx PCMCIA: support for MPC885ADS and MPC866ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

On Fri, Nov 18, 2005 at 07:42:51PM +0300, Vitaly Bordug wrote:
> This adds adds PCMCIA supported for  both MPC885ADS and MPC866ADS.
> 
> This is established not together with FADS, because 885 does not have 
> io_block_mapping() for BCSR area.
> Also, some cleanups done both for 885ADS and MBX.
> 
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

<snip>

> +	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));

Shouldnt you handle ioremap() failure? Most 85xx code written
by Kumar also does not.
