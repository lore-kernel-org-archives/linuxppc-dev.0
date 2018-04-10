Return-Path: <palmer@sifive.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LK0x0GVHzF25X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 06:44:48 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id y12-v6so8178543plt.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 13:44:48 -0700 (PDT)
Date: Tue, 10 Apr 2018 13:44:46 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] mm: introduce ARCH_HAS_PTE_SPECIAL
In-Reply-To: <20180410160932.GB3614@bombadil.infradead.org>
CC: ldufour@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, jglisse@redhat.com,
 mhocko@kernel.org,
 aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org,
 paulus@samba.org, corbet@lwn.net, catalin.marinas@arm.com,
 Will Deacon <will.deacon@arm.com>,
 ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
 tglx@linutronix.de, mingo@redhat.com,
 vgupta@synopsys.com, albert@sifive.com, schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com, rientjes@google.com
From: Palmer Dabbelt <palmer@sifive.com>
To: willy@infradead.org
Message-ID: <mhng-dc76549e-6083-49a7-af3f-2638193f6698@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 10 Apr 2018 09:09:32 PDT (-0700), willy@infradead.org wrote:
> On Tue, Apr 10, 2018 at 05:25:50PM +0200, Laurent Dufour wrote:
>>  arch/powerpc/include/asm/pte-common.h                  | 3 ---
>>  arch/riscv/Kconfig                                     | 1 +
>>  arch/s390/Kconfig                                      | 1 +
>
> You forgot to delete __HAVE_ARCH_PTE_SPECIAL from
> arch/riscv/include/asm/pgtable-bits.h

Thanks -- I was looking for that but couldn't find it and assumed I'd just 
misunderstood something.
