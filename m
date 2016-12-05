Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXFKw4dxdzDsxq
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 17:32:20 +1100 (AEDT)
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tXFKv6lY3z9t1h
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Dec 2016 17:32:19 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id x23so15454205pgx.3
 for <linuxppc-dev@ozlabs.org>; Sun, 04 Dec 2016 22:32:19 -0800 (PST)
Subject: Re: [PATCH v2] powerpc/powernv: Initialise nest mmu
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1480903162-1986-1-git-send-email-mpe@ellerman.id.au>
Cc: alistair@popple.id.au
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <dd699260-28a9-ccf3-3159-c127e819724f@gmail.com>
Date: Mon, 5 Dec 2016 17:32:13 +1100
MIME-Version: 1.0
In-Reply-To: <1480903162-1986-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/12/16 12:59, Michael Ellerman wrote:
> From: Alistair Popple <alistair@popple.id.au>
> 
> POWER9 contains an off core mmu called the nest mmu (NMMU). This is used
> by other hardware units on the chip to translate virtual addresses into
> real addresses. The unit attempting an address translation provides the
> majority of the context required for the translation request except for
> the base address of the partition table (ie. the PTCR) which needs to be
> programmed into the NMMU.
> 
> This patch adds a call to OPAL to set the PTCR for the nest mmu in
> opal_init().
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
