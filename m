Return-Path: <santil@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2B73C67CCF
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 08:14:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9PMEu89030000
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 18:14:56 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9PMEfES141936
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 18:14:41 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9PMEeAQ006420
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 18:14:41 -0400
Message-ID: <453FE1DF.5050004@us.ibm.com>
Date: Wed, 25 Oct 2006 17:14:55 -0500
From: Santiago Leon <santil@us.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Remove ibmveth "liobn" field
References: <1161749834.22582.36.camel@localhost.localdomain>
In-Reply-To: <1161749834.22582.36.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> Remove the now unused "liobn" field in ibmveth which also avoids
> having insider knowledge of the iommu table in that driver.

Thanks for cleaning that up.

> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Santiago Leon <santil@us.ibm.com>

---
> 
> This will avoid this driver from breaking when I change the dma
> mapping code for 2.6.20.
> 
> Index: linux-cell/drivers/net/ibmveth.c
> ===================================================================
> --- linux-cell.orig/drivers/net/ibmveth.c	2006-10-23 14:41:38.000000000 +1000
> +++ linux-cell/drivers/net/ibmveth.c	2006-10-25 14:12:05.000000000 +1000
> @@ -50,7 +50,6 @@
>  #include <asm/semaphore.h>
>  #include <asm/hvcall.h>
>  #include <asm/atomic.h>
> -#include <asm/iommu.h>
...

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center
