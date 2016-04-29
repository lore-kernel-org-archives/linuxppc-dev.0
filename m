Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx31S19TZzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 15:59:24 +1000 (AEST)
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qx31R3NF3z9sBM
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Apr 2016 15:59:23 +1000 (AEST)
Received: by mail-pf0-x229.google.com with SMTP id c189so44325557pfb.3
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Apr 2016 22:59:23 -0700 (PDT)
Subject: Re: [PATCH] powerpc: Define and use PPC_ELF_ABI_v2
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1461836327-15417-1-git-send-email-mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5722F82F.6010707@gmail.com>
Date: Fri, 29 Apr 2016 15:59:11 +1000
MIME-Version: 1.0
In-Reply-To: <1461836327-15417-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 28/04/16 19:38, Michael Ellerman wrote:
> We're approaching 20 locations where we need to check for ELF ABI v2.
> That's fine, except the logic is a bit awkward, because we have to check
> that _CALL_ELF is defined and then what its value is.
> 
> So check it once in asm/types.h and define PPC_ELF_ABI_v2 when ELF ABI
> v2 is detected.
> 
> We don't add explicit includes of asm/types.h because it's included
> basically everywhere via compiler.h.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Makes sense

Acked-by: Balbir Singh <bsingharora@gmail.com>
