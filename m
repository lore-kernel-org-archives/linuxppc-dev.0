Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F70368777
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 06:24:43 +1100 (EST)
Date: Thu, 17 Nov 2005 12:07:15 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20051117140715.GC9753@logos.cnet>
References: <437B2051.5030408@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437B2051.5030408@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Nov 16, 2005 at 03:04:33PM +0300, Vitaly Bordug wrote:
> This adds board-specific files needed to utilize fs_enet Ethernet driver
> for MPC885ADS and MPC866ADS.
> 
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> 

Vitaly,

It also sounds to me that mpc885_nonplatform_device_init()
initialization suits board_init() time, instead of post-start_kernel()
do_initcalls(). No?
