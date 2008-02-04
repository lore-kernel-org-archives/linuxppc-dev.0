Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6A849DDDF5
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 16:23:09 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m145Mlh2006996
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Feb 2008 16:22:47 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m145QhQn244810
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Feb 2008 16:26:43 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m145N7CG014241
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Feb 2008 16:23:08 +1100
Date: Mon, 4 Feb 2008 10:52:59 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Bastian Blank <bastian@waldi.eu.org>, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ext4 bitops
Message-ID: <20080204052259.GB7494@skywalker>
References: <20080201200240.GA28566@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080201200240.GA28566@wavehammer.waldi.eu.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 01, 2008 at 09:02:40PM +0100, Bastian Blank wrote:
> Fix ext4 bitops.
> 
> Signed-off-by: Bastian Blank <waldi@debian.org>
> 
> diff --git a/include/asm-powerpc/bitops.h b/include/asm-powerpc/bitops.h
> index 220d9a7..d0980df 100644
> --- a/include/asm-powerpc/bitops.h
> +++ b/include/asm-powerpc/bitops.h
> @@ -363,6 +363,8 @@ unsigned long generic_find_next_le_bit(const unsigned long *addr,
>  				    unsigned long size, unsigned long offset);
>  /* Bitmap functions for the ext2 filesystem */
> 
> +#include <asm-generic/bitops/le.h>
> +
>  #define ext2_set_bit(nr,addr) \
>  	__test_and_set_le_bit((nr), (unsigned long*)addr)
>  #define ext2_clear_bit(nr, addr) \


I am not sure what the changes are for. Can you send me the build logs
with the compile error. I always test Ext4 on powerpc so not sure what
went wrong.

-aneesh
