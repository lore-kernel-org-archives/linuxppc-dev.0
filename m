Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9B4D1A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 15:33:05 +1100 (AEDT)
Message-ID: <1456374775.5360.32.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 24 Feb 2016 22:32:55 -0600
In-Reply-To: <1456202900-5454-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456202900-5454-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH V4 15/18] powerpc/mm: Move hash page table related
 functions to pgtable-hash64.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-23 at 10:18 +0530, Aneesh Kumar K.V wrote:
> 
> diff --git a/arch/powerpc/mm/pgtable-book3e.c b/arch/powerpc/mm/pgtable
> -book3e.c
> new file mode 100644
> index 000000000000..bdaa4376f838
> --- /dev/null
> +++ b/arch/powerpc/mm/pgtable-book3e.c
> @@ -0,0 +1,163 @@
> +
> +/*
> + * Copyright IBM Corporation, 2015
> + * Author Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU Lesser General Public License
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + */
> +
> +/*
> + * PPC64 THP Support for hash based MMUs
> + */

This comment doesn't match the filename.

Regarding the rest of the file's contents, why is this being code being
copied?  The very terse changelog doesn't cover it.

-Scott
