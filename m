Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E76F9DDED3
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 12:26:15 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m331QC7v031256
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 21:26:12 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m331QCW8231894
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 21:26:12 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m331QB1x020048
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 21:26:11 -0400
Date: Wed, 2 Apr 2008 20:25:46 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] [POWERPC] 4xx: Create common ppc4xx_reset_system() in
	ppc4xx_soc.c
Message-ID: <20080402202546.24ac1a95@zod.rchland.ibm.com>
In-Reply-To: <1206629011-28821-1-git-send-email-sr@denx.de>
References: <1206629011-28821-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 Mar 2008 15:43:31 +0100
Stefan Roese <sr@denx.de> wrote:

> diff --git a/arch/powerpc/platforms/44x/sequoia.c b/arch/powerpc/platforms/44x/sequoia.c
> index d279db4..1782d41 100644
> --- a/arch/powerpc/platforms/44x/sequoia.c
> +++ b/arch/powerpc/platforms/44x/sequoia.c
> @@ -23,8 +23,6 @@
>  #include <asm/uic.h>
>  #include <asm/pci-bridge.h>
> 
> -#include "44x.h"
> -

Almost a perfect patch.  Alas, missing a #include <asm/ppc4xx.h> which
breaks the sequoia build.

I'll fix it up locally :).

josh
