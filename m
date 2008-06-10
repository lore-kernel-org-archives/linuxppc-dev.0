Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9FC98DEEB9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 02:09:00 +1000 (EST)
Message-Id: <13478D7F-779B-472D-8C36-C736321EB645@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080523163858.GC16137@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 3/7] [POWERPC] QE: prepare QE PIO code for GPIO LIB support
Date: Tue, 10 Jun 2008 11:08:41 -0500
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
	<20080523163858.GC16137@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 11:38 AM, Anton Vorontsov wrote:

> - split and export __par_io_config_pin() out of par_io_config_pin(),  
> so we
>  could use the prefixed version with GPIO LIB API;
> - rename struct port_regs to qe_pio_regs, and place it into qe.h;
> - rename #define NUM_OF_PINS to QE_PIO_PINS, and place it into qe.h.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-By: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/sysdev/qe_lib/qe_io.c |   94 ++++++++++++++++ 
> +-------------------
> include/asm-powerpc/qe.h           |   19 +++++++
> 2 files changed, 64 insertions(+), 49 deletions(-)


applied.

- k
