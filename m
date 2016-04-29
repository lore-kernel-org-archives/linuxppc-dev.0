Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx2M83qBmzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 15:29:40 +1000 (AEST)
Message-ID: <1461907780.3865.2.camel@ellerman.id.au>
Subject: Re: [PATCH kernel] powerpc/powernv: Fix debug macro
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 29 Apr 2016 15:29:40 +1000
In-Reply-To: <1461905766-22558-1-git-send-email-aik@ozlabs.ru>
References: <1461905766-22558-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-29 at 14:56 +1000, Alexey Kardashevskiy wrote:

> When cfg_dbg() is enabled (i.e. mapped to printk()), gcc produces
> errors as the __func__ parameter is missing (pnv_pci_cfg_read() has one);
> this adds the missing parameter.

Thanks.

But the whole file should just be converted to use pr_devel(), which is an
existing well known macro and will catch this for you.

cheers
