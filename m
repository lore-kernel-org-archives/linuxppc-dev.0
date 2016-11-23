Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x233.google.com (mail-ua0-x233.google.com
 [IPv6:2607:f8b0:400c:c08::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP4HJ6jvQzDwDD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 01:20:12 +1100 (AEDT)
Received: by mail-ua0-x233.google.com with SMTP id b35so14822229uaa.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 06:20:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161123130840.1877-1-npiggin@gmail.com>
References: <20161123130840.1877-1-npiggin@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 24 Nov 2016 01:20:09 +1100
Message-ID: <CAKTCnz=naPROF+8BbbZ4STztNkDHHkyvWABoBk5z=Hrqaqr=6g@mail.gmail.com>
Subject: Re: [RFC][PATCH] powerpc/64be: use ELFv2 ABI for big endian kernels
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Alan Modra <amodra@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 24, 2016 at 12:08 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> Question, are there any fundamental reasons we shouldn't use the ELFv2
> ABI to build big endian kernels if the compiler supports it?
>

Does this have implications w.r.t interfaces to

1. openfirmware/skiboot
2. glibc/vdso

Keen to find out as well

Balbir Singh.
