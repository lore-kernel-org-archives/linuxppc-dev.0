Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F3FC67839
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:38:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1013020672
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1013020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DvwZ0PgQzDqww
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 09:38:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dvt90xgVzDqgr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 09:36:00 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43Dvt552Hyz9v0sf;
 Tue, 11 Dec 2018 23:35:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id NI1FU9vU4HYX; Tue, 11 Dec 2018 23:35:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43Dvt54Kt9z9v0sd;
 Tue, 11 Dec 2018 23:35:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D6A0C8B818;
 Tue, 11 Dec 2018 23:35:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id sEqgcCw2Vryf; Tue, 11 Dec 2018 23:35:57 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C20888B812;
 Tue, 11 Dec 2018 23:35:56 +0100 (CET)
Subject: Re: [powerpc:next-test 70/71] arch/powerpc/include/asm/io.h:835:22:
 note: in expansion of macro 'page_to_pfn'
To: Michael Ellerman <mpe@ellerman.id.au>
References: <201812120556.nmhtmKEU%fengguang.wu@intel.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <75eeb99c-9947-7c3d-ed81-1626de6befe6@c-s.fr>
Date: Tue, 11 Dec 2018 23:35:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <201812120556.nmhtmKEU%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, kbuild-all@01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Missing linux/mm.h

Will fix it in the coming patch.

Christophe

Le 11/12/2018 à 22:55, kbuild test robot a écrit :
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next-test
> head:   13fd174be1903cc069bb73b0d53a0420b8f6d778
> commit: 3a0f466ce2402cc090c97ccc1285508f688d8a8e [70/71] powerpc: Implement CONFIG_DEBUG_VIRTUAL
> config: powerpc-ps3_petitboot_nfs_defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout 3a0f466ce2402cc090c97ccc1285508f688d8a8e
>          # save the attached .config to linux build tree
>          GCC_VERSION=7.2.0 make.cross ARCH=powerpc
> 
> All warnings (new ones prefixed by >>):
> 
>     In file included from arch/powerpc/include/asm/page.h:339:0,
>                      from arch/powerpc/include/asm/thread_info.h:29,
>                      from include/linux/thread_info.h:38,
>                      from include/asm-generic/preempt.h:5,
>                      from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                      from include/linux/preempt.h:81,
>                      from include/linux/spinlock.h:51,
>                      from include/linux/seqlock.h:36,
>                      from include/linux/time.h:6,
>                      from include/linux/jiffies.h:9,
>                      from drivers/net/loopback.c:32:
>     arch/powerpc/include/asm/io.h: In function 'page_to_phys':
>     include/asm-generic/memory_model.h:64:14: error: implicit declaration of function 'page_to_section'; did you mean '__nr_to_section'? [-Werror=implicit-function-declaration]
>       int __sec = page_to_section(__pg);   \
>                   ^
>     include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>      #define page_to_pfn __page_to_pfn
>                          ^~~~~~~~~~~~~
>>> arch/powerpc/include/asm/io.h:835:22: note: in expansion of macro 'page_to_pfn'
>       unsigned long pfn = page_to_pfn(page);
>                           ^~~~~~~~~~~
>     In file included from include/linux/scatterlist.h:8:0,
>                      from include/linux/dma-mapping.h:11,
>                      from include/linux/skbuff.h:34,
>                      from include/net/net_namespace.h:36,
>                      from include/linux/inet.h:46,
>                      from drivers/net/loopback.c:46:
>     include/linux/mm.h: At top level:
>     include/linux/mm.h:1121:29: error: conflicting types for 'page_to_section'
>      static inline unsigned long page_to_section(const struct page *page)
>                                  ^~~~~~~~~~~~~~~
>     In file included from arch/powerpc/include/asm/page.h:339:0,
>                      from arch/powerpc/include/asm/thread_info.h:29,
>                      from include/linux/thread_info.h:38,
>                      from include/asm-generic/preempt.h:5,
>                      from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                      from include/linux/preempt.h:81,
>                      from include/linux/spinlock.h:51,
>                      from include/linux/seqlock.h:36,
>                      from include/linux/time.h:6,
>                      from include/linux/jiffies.h:9,
>                      from drivers/net/loopback.c:32:
>     include/asm-generic/memory_model.h:64:14: note: previous implicit declaration of 'page_to_section' was here
>       int __sec = page_to_section(__pg);   \
>                   ^
>     include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>      #define page_to_pfn __page_to_pfn
>                          ^~~~~~~~~~~~~
>>> arch/powerpc/include/asm/io.h:835:22: note: in expansion of macro 'page_to_pfn'
>       unsigned long pfn = page_to_pfn(page);
>                           ^~~~~~~~~~~
>     cc1: some warnings being treated as errors
> --
>     In file included from arch/powerpc/include/asm/page.h:339:0,
>                      from arch/powerpc/include/asm/book3s/64/mmu.h:5,
>                      from arch/powerpc/include/asm/mmu.h:328,
>                      from arch/powerpc/include/asm/lppaca.h:36,
>                      from arch/powerpc/include/asm/paca.h:21,
>                      from arch/powerpc/include/asm/current.h:16,
>                      from include/linux/mutex.h:14,
>                      from include/linux/kernfs.h:13,
>                      from include/linux/sysfs.h:16,
>                      from include/linux/kobject.h:20,
>                      from include/linux/device.h:16,
>                      from drivers/of/irq.c:19:
>     arch/powerpc/include/asm/io.h: In function 'page_to_phys':
>     include/asm-generic/memory_model.h:64:14: error: implicit declaration of function 'page_to_section'; did you mean '__nr_to_section'? [-Werror=implicit-function-declaration]
>       int __sec = page_to_section(__pg);   \
>                   ^
>     include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>      #define page_to_pfn __page_to_pfn
>                          ^~~~~~~~~~~~~
>>> arch/powerpc/include/asm/io.h:835:22: note: in expansion of macro 'page_to_pfn'
>       unsigned long pfn = page_to_pfn(page);
>                           ^~~~~~~~~~~
>     cc1: some warnings being treated as errors
> --
>     In file included from arch/powerpc/include/asm/page.h:339:0,
>                      from arch/powerpc/include/asm/thread_info.h:29,
>                      from include/linux/thread_info.h:38,
>                      from include/asm-generic/preempt.h:5,
>                      from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                      from include/linux/preempt.h:81,
>                      from include/linux/hardirq.h:5,
>                      from arch/powerpc/kernel/mce.c:25:
>     arch/powerpc/include/asm/io.h: In function 'page_to_phys':
>     include/asm-generic/memory_model.h:64:14: error: implicit declaration of function 'page_to_section'; did you mean '__nr_to_section'? [-Werror=implicit-function-declaration]
>       int __sec = page_to_section(__pg);   \
>                   ^
>     include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>      #define page_to_pfn __page_to_pfn
>                          ^~~~~~~~~~~~~
>>> arch/powerpc/include/asm/io.h:835:22: note: in expansion of macro 'page_to_pfn'
>       unsigned long pfn = page_to_pfn(page);
>                           ^~~~~~~~~~~
>     In file included from include/linux/pid_namespace.h:7:0,
>                      from include/linux/ptrace.h:10,
>                      from arch/powerpc/kernel/mce.c:27:
>     include/linux/mm.h: At top level:
>     include/linux/mm.h:1121:29: error: conflicting types for 'page_to_section'
>      static inline unsigned long page_to_section(const struct page *page)
>                                  ^~~~~~~~~~~~~~~
>     In file included from arch/powerpc/include/asm/page.h:339:0,
>                      from arch/powerpc/include/asm/thread_info.h:29,
>                      from include/linux/thread_info.h:38,
>                      from include/asm-generic/preempt.h:5,
>                      from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                      from include/linux/preempt.h:81,
>                      from include/linux/hardirq.h:5,
>                      from arch/powerpc/kernel/mce.c:25:
>     include/asm-generic/memory_model.h:64:14: note: previous implicit declaration of 'page_to_section' was here
>       int __sec = page_to_section(__pg);   \
>                   ^
>     include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>      #define page_to_pfn __page_to_pfn
>                          ^~~~~~~~~~~~~
>>> arch/powerpc/include/asm/io.h:835:22: note: in expansion of macro 'page_to_pfn'
>       unsigned long pfn = page_to_pfn(page);
>                           ^~~~~~~~~~~
>     cc1: all warnings being treated as errors
> --
>     In file included from arch/powerpc/include/asm/page.h:339:0,
>                      from arch/powerpc/include/asm/book3s/64/mmu.h:5,
>                      from arch/powerpc/include/asm/mmu.h:328,
>                      from arch/powerpc/include/asm/lppaca.h:36,
>                      from arch/powerpc/include/asm/paca.h:21,
>                      from arch/powerpc/include/asm/current.h:16,
>                      from include/linux/sched.h:12,
>                      from arch/powerpc/kernel/cputable.c:14:
>     arch/powerpc/include/asm/io.h: In function 'page_to_phys':
>     include/asm-generic/memory_model.h:64:14: error: implicit declaration of function 'page_to_section'; did you mean '__nr_to_section'? [-Werror=implicit-function-declaration]
>       int __sec = page_to_section(__pg);   \
>                   ^
>     include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>      #define page_to_pfn __page_to_pfn
>                          ^~~~~~~~~~~~~
>>> arch/powerpc/include/asm/io.h:835:22: note: in expansion of macro 'page_to_pfn'
>       unsigned long pfn = page_to_pfn(page);
>                           ^~~~~~~~~~~
>     cc1: all warnings being treated as errors
> 
> vim +/page_to_pfn +835 arch/powerpc/include/asm/io.h
> 
>     829	
>     830	/*
>     831	 * Change "struct page" to physical address.
>     832	 */
>     833	static inline phys_addr_t page_to_phys(struct page *page)
>     834	{
>   > 835		unsigned long pfn = page_to_pfn(page);
>     836	
>     837		WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !pfn_valid(pfn));
>     838	
>     839		return PFN_PHYS(pfn);
>     840	}
>     841	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
