Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C03EBDDF10
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 21:16:23 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7DBGKRN027412
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 07:16:20 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7DBGKrm253878
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 05:16:20 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7DBGJKm018995
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 05:16:20 -0600
Date: Mon, 13 Aug 2007 06:15:22 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: joe@perches.com
Subject: Re: [PATCH] [298/2many] MAINTAINERS - LINUX FOR 64BIT POWERPC
Message-ID: <20070813061522.57ca3662@zod.rchland.ibm.com>
In-Reply-To: <46bffaba.dVM9Q/vXNeROaC6B%joe@perches.com>
References: <46bffaba.dVM9Q/vXNeROaC6B%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: anton@au1.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, anton@samba.org, paulus@au1.ibm.com,
	torvalds@linux-foundation.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 12 Aug 2007 23:31:22 -0700
joe@perches.com wrote:

> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6d10932..36c4960 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2857,6 +2857,9 @@ M:	anton@au.ibm.com
>  W:	http://www.penguinppc.org/ppc64/
>  L:	linuxppc-dev@ozlabs.org
>  S:	Supported
> +F:	arch/powerpc/configs/ppc64_defconfig
> +F:	arch/powerpc/kernel/proc_ppc64.c
> +F:	include/asm-powerpc/pgtable-ppc64.h

Erm, there's a lot more to 64-bit PowerPC than those 3 files.  You're
better off just doing arch/powerpc/, include/asm-powerpc.

josh
