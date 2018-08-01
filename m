Return-Path: <alex@ghiti.fr>
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gWrV0chQzF10S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 21:52:18 +1000 (AEST)
Subject: Re: [PATCH v5 00/11] hugetlb: Factorize hugetlb architecture
 primitives
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: linux-mm@kvack.org, mike.kravetz@oracle.com, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
 fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
 jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
 tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
 arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
References: <20180731060155.16915-1-alex@ghiti.fr>
 <20180731160640.11306628@doriath>
From: Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <1cee9f98-4cff-3e42-6cc8-088310e406d9@ghiti.fr>
Date: Wed, 1 Aug 2018 13:50:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180731160640.11306628@doriath>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/31/2018 10:06 PM, Luiz Capitulino wrote:
> On Tue, 31 Jul 2018 06:01:44 +0000
> Alexandre Ghiti <alex@ghiti.fr> wrote:
>
>> [CC linux-mm for inclusion in -mm tree]
>>
>> In order to reduce copy/paste of functions across architectures and then
>> make riscv hugetlb port (and future ports) simpler and smaller, this
>> patchset intends to factorize the numerous hugetlb primitives that are
>> defined across all the architectures.
> [...]
>
>>   15 files changed, 139 insertions(+), 382 deletions(-)
> I imagine you're mostly interested in non-x86 review at this point, but
> as this series is looking amazing:
>
> Reviewed-by: Luiz Capitulino <lcapitulino@redhat.com>

It's always good to have another feedback :)
Thanks for your review Luiz,

Alex
