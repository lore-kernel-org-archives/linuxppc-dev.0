Return-Path: <SRS0=7qm+=JF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA98C433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 07:20:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED7261057
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 07:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED7261057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FGCNS3xJCz3bvh
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 17:20:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com;
 envelope-from=johnny.chenyi@huawei.com; receiver=<UNKNOWN>)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FGCN46mkSz2yYt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Apr 2021 17:20:35 +1000 (AEST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGCKK3QS6zyNNs;
 Thu,  8 Apr 2021 15:18:13 +0800 (CST)
Received: from [10.67.108.130] (10.67.108.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 15:20:16 +0800
Subject: Re: [PATCH-next] powerpc/interrupt: Remove duplicate header file
To: Christophe Leroy <christophe.leroy@csgroup.eu>, <mpe@ellerman.id.au>,
 <benh@kernel.crashing.org>, <paulus@samba.org>, <npiggin@gmail.com>,
 <aneesh.kumar@linux.ibm.com>
References: <20210408035644.2417002-1-johnny.chenyi@huawei.com>
 <c42ebf38-c7ea-68bc-01ca-8352581bc33d@csgroup.eu>
From: "Chenyi (Johnny)" <johnny.chenyi@huawei.com>
Message-ID: <96c6a5b6-ec8f-c9cc-159b-38ca21eea98a@huawei.com>
Date: Thu, 8 Apr 2021 15:20:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c42ebf38-c7ea-68bc-01ca-8352581bc33d@csgroup.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.130]
X-CFilter-Loop: Reflected
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
Cc: yuehaibing@huawei.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, heying24@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



在 2021/4/8 12:57, Christophe Leroy 写道:
> 
> 
> Le 08/04/2021 à 05:56, johnny.chenyi@huawei.com a écrit :
>> From: Chen Yi <johnny.chenyi@huawei.com>
>>
>> Delete one of the header files <asm/interrupt.h> that are included
>> twice.
> 
> Guys, we have been flooded with such tiny patches over the last weeks, 
> some changes being sent several times by different people.
> 
> That one is included in 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210323062916.295346-1-wanjiabing@vivo.com/ 
> 
> 
> And was already submitted a few hours earlier by someone else: 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1616464656-59372-1-git-send-email-zhouchuangao@vivo.com/ 
> 
> 
> Could you work all together and cook an overall patch including all 
> duplicate removal from arch/powerpc/ files ?
> 
> Best way would be I think to file an issue at 
> https://github.com/linuxppc/issues/issues , then you do a complete 
> analysis and list in the issue all places to be modified, then once the 
> analysis is complete you send a full single patch.
> 
> Thanks
> Christophe
>
Dear Christophe,
	Thanks for your reply, I have checked that thers is no header files 
which has been included twice by mistake in arch/powerpc/.I would file 
an issue next time.

Best regards,
Chen Yi


>>
>> Signed-off-by: Chen Yi <johnny.chenyi@huawei.com>
>> ---
>>   arch/powerpc/kernel/interrupt.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/interrupt.c 
>> b/arch/powerpc/kernel/interrupt.c
>> index c4dd4b8f9cfa..f64ace0208b7 100644
>> --- a/arch/powerpc/kernel/interrupt.c
>> +++ b/arch/powerpc/kernel/interrupt.c
>> @@ -7,7 +7,6 @@
>>   #include <asm/asm-prototypes.h>
>>   #include <asm/kup.h>
>>   #include <asm/cputime.h>
>> -#include <asm/interrupt.h>
>>   #include <asm/hw_irq.h>
>>   #include <asm/interrupt.h>
>>   #include <asm/kprobes.h>
>>
> .
