Return-Path: <kernelfans@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bMyq6j7yzF2QT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 12:43:14 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id f65-v6so11676213itd.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 May 2018 19:43:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523860508-19364-1-git-send-email-kernelfans@gmail.com>
References: <1523860508-19364-1-git-send-email-kernelfans@gmail.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 2 May 2018 10:43:11 +0800
Message-ID: <CAFgQCTsygvptdcEqvmEFeUumiSaV+Zebm3XTOmovmFujgNE5kw@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] post the event cpux add/remove besides
 online/offline during hotplug
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Maintainers, ping? Any suggestion? I encounter such issue on redhat
RHEL and FEDORA

On Mon, Apr 16, 2018 at 2:35 PM, Pingfan Liu <kernelfans@gmail.com> wrote:
> v1->v2:
>    -1.improve the commit log and explain the reproducing of bug in [3/3]
>    -2.re-fragment the series, and [3/3] is the motivation, while [1~2/3] are preparation.
>
> Pingfan Liu (3):
>   powerpc/cpuidle: dynamically register/unregister cpuidle_device during
>     hotplug
>   powerpc/cpu: dynmamically to create/destroy the file physical_id
>     during hotplug
>   powerpc/cpu: post the event cpux add/remove instead of online/offline
>     during hotplug
>
>  arch/powerpc/include/asm/smp.h               |  1 +
>  arch/powerpc/kernel/sysfs.c                  | 26 ++++++++++++++------------
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |  3 +++
>  drivers/cpuidle/cpuidle-powernv.c            |  2 ++
>  drivers/cpuidle/cpuidle-pseries.c            |  2 ++
>  5 files changed, 22 insertions(+), 12 deletions(-)
>
> --
> 2.7.4
>
