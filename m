Return-Path: <bsingharora@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNM5M08jWzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 17:24:54 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id x77so501475qka.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Aug 2017 00:24:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1501679953.git.christophe.leroy@c-s.fr>
References: <cover.1501679953.git.christophe.leroy@c-s.fr>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 3 Aug 2017 17:24:52 +1000
Message-ID: <CAKTCnz=Bzb4rrq8qvmnV=LvM6hPxE59V4++qgmRFXs4-Ec+prw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] powerpc/mm: Fix kernel protection and implement
 STRICT_KERNEL_RWX on PPC32
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 2, 2017 at 11:50 PM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> This patch set implements STRICT_KERNEL_RWX on Powerpc32
> after fixing a few issues related to kernel code page protection.
>
> At the end we take the opportunity to get rid of some unneccessary/outdated
> fixmap stuff.

I looked at it, looks good overall, I've reviewed the previous series. Have you
checked the series against CONFIG_RELOCATABLE?

Balbir Singh.
