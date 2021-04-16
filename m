Return-Path: <SRS0=vApQ=JN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD72C433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Apr 2021 07:06:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072DD6108E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Apr 2021 07:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072DD6108E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FM6hS4kcnz3c3p
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Apr 2021 17:06:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FM6h50q34z2yhj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Apr 2021 17:06:27 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4FM6gz2hW5z9txLZ;
 Fri, 16 Apr 2021 09:06:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id kcQCt_FlgCZ1; Fri, 16 Apr 2021 09:06:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FM6gz1vR2zB09bR;
 Fri, 16 Apr 2021 09:06:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 368318B825;
 Fri, 16 Apr 2021 09:06:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 7PSlq-Zt6Xe5; Fri, 16 Apr 2021 09:06:24 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B3478B81A;
 Fri, 16 Apr 2021 09:06:23 +0200 (CEST)
Subject: Re: [PATCH] soc: fsl: qe: remove unused function
To: Daniel Axtens <dja@axtens.net>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, qiang.zhao@nxp.com
References: <1618475663-100748-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <87blaeg1ig.fsf@linkitivity.dja.id.au>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <76468b5b-0eb0-8772-b7b5-21bb708aa053@csgroup.eu>
Date: Fri, 16 Apr 2021 09:06:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <87blaeg1ig.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, leoyang.li@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 16/04/2021 à 08:57, Daniel Axtens a écrit :
> Hi Jiapeng,
> 
>> Fix the following clang warning:

You are not fixing a warning, you are removing a function in order to fix a warning ...

>>
>> drivers/soc/fsl/qe/qe_ic.c:234:29: warning: unused function
>> 'qe_ic_from_irq' [-Wunused-function].

Would be wise to tell that the last users of the function where removed by commit d7c2878cfcfa 
("soc: fsl: qe: remove unused qe_ic_set_* functions")

https://github.com/torvalds/linux/commit/d7c2878cfcfa

>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>> ---
>>   drivers/soc/fsl/qe/qe_ic.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
>> index 0390af9..b573712 100644
>> --- a/drivers/soc/fsl/qe/qe_ic.c
>> +++ b/drivers/soc/fsl/qe/qe_ic.c
>> @@ -231,11 +231,6 @@ static inline void qe_ic_write(__be32  __iomem *base, unsigned int reg,
>>   	qe_iowrite32be(value, base + (reg >> 2));
>>   }
>>   
>> -static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
>> -{
>> -	return irq_get_chip_data(virq);
>> -}
> 
> This seems good to me.
> 
>   * We know that this function can't be called directly from outside the
>    file, because it is static.
> 
>   * The function address isn't used as a function pointer anywhere, so
>     that means it can't be called from outside the file that way (also
>     it's inline, which would make using a function pointer unwise!)
> 
>   * There's no obvious macros in that file that might construct the name
>     of the function in a way that is hidden from grep.
> 
> All in all, I am fairly confident that the function is indeed not used.
> 
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> 
> Kind regards,
> Daniel
> 
>> -
>>   static inline struct qe_ic *qe_ic_from_irq_data(struct irq_data *d)
>>   {
>>   	return irq_data_get_irq_chip_data(d);
>> -- 
>> 1.8.3.1
