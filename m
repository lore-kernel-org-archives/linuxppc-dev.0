Return-Path: <SRS0=KHR7=NP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE3DC4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 16:35:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4456127B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 16:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C4456127B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GvF8901ncz2yx9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Aug 2021 02:35:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GvF7d2rw6z2xsB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Aug 2021 02:34:33 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GvF7V49s9z9sVj;
 Tue, 24 Aug 2021 18:34:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NNE9R10_fWol; Tue, 24 Aug 2021 18:34:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GvF7V39gHz9sV8;
 Tue, 24 Aug 2021 18:34:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F08B8B828;
 Tue, 24 Aug 2021 18:34:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 1icTG244R3t1; Tue, 24 Aug 2021 18:34:30 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C25C8B80A;
 Tue, 24 Aug 2021 18:34:29 +0200 (CEST)
Subject: Re: [PATCH linux-next] powerpc/tm: remove duplicate include in
 tm-poison.c
To: Shuah Khan <skhan@linuxfoundation.org>, cgel.zte@gmail.com,
 mpe@ellerman.id.au
References: <20210805065255.628170-1-yong.yiran@zte.com.cn>
 <c5e9900b-1c2d-8e72-ad83-a6024b876fd2@linuxfoundation.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4bc97c33-7fc0-ff9d-041b-e773f682c5d2@csgroup.eu>
Date: Tue, 24 Aug 2021 18:34:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c5e9900b-1c2d-8e72-ad83-a6024b876fd2@linuxfoundation.org>
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
Cc: yong.yiran@zte.com.cn, shuah@kernel.org, Zeal Robot <zealci@zte.com.cn>,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 24/08/2021 à 16:40, Shuah Khan a écrit :
> On 8/5/21 12:52 AM, cgel.zte@gmail.com wrote:
>> From: yong yiran <yong.yiran@zte.com.cn>
>>
>> 'inttypes.h' included in 'tm-poison.c' is duplicated.
>> Remove all but the first include of inttypes.h from tm-poison.c.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
>> ---
>>   tools/testing/selftests/powerpc/tm/tm-poison.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c 
>> b/tools/testing/selftests/powerpc/tm/tm-poison.c
>> index 29e5f26af7b9..27c083a03d1f 100644
>> --- a/tools/testing/selftests/powerpc/tm/tm-poison.c
>> +++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
>> @@ -20,7 +20,6 @@
>>   #include <sched.h>
>>   #include <sys/types.h>
>>   #include <signal.h>
>> -#include <inttypes.h>
>>   #include "tm.h"
>>
> 
> We can't accept this patch. The from and Signed-off-by don't match.
> 

As far as I can see they match. You have:

From: yong yiran <yong.yiran@zte.com.cn>
Signed-off-by: yong yiran <yong.yiran@zte.com.cn>

