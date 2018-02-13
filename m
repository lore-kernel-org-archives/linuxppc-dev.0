Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x233.google.com (mail-vk0-x233.google.com
 [IPv6:2607:f8b0:400c:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgWx62k46zF0bF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 16:55:54 +1100 (AEDT)
Received: by mail-vk0-x233.google.com with SMTP id j204so10207868vke.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 21:55:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5227513.IOhi8YYFsi@new-mexico>
References: <20171214011008.4388-1-bsingharora@gmail.com>
 <10851149.oduYqhiQfE@new-mexico> <5227513.IOhi8YYFsi@new-mexico>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 13 Feb 2018 16:55:46 +1100
Message-ID: <CAKTCnzkO+NWKDwj8RE_jX_N0uu-vY5HRf4AdkJyjsLvL1Loqhg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/npu: Cleanup MMIO ATSD flushing
To: Alistair Popple <alistair@popple.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 7, 2018 at 2:14 PM, Alistair Popple <alistair@popple.id.au> wrote:
> On Tuesday, 16 January 2018 3:15:05 PM AEDT Alistair Popple wrote:
>> Thanks Balbir, one question below. I have no way of testing this at present but
>> it looks ok to me. Thanks!
>
> The below are more future optimisations once we can test. So in the meantime:
>
> Acked-by: Alistair Popple <alistair@popple.id.au>

@aneesh can you please look at this? @mpe can we pick this up if there
are no objections?

Balbir Singh
