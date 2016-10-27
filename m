Return-Path: <0x7f454c46@gmail.com>
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com
 [IPv6:2a00:1450:400c:c09::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4YRn6wx4zDvPJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 04:15:17 +1100 (AEDT)
Received: by mail-wm0-x22f.google.com with SMTP id n67so60401689wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 10:15:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161025155106.29946-1-dsafonov@virtuozzo.com>
References: <20161025155106.29946-1-dsafonov@virtuozzo.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 27 Oct 2016 20:14:54 +0300
Message-ID: <CAJwJo6ZC=Z0RsjRgt8W1USuk0fp5_bJJHeQuKXHH50bBSNbd3g@mail.gmail.com>
Subject: Re: [PATCH 0/7] powerpc/mm: refactor vDSO mapping code
To: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: open list <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Andy Lutomirski <luto@amacapital.net>,
 Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2016-10-25 18:50 GMT+03:00 Dmitry Safonov <dsafonov@virtuozzo.com>:
> Cleanup patches for vDSO on powerpc.
> Originally, I wanted to add vDSO remapping on arm/aarch64 and
> I decided to cleanup that part on powerpc.
> I've add a hook for vm_ops for vDSO just like I did for x86.
> Other changes - reduce exhaustive code duplication.
> No visible to userspace changes expected.
>
> Tested on qemu with buildroot rootfs.
>
> Dmitry Safonov (7):
>   powerpc/vdso: unify return paths in setup_additional_pages
>   powerpc/vdso: remove unused params in vdso_do_func_patch{32,64}
>   powerpc/vdso: separate common code in vdso_common
>   powerpc/vdso: introduce init_vdso{32,64}_pagelist
>   powerpc/vdso: split map_vdso from arch_setup_additional_pages
>   powerpc/vdso: switch from legacy_special_mapping_vmops
>   mm: kill arch_mremap

Ignore this version, please - I've just sent v3 with some new fixes.
