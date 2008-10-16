Return-Path: <jeremy@goop.org>
Received: from mail.goop.org (gw.goop.org [64.81.55.164])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2CD2FDE3C7
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 03:20:59 +1100 (EST)
Message-ID: <48F767C5.8000207@goop.org>
Date: Thu, 16 Oct 2008 09:11:49 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next:  build failure
References: <20081016202907.978d00b1.sfr@canb.auug.org.au>
	<20081016103916.GA30745@elte.hu>
In-Reply-To: <20081016103916.GA30745@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-next@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ingo Molnar wrote:
> * Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
>   
>> Hi all,
>>
>> Today's linux-next build (powerpc allyesconfig) failed like this:
>>
>> In file included from arch/powerpc/include/asm/mmu-hash64.h:17,
>>                  from arch/powerpc/include/asm/mmu.h:8,
>>                  from arch/powerpc/include/asm/pgtable.h:8,
>>                  from arch/powerpc/mm/slb.c:20:
>> arch/powerpc/include/asm/page.h:76: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'memstart_addr'
>> arch/powerpc/include/asm/page.h:77: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'kernstart_addr'
>>
>> Caused by commit 600715dcdf567c86f8b2c6173fcfb4b873e25a19 ("generic: add
>> phys_addr_t for holding physical addresses") from the tip-core tree.
>> This only fails if CONFIG_RELOCATABLE is set.
>>
>> I have applied the patch below.
>>     
>
> applied to tip/core/urgent, thanks Stephen!
>   

Shouldn't this go via a ppc tree?  Won't having ppc changes in tip.git 
make people grumpy?

    J
