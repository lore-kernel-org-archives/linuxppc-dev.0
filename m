Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 65491DDF0F
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 08:58:30 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l66MwRnZ005402
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jul 2007 18:58:27 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l66MwRXT524546
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jul 2007 18:58:27 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l66MwQiZ025794
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jul 2007 18:58:27 -0400
Date: Fri, 6 Jul 2007 17:58:26 -0500
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: [PATCH] pseries: Re: Minor: Removed double return.
Message-ID: <20070706225826.GE4457@austin.ibm.com>
References: <468EBB5B.2070309@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <468EBB5B.2070309@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


You want to say its a patch in the subject line.

--linas

On Fri, Jul 06, 2007 at 04:59:55PM -0500, Manish Ahuja wrote:
> Found 2 instances of return one right after each other in 
> arch_add_memory(). This minor patch fixes it.
> Signed-off-by:Manish Ahuja <mahuja@us.ibm.com>
> 
> 

> Index: 2.6.22-rc4/arch/powerpc/mm/mem.c
> ===================================================================
> --- 2.6.22-rc4.orig/arch/powerpc/mm/mem.c	2007-06-11 21:10:46.000000000 -0500
> +++ 2.6.22-rc4/arch/powerpc/mm/mem.c	2007-06-29 22:52:42.000000000 -0500
> @@ -129,8 +129,6 @@
>  	zone = pgdata->node_zones;
>  
>  	return __add_pages(zone, start_pfn, nr_pages);
> -
> -	return 0;
>  }
>  
>  /*
