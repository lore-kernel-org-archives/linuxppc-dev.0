Return-Path: <green.hu@gmail.com>
Received: from mail-vk0-f66.google.com (mail-vk0-f66.google.com
 [209.85.213.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425Pm72SnCzF37J
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 12:34:27 +1000 (AEST)
Received: by mail-vk0-f66.google.com with SMTP id s17-v6so3487941vke.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 19:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Thu, 6 Sep 2018 10:33:48 +0800
Message-ID: <CAEbi=3dKL1zOYc0DC3yXm=7srw6tUfx-JR=o9n4pVrGp+Sosug@mail.gmail.com>
Subject: Re: [RFC PATCH 00/29] mm: remove bootmem allocator
To: rppt@linux.vnet.ibm.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Miller <davem@davemloft.net>, gregkh@linuxfoundation.org,
 mingo@redhat.com,
 mpe@ellerman.id.au, mhocko@suse.com, paul.burton@mips.com,
 Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
 linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux <sparclinux@vger.kernel.org>,
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

Mike Rapoport <rppt@linux.vnet.ibm.com> =E6=96=BC 2018=E5=B9=B49=E6=9C=886=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:04=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi,
>
> These patches switch early memory managment to use memblock directly
> without any bootmem compatibility wrappers. As the result both bootmem an=
d
> nobootmem are removed.
>
> There are still a couple of things to sort out, the most important is the
> removal of bootmem usage in MIPS.
>
> Still, IMHO, the series is in sufficient state to post and get the early
> feedback.
>
> The patches are build-tested with defconfig for most architectures (I
> couldn't find a compiler for nds32 and unicore32) and boot-tested on x86
> VM.
>
Hi Mike,

There are nds32 toolchains.
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/=
x86_64-gcc-8.1.0-nolibc-nds32le-linux.tar.gz
https://github.com/vincentzwc/prebuilt-nds32-toolchain/releases/download/20=
180521/nds32le-linux-glibc-v3-upstream.tar.gz

Sorry, we have no qemu yet.
