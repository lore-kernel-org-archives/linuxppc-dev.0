Return-Path: <turtle.in.the.kernel@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VY0B1Y0MzF3HZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 07:12:54 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id 27-v6so1327200qkv.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 14:12:54 -0700 (PDT)
Subject: Re: [PATCH] powerpc/msi: Remove VLA usage
To: Kees Cook <keescook@chromium.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rob Herring <robh@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
References: <20180629185254.GA37557@beast>
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <911632d5-b54c-b632-75d9-7628a0cfc490@gmail.com>
Date: Tue, 17 Jul 2018 14:12:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180629185254.GA37557@beast>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2018 11:52 AM, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches from an unchanging variable to a constant expression to eliminate
> the VLA generation.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
