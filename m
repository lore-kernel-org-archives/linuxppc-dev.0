Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91333C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Aug 2021 05:32:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF33F60E53
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Aug 2021 05:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF33F60E53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GfgNK2xGfz3cVM
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Aug 2021 15:32:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GfgMx75Pxz2yNx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Aug 2021 15:31:40 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GfgMt1jwCz9sWD;
 Wed,  4 Aug 2021 07:31:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v2_EiRzS62_q; Wed,  4 Aug 2021 07:31:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GfgMt0jjFz9sVr;
 Wed,  4 Aug 2021 07:31:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E9F118B790;
 Wed,  4 Aug 2021 07:31:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id U1PdDfzNf9zb; Wed,  4 Aug 2021 07:31:37 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 78D118B764;
 Wed,  4 Aug 2021 07:31:37 +0200 (CEST)
Subject: Re: undefined reference to `.radix__create_section_mapping'
To: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>,
 Jordan Niethe <jniethe5@gmail.com>
References: <202108010251.C4jhEEBW-lkp@intel.com>
 <082eea82-c788-72e0-f6a4-eadfb54d1231@infradead.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c4398495-a50a-a749-6679-7510ed862db2@csgroup.eu>
Date: Wed, 4 Aug 2021 07:31:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <082eea82-c788-72e0-f6a4-eadfb54d1231@infradead.org>
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Randy,

Le 04/08/2021 à 04:40, Randy Dunlap a écrit :
> On 7/31/21 11:22 AM, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   c7d102232649226a69dddd58a4942cf13cff4f7c
>> commit: fe3dc333d2ed50c9764d281869d87bae0d795ce5 powerpc/mmu: Don't duplicate radix_enabled()
>> date:   3 months ago
>> config: powerpc64-randconfig-r013-20210731 (attached as .config)
>> compiler: powerpc-linux-gcc (GCC) 10.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O 
>> ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fe3dc333d2ed50c9764d281869d87bae0d795ce5 
>>
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout fe3dc333d2ed50c9764d281869d87bae0d795ce5
>>          # save the attached .config to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=powerpc 
>> SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     powerpc-linux-ld: arch/powerpc/mm/book3s64/pgtable.o: in function `.create_section_mapping':
>>>> (.meminit.text+0x3c): undefined reference to `.radix__create_section_mapping'
>>     powerpc-linux-ld: arch/powerpc/mm/book3s64/pgtable.o: in function `.remove_section_mapping':
>>>> (.meminit.text+0x90): undefined reference to `.radix__remove_section_mapping'
> 
> In the randconfig file:
> # CONFIG_PPC_RADIX_MMU is not set
> 
> It is default y, but maybe that is not strong enough?
> I.e., should it be selected by PPC_BOOK3S_64?
> 
> Changing the config to PPC_RADIX_MMU=y fixes the build errors.
> 
> Or should arch/powerpc/mm/book3s64/pgtable.c be modified to handle
> the case of PPC_RADIX_MMU is not set?
> 

Can you test 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210804013724.514468-1-jniethe5@gmail.com/ ?

Thanks
Christophe
