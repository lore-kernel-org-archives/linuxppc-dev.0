Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCC32DDE38
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 16:07:49 +1000 (EST)
In-Reply-To: <11853846332917-git-send-email-timur@freescale.com>
References: <11853846332917-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8CEA1441-8408-48A9-A023-F072FBC3EEE2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] POWERPC: Fix definition of global-utilites structure for
	86xx
Date: Thu, 26 Jul 2007 01:08:36 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 25, 2007, at 12:30 PM, Timur Tabi wrote:

> The current definition of struct ccsr_guts in immap_86xx.h was for  
> 85xx.
> This patch fixes that and replaces the vague integer types with  
> sized types
> of the correct endianness.  The unused struct ccsr_pci is also  
> deleted.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  include/asm-powerpc/immap_86xx.h |  151 +++++++++++ 
> +--------------------------
>  1 files changed, 46 insertions(+), 105 deletions(-)

Why don't we remove this completely, nothing uses it?

- k
