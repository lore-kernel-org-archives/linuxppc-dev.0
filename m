Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wgPtY6jsdzDqKc
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Jun 2017 14:22:29 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id u26so16936770pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Jun 2017 21:22:29 -0700 (PDT)
Date: Sun, 4 Jun 2017 14:22:14 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, labbott@redhat.com, rashmica.g@gmail.com
Subject: Re: [PATCH v2 5/9] powerpc/vmlinux.lds: Align __init_begin to 16M
Message-ID: <20170604142205.4c66c31b@roar.ozlabs.ibm.com>
In-Reply-To: <20170603071843.11966-6-bsingharora@gmail.com>
References: <20170603071843.11966-1-bsingharora@gmail.com>
 <20170603071843.11966-6-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat,  3 Jun 2017 17:18:39 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> For CONFIG_STRICT_KERNEL_RWX align __init_begin to 16M.
> We use 16M since its the larger of 2M on radix and 16M
> on hash for our linear mapping. The plan is to have
> .text, .rodata and everything upto __init_begin marked
> as RX. Note we still have executable read only data.
> We could further align read only data to another 16M
> boundary, but then the linker starts using stubs and
> that breaks our assembler code in head_64.S

Is this still the case with powerpc next?

Thanks,
Nick
