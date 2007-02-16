Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8D2EDDD03
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 14:44:23 +1100 (EST)
In-Reply-To: <Pine.LNX.4.61.0702152043270.9034@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0702152043270.9034@ld0175-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EE5E84C5-87F0-4836-AE28-1EE0E2CC556C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC 2/7] Unite all PCI-e on 85xx and 86xx under one codebase
Date: Thu, 15 Feb 2007 21:43:29 -0600
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 15, 2007, at 8:44 PM, Andy Fleming wrote:

> Add 85xx PCI express memory map register.
>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Acked-by: Andy Fleming <afleming@freescale.com>
> ---
>  include/asm-ppc/immap_85xx.h |   75 +++++++++++++++++++++++++++++++ 
> +++++++++++
>  1 files changed, 75 insertions(+), 0 deletions(-)

Are the 86xx and 85xx structs the same?  If so, can we pull them out  
of immap_*.h into a sysdev/fsl_pcie.h

(and lose the typedef while you're at it).

- k
