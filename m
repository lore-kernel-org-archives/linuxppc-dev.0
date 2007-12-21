Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2307BDDDEA
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 23:07:22 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBLC7J9c012600
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 07:07:19 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBLC7IOY491182
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 07:07:18 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBLC7IPm018334
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 07:07:18 -0500
Date: Fri, 21 Dec 2007 06:01:36 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/21] [POWERPC] Reworking machine check handling and Fix
	440/440A
Message-ID: <20071221060136.611eb899@zod.rchland.ibm.com>
In-Reply-To: <20071221043925.42B40DDE30@ozlabs.org>
References: <20071221043925.42B40DDE30@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 21 Dec 2007 15:39:21 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:


> Index: linux-merge/include/asm-ppc/reg_booke.h
> ===================================================================
> --- linux-merge.orig/include/asm-ppc/reg_booke.h	2007-09-28 11:42:10.000000000 +1000
> +++ linux-merge/include/asm-ppc/reg_booke.h	2007-12-20 11:35:40.000000000 +1100
> @@ -207,7 +207,7 @@
>  #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
> 
>  /* Bit definitions for the MCSR. */
> -#ifdef CONFIG_440A
> +#ifdef CONFIG_44x

Should be #ifdef CONFIG_4xx as I pointed out last time.  I'll fix it
when I commit.

josh
