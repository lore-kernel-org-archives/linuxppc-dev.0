Return-Path: <B42677@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 069E12C009A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 15:05:45 +1000 (EST)
Message-ID: <5216EE5F.3060500@freescale.com>
Date: Fri, 23 Aug 2013 13:08:47 +0800
From: Zhang Haijun <B42677@freescale.com>
MIME-Version: 1.0
To: Chris <cjb@laptop.org>
Subject: Re: [PATCH 2/3 V3] mmc:sdhc: get voltage from sdhc host
References: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
 <1376271546-25085-4-git-send-email-Haijun.Zhang@freescale.com>
 <20130823014841.GD24803@teo>
In-Reply-To: <20130823014841.GD24803@teo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Anton Vorontsov <anton@enomsg.org>, linux-mmc@vger.kernel.org,
 Haijun Zhang <Haijun.Zhang@freescale.com>, scottwood@freescale.com,
 cjb@laptop.org, linuxppc-dev@lists.ozlabs.org, X.Xie@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Chris

Could help give some advice on this patch set ?

Thanks in advance.


On 08/23/2013 09:48 AM, Anton Vorontsov wrote:
> On Mon, Aug 12, 2013 at 09:39:06AM +0800, Haijun Zhang wrote:
>> We use host->ocr_mask to hold the voltage get from device-tree
>> node, In case host->ocr_mask was available, we use host->ocr_mask
>> as the final available voltage can be used by MMC/SD/SDIO card.
>>
>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>> ---
> Reviewed-by: Anton Vorontsov <anton@enomsg.org>
>


-- 
Thanks & Regards

Haijun
