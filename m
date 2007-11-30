Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6A43DDDF0
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 07:10:00 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAUKBcaW023924
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 15:11:38 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAUK9vFZ501206
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 15:09:57 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAUK9ugi029257
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 15:09:57 -0500
Date: Fri, 30 Nov 2007 14:08:25 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 18/24] powerpc: Base support for 440GX Taishan eval board
Message-ID: <20071130140825.67721825@zod.rchland.ibm.com>
In-Reply-To: <20071130061203.B6239DDED7@ozlabs.org>
References: <1196403038.569525.367459803520.qpush@grosgo>
	<20071130061203.B6239DDED7@ozlabs.org>
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

On Fri, 30 Nov 2007 17:11:01 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> From: Hugh Blemings <hugh@blemings.org>
> 
> 
> Signed-off-by: Hugh Blemings <hugh@blemings.org>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> This needs a bit of cleanup still, probably not to be merged as-is
> just yet (like using mtdcri/mfdcri for CPR access).
> 
>  arch/powerpc/Kconfig.debug           |    6 
>  arch/powerpc/boot/44x.h              |    1 
>  arch/powerpc/boot/Makefile           |    7 

Small conflict in the Makefile keeps this from applying cleanly.

josh
