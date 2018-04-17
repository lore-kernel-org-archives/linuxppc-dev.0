Return-Path: <arndbergmann@gmail.com>
Received: from mail-qk0-x22b.google.com (mail-qk0-x22b.google.com
 [IPv6:2607:f8b0:400d:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QbKC0pN5zF1t4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 05:43:42 +1000 (AEST)
Received: by mail-qk0-x22b.google.com with SMTP id d74so7152877qkg.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 12:43:42 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180417192038.GA22918@jordon-HP-15-Notebook-PC>
References: <20180417192038.GA22918@jordon-HP-15-Notebook-PC>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 17 Apr 2018 21:43:39 +0200
Message-ID: <CAK8P3a1TTEmcwK137k-rfZE45hD6k7tjEfN191cid_SB0JPNEQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: platform: cell: spufs: Change return type to
 vm_fault_t
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Jeremy Kerr <jk@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 17, 2018 at 9:20 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
>
> Reference id -> 1c8f422059ae ("mm: change return type to
> vm_fault_t")
>
> Previously vm_insert_pfn() returns err but driver returns
> VM_FAULT_NOPAGE as default. The new function vmf_insert_pfn()
> will replace this inefficiency by returning correct VM_FAULT_*
> type.
>
> vmf_handle_error is a inline wrapper function which
> will convert error number to vm_fault_t type err.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
