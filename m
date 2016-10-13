Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svnPX3XqjzDsyJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 21:42:56 +1100 (AEDT)
Received: by mail-pa0-x241.google.com with SMTP id os4so566648pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 03:42:56 -0700 (PDT)
Subject: Re: [PATCH] powerpc: make _ASM_NOKPROBE_SYMBOL a noop when KPROBES
 not defined
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20161013020714.5629-1-npiggin@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <2d8ddfa0-6404-b4fe-2836-0b7e57773956@gmail.com>
Date: Thu, 13 Oct 2016 21:42:52 +1100
MIME-Version: 1.0
In-Reply-To: <20161013020714.5629-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 13/10/16 13:07, Nicholas Piggin wrote:
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> The linker orphan sections error patch caught this

Seems reasonable

Acked-by: Balbir Singh <bsingharora@gmail.com>
