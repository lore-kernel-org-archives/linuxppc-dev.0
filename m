Return-Path: <HNGUYEN@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 79E2C67C2C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 05:50:12 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id k9PJo6gT147974
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 19:50:06 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k9PJqnBJ2723924
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 21:52:49 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k9PJo5ge011034
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 21:50:06 +0200
In-Reply-To: <17726.62952.416387.74258@cargo.ozlabs.ibm.com>
Subject: Re: [PATCH] Fix eHCA driver compilation for uniprocessor
To: Paul Mackerras <paulus@samba.org>, "Roland Dreier" <rdreier@cisco.com>
Message-ID: <OF6C29FB25.BEB4A4D2-ONC1257212.006CF315-C1257212.006D07FB@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Wed, 25 Oct 2006 21:52:48 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Heiko J Schick <schickhj@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Paul!
Thanks for this patch!
Roland, not sure if you still need me to make a patch against your git?
Let me know in case of need.
Thanks!
Nam
> The eHCA driver does not compile for a uniprocessor configuration
> (CONFIG_SMP=n), due to H_SUCCESS and other symbols being undefined.
> This fixes it.
>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> diff --git a/drivers/infiniband/hw/ehca/ehca_tools.h
b/drivers/infiniband/hw/ehca/ehca_tools.h
> index 809da3e..973c4b5 100644
> --- a/drivers/infiniband/hw/ehca/ehca_tools.h
> +++ b/drivers/infiniband/hw/ehca/ehca_tools.h
> @@ -63,6 +63,7 @@ #include <asm/abs_addr.h>
>  #include <asm/ibmebus.h>
>  #include <asm/io.h>
>  #include <asm/pgtable.h>
> +#include <asm/hvcall.h>
>
>  extern int ehca_debug_level;
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
