Return-Path: <rientjes@google.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LK8G5kllzDqZH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 06:51:10 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id y12-v6so8188241plt.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 13:51:10 -0700 (PDT)
Date: Tue, 10 Apr 2018 13:51:06 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 mhocko@kernel.org, aneesh.kumar@linux.vnet.ibm.com,
 akpm@linux-foundation.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>,
 Albert Ou <albert@sifive.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 1/2] mm: introduce ARCH_HAS_PTE_SPECIAL
In-Reply-To: <a732ef2b-445f-9ad8-014b-247c8c5d500b@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.21.1804101350250.79494@chino.kir.corp.google.com>
References: <1523373951-10981-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523373951-10981-2-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180410160932.GB3614@bombadil.infradead.org>
 <a732ef2b-445f-9ad8-014b-247c8c5d500b@linux.vnet.ibm.com>
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

On Tue, 10 Apr 2018, Laurent Dufour wrote:

> > On Tue, Apr 10, 2018 at 05:25:50PM +0200, Laurent Dufour wrote:
> >>  arch/powerpc/include/asm/pte-common.h                  | 3 ---
> >>  arch/riscv/Kconfig                                     | 1 +
> >>  arch/s390/Kconfig                                      | 1 +
> > 
> > You forgot to delete __HAVE_ARCH_PTE_SPECIAL from
> > arch/riscv/include/asm/pgtable-bits.h
> 
> Damned !
> Thanks for catching it.
> 

Squashing the two patches together at least allowed it to be caught 
easily.  After it's fixed, feel free to add

	Acked-by: David Rientjes <rientjes@google.com>

Thanks for doing this!
