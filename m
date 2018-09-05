Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42596r46gMzF3FZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 03:04:52 +1000 (AEST)
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B882420879
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 17:04:49 +0000 (UTC)
Received: by mail-wm0-f48.google.com with SMTP id j25-v6so14485128wmc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 10:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-8-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1536163184-26356-8-git-send-email-rppt@linux.vnet.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Sep 2018 12:04:36 -0500
Message-ID: <CABGGiswdb1x-=vqrgxZ9i2dnLdsgtXq4+5H9Y1JRd90YVMW69A@mail.gmail.com>
Subject: Re: [RFC PATCH 07/29] memblock: remove _virt from APIs returning
 virtual address
To: rppt@linux.vnet.ibm.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 davem@davemloft.net,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mingo@redhat.com,
 Michael Ellerman <mpe@ellerman.id.au>, mhocko@suse.com, paul.burton@mips.com,
 Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
 linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 5, 2018 at 11:00 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> The conversion is done using
>
> sed -i 's@memblock_virt_alloc@memblock_alloc@g' \
>         $(git grep -l memblock_virt_alloc)

What's the reason to do this? It seems like a lot of churn even if a
mechanical change.

Rob
