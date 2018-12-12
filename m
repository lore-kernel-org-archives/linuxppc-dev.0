Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06B6C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 07:26:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E862084E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 07:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E862084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43F7dg535MzDqhH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 18:25:59 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43F7bL4WC0zDqcq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 18:23:58 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43F7bG2m44z9v0fh;
 Wed, 12 Dec 2018 08:23:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 8p7d9sC_SBLC; Wed, 12 Dec 2018 08:23:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43F7bG295vz9v0fg;
 Wed, 12 Dec 2018 08:23:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 32B3C8B82B;
 Wed, 12 Dec 2018 08:23:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id RYNLHYF2Npl6; Wed, 12 Dec 2018 08:23:55 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CAD658B825;
 Wed, 12 Dec 2018 08:23:54 +0100 (CET)
Subject: Re: [powerpc:next-test 70/71]
 include/asm-generic/memory_model.h:55:54: error: 'vmemmap' undeclared; did
 you mean 'mem_map'?
To: Michael Ellerman <mpe@ellerman.id.au>
References: <201812121310.MnbC0L9L%fengguang.wu@intel.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <4bd298cc-a03a-5a01-aa2f-1ca8e6838fa3@c-s.fr>
Date: Wed, 12 Dec 2018 08:23:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <201812121310.MnbC0L9L%fengguang.wu@intel.com>
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

This one is already fixed in v2 and v3 by the addition of asm/pgtable.h

Christophe

Le 12/12/2018 à 06:36, kbuild test robot a écrit :
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next-test
> head:   13fd174be1903cc069bb73b0d53a0420b8f6d778
> commit: 3a0f466ce2402cc090c97ccc1285508f688d8a8e [70/71] powerpc: Implement CONFIG_DEBUG_VIRTUAL
> config: powerpc-ppc64e_defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout 3a0f466ce2402cc090c97ccc1285508f688d8a8e
>          # save the attached .config to linux build tree
>          GCC_VERSION=7.2.0 make.cross ARCH=powerpc
> 
> All errors (new ones prefixed by >>):
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
>                      from include/linux/stat.h:19,
>                      from include/linux/module.h:10,
>                      from init/do_mounts.c:1:
>     arch/powerpc/include/asm/io.h: In function 'page_to_phys':
>>> include/asm-generic/memory_model.h:55:54: error: 'vmemmap' undeclared (first use in this function); did you mean 'mem_map'?
>      #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
>                                                           ^
>     include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>      #define page_to_pfn __page_to_pfn
>                          ^~~~~~~~~~~~~
>     arch/powerpc/include/asm/io.h:835:22: note: in expansion of macro 'page_to_pfn'
>       unsigned long pfn = page_to_pfn(page);
>                           ^~~~~~~~~~~
>     include/asm-generic/memory_model.h:55:54: note: each undeclared identifier is reported only once for each function it appears in
>      #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
>                                                           ^
>     include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>      #define page_to_pfn __page_to_pfn
>                          ^~~~~~~~~~~~~
>     arch/powerpc/include/asm/io.h:835:22: note: in expansion of macro 'page_to_pfn'
>       unsigned long pfn = page_to_pfn(page);
>                           ^~~~~~~~~~~
> 
> vim +55 include/asm-generic/memory_model.h
> 
> 8f6aac41 Christoph Lameter  2007-10-16  52
> af901ca1 André Goddard Rosa 2009-11-14  53  /* memmap is virtually contiguous.  */
> 8f6aac41 Christoph Lameter  2007-10-16  54  #define __pfn_to_page(pfn)	(vmemmap + (pfn))
> 32272a26 Martin Schwidefsky 2008-12-25 @55  #define __page_to_pfn(page)	(unsigned long)((page) - vmemmap)
> 8f6aac41 Christoph Lameter  2007-10-16  56
> 
> :::::: The code at line 55 was first introduced by commit
> :::::: 32272a26974d2027384fd4010cd1780fca425d94 [S390] __page_to_pfn warnings
> 
> :::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
> :::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
