Return-Path: <jrdr.linux@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m1q04V1HzF258
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 14:36:28 +1000 (AEST)
Received: by mail-lf0-x241.google.com with SMTP id b18-v6so3484414lfa.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 21:36:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFqt6zY_X9obyM-ebLCWh7dL0bTMfXLP2U9QnkszbeJ2UZt8ww@mail.gmail.com>
References: <20180420173239.GA24560@jordon-HP-15-Notebook-PC>
 <20180420213435.GL10788@bombadil.infradead.org>
 <CAFqt6zY_X9obyM-ebLCWh7dL0bTMfXLP2U9QnkszbeJ2UZt8ww@mail.gmail.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 16 May 2018 10:06:24 +0530
Message-ID: <CAFqt6zbH8Jfvu+BA43j63fqbyOngzRd1e8hhN2TZ7CBJjdKhLQ@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: platform: cell: spufs: Change return type to
 vm_fault_t
To: Matthew Wilcox <willy@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Jeremy Kerr <jk@ozlabs.org>, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 10, 2018 at 8:35 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Sat, Apr 21, 2018 at 3:04 AM, Matthew Wilcox <willy@infradead.org> wrote:
>> On Fri, Apr 20, 2018 at 11:02:39PM +0530, Souptick Joarder wrote:
>>> Use new return type vm_fault_t for fault handler. For
>>> now, this is just documenting that the function returns
>>> a VM_FAULT value rather than an errno. Once all instances
>>> are converted, vm_fault_t will become a distinct type.
>>>
>>> Reference id -> 1c8f422059ae ("mm: change return type to
>>> vm_fault_t")
>>>
>>> We are fixing a minor bug, that the error from vm_insert_
>>> pfn() was being ignored and the effect of this is likely
>>> to be only felt in OOM situations.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>
> Any further comment on this patch ?

If no further comment, we would like to get this patch in queue
for 4.18.
