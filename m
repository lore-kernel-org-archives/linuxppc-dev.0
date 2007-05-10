Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51727DDEDF
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 15:20:47 +1000 (EST)
Date: Thu, 10 May 2007 00:16:17 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] Move reg_booke.h to include/asm-powerpc
In-Reply-To: <11787390792190-git-send-email-becky.bruce@freescale.com>
Message-ID: <Pine.LNX.4.64.0705100016120.27791@localhost.localdomain>
References: <11787390792190-git-send-email-becky.bruce@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 9 May 2007, Becky Bruce wrote:

> This patch moves reg_booke.h from include/asm-ppc to include/asm-powerpc.  This is
> just a git-mv of the file; no changes were made.  Tested builds of 8540 ADS and
> Ebony platforms with ARCH=ppc and ARCH=powerpc.
>
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> ---
>  include/{asm-ppc => asm-powerpc}/reg_booke.h |    0
>  1 files changed, 0 insertions(+), 0 deletions(-)
>  rename include/{asm-ppc => asm-powerpc}/reg_booke.h (100%)
>
> diff --git a/include/asm-ppc/reg_booke.h b/include/asm-powerpc/reg_booke.h
> similarity index 100%
> rename from include/asm-ppc/reg_booke.h
> rename to include/asm-powerpc/reg_booke.h
>

applied.

- k
