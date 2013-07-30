Return-Path: <B42677@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D31392C0096
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 11:34:06 +1000 (EST)
Message-ID: <51F71825.9000904@freescale.com>
Date: Tue, 30 Jul 2013 09:34:29 +0800
From: Zhang Haijun <B42677@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] mmc:core: parse voltage from device-tree
References: <1375066595-14968-1-git-send-email-Haijun.Zhang@freescale.com>
 <1375135638.30721.58@snotra>
In-Reply-To: <1375135638.30721.58@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linux-mmc@vger.kernel.org, AFLEMING@freescale.com,
 Xie Xiaobo-R63061 <X.Xie@freescale.com>, cbouatmailru@gmail.com,
 cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2013 06:07 AM, Scott Wood wrote:
> On 07/28/2013 09:56:33 PM, Haijun Zhang wrote:
>> Add function to support get voltage from device-tree.
>> If there are voltage-range specified in device-tree node, this function
>> will parse it and return the avail voltage mask.
>>
>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>> ---
>>  drivers/mmc/core/core.c  | 48 
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mmc/core.h |  1 +
>>  2 files changed, 49 insertions(+)
>
> Move the code rather than copying it.
>
> -Scott
Hi, Scott

You mean?

-- 
Thanks & Regards

Haijun
