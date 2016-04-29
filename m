Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx1vf37jnzDqB4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 15:09:18 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 29 Apr 2016 15:09:17 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F271B2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 15:08:58 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3T58VfD52035772
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 15:08:53 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3T587i9024821
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 15:08:07 +1000
Subject: Re: [PATCH kernel] powerpc/powernv: Fix debug macro
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
References: <1461905766-22558-1-git-send-email-aik@ozlabs.ru>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <5722EBFC.5070807@au1.ibm.com>
Date: Fri, 29 Apr 2016 15:07:08 +1000
MIME-Version: 1.0
In-Reply-To: <1461905766-22558-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29/04/16 14:56, Alexey Kardashevskiy wrote:
> When cfg_dbg() is enabled (i.e. mapped to printk()), gcc produces
> errors as the __func__ parameter is missing (pnv_pci_cfg_read() has one);
> this adds the missing parameter.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
