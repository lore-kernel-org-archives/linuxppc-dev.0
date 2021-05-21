Return-Path: <SRS0=GbMY=KQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA7AC433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 02:18:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA4761057
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 02:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA4761057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FmVdp5x4Bz3brt
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 12:18:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com;
 envelope-from=tanxiaofei@huawei.com; receiver=<UNKNOWN>)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FmVdP2S7gz2yXn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 May 2021 12:18:13 +1000 (AEST)
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FmVY55S5jzQpy7;
 Fri, 21 May 2021 10:14:33 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 10:18:05 +0800
Received: from [127.0.0.1] (10.40.192.162) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 21 May
 2021 10:18:05 +0800
Subject: Re: [PATCH 0/9] tty: hvc_console: Fix some coding style issues
To: Greg KH <gregkh@linuxfoundation.org>
References: <1621233433-27094-1-git-send-email-tanxiaofei@huawei.com>
 <YKZ8M8j5/bUJxLq5@kroah.com>
From: Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <ee765bed-f060-a31a-882f-4a8270366831@huawei.com>
Date: Fri, 21 May 2021 10:18:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YKZ8M8j5/bUJxLq5@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
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
Cc: linuxppc-dev@lists.ozlabs.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Greg,

On 2021/5/20 23:11, Greg KH wrote:
> On Mon, May 17, 2021 at 02:37:04PM +0800, Xiaofei Tan wrote:
>> Fix some issues reported by checkpatch.pl. All of them are
>> coding style issues, no function changes.
>>
>> Xiaofei Tan (9):
>>   tty: hvc_console: Fix spaces required around that '='
>>   tty: hvc_console: Fix "foo * bar" should be "foo *bar"
>>   tty: hvc_console: Remove trailing whitespace
>>   tty: hvc_console: Fix issues of code indent should use tabs
>>   tty: hvc_console: Delete spaces prohibited around open parenthesis '('
>>     and ')'
>>   tty: hvc_console: Fix coding style issues of block comments
>>   tty: hvc_console: Add a blank line after declarations
>>   tty: hvc_console: Remove the repeated words 'no' and 'from'
>>   tty: hvc_console: Move open brace { on the previous line
>>
>>  drivers/tty/hvc/hvc_console.c | 37 ++++++++++++++++++++++---------------
>>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> Do you use this driver?

No, i don't use it.

  If so, great, I'm sure there are other "real"
> issues in it that need some work.  But as Johan points out, doing
> drive-by checkpatch cleanups on random files that you do not use, isn't
> the best thing to do.
>

Sure

> If you just want to do this type of work, please do so in
> drivers/staging/ as it is most welcome there if you wish to get involved
> in kernel work to get experience before doing "real" stuff.
>

OK, thanks.

> thanks,
> g
> reg k-h
>
> .
>

