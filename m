Return-Path: <jrdr.linux@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hc3Z3MtGzF2DG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 01:05:30 +1000 (AEST)
Received: by mail-lf0-x241.google.com with SMTP id r2-v6so3457007lff.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 08:05:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180420213435.GL10788@bombadil.infradead.org>
References: <20180420173239.GA24560@jordon-HP-15-Notebook-PC>
 <20180420213435.GL10788@bombadil.infradead.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 10 May 2018 20:35:25 +0530
Message-ID: <CAFqt6zY_X9obyM-ebLCWh7dL0bTMfXLP2U9QnkszbeJ2UZt8ww@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: platform: cell: spufs: Change return type to
 vm_fault_t
To: Matthew Wilcox <willy@infradead.org>
Cc: Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 21, 2018 at 3:04 AM, Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Apr 20, 2018 at 11:02:39PM +0530, Souptick Joarder wrote:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Reference id -> 1c8f422059ae ("mm: change return type to
>> vm_fault_t")
>>
>> We are fixing a minor bug, that the error from vm_insert_
>> pfn() was being ignored and the effect of this is likely
>> to be only felt in OOM situations.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

Any further comment on this patch ?
