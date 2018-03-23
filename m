Return-Path: <kernelfans@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406sWy3QdszF20K
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 16:28:30 +1100 (AEDT)
Received: by mail-qk0-x242.google.com with SMTP id s188so11763257qkb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 22:28:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521088912-31742-1-git-send-email-kernelfans@gmail.com>
References: <1521088912-31742-1-git-send-email-kernelfans@gmail.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Fri, 23 Mar 2018 13:28:27 +0800
Message-ID: <CAFgQCTu3NRA1vi6auftHeXBWvPWgZRRURLHB6u7ih0TnkrzXrQ@mail.gmail.com>
Subject: Re: [PATCHv5 0/3] enable nr_cpus for powerpc
To: linuxppc-dev@lists.ozlabs.org
Cc: cascardo@canonical.com, gpiccoli@linux.vnet.ibm.com,
 kexec@lists.infradead.org, paulus@ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Maintainers, ping? Any comment?

Thanks

On Thu, Mar 15, 2018 at 12:41 PM, Pingfan Liu <kernelfans@gmail.com> wrote:
> This topic has a very long history. It comes from Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> For v3: https://patchwork.ozlabs.org/patch/834860/
> I hope we can acquire it for "kexec -p" soon.
>
> V4->V5:
>   improve the [1/3] implementation based on Benjamin's suggestion.
>
> Mahesh Salgaonkar (1):
>   ppc64 boot: Wait for boot cpu to show up if nr_cpus limit is about to
>     hit.
>
> Pingfan Liu (2):
>   powerpc, cpu: partially unbind the mapping between cpu logical id and
>        its seq in dt
>   powerpc, cpu: handling the special case when boot_cpuid greater than
>     nr_cpus
>
>  arch/powerpc/include/asm/paca.h    |  3 +++
>  arch/powerpc/include/asm/smp.h     |  2 ++
>  arch/powerpc/kernel/paca.c         | 19 ++++++++++++++-----
>  arch/powerpc/kernel/prom.c         | 27 ++++++++++++++++-----------
>  arch/powerpc/kernel/setup-common.c | 35 ++++++++++++++++++++++++++++++++---
>  5 files changed, 67 insertions(+), 19 deletions(-)
>
> --
> 2.7.4
>
