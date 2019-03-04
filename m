Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5DCC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 01:29:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265CC20830
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 01:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265CC20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CMrv5jLFzDqKS
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 12:29:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=yanaijie@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CMq64qMYzDq8F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 12:28:16 +1100 (AEDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 1E9C2AEB2488EBAC945B;
 Mon,  4 Mar 2019 09:28:09 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Mar 2019
 09:28:05 +0800
Subject: Re: [PATCH] powerpc: remove dead code in head_fsl_booke.S
To: Christophe Leroy <christophe.leroy@c-s.fr>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <mpe@ellerman.id.au>, <diana.craciun@nxp.com>,
 <linuxppc-dev@lists.ozlabs.org>
References: <20190228083121.30598-1-yanaijie@huawei.com>
 <cc1c7fdc-33b8-bebd-f5df-4c9b814e099e@c-s.fr>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <9d2ca3d3-d51b-3c9d-82cd-7feb0d96af99@huawei.com>
Date: Mon, 4 Mar 2019 09:28:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <cc1c7fdc-33b8-bebd-f5df-4c9b814e099e@c-s.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.203]
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2019/2/28 21:00, Christophe Leroy wrote:
> 
> 
> Le 28/02/2019 à 09:31, Jason Yan a écrit :
>> This code is dead. Just remove it.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> This review was easy :)
> 
> Christophe
> 

Christophe, thanks.


>> ---
>>   arch/powerpc/kernel/head_fsl_booke.S | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/head_fsl_booke.S 
>> b/arch/powerpc/kernel/head_fsl_booke.S
>> index 2386ce2a9c6e..b8450f017d85 100644
>> --- a/arch/powerpc/kernel/head_fsl_booke.S
>> +++ b/arch/powerpc/kernel/head_fsl_booke.S
>> @@ -194,13 +194,6 @@ set_ivor:
>>   #endif
>>       mtspr    SPRN_MAS4, r2
>> -#if 0
>> -    /* Enable DOZE */
>> -    mfspr    r2,SPRN_HID0
>> -    oris    r2,r2,HID0_DOZE@h
>> -    mtspr    SPRN_HID0, r2
>> -#endif
>> -
>>   #if !defined(CONFIG_BDI_SWITCH)
>>       /*
>>        * The Abatron BDI JTAG debugger does not tolerate others
>>
> 
> .
> 

