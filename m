Return-Path: <B31939@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2260F2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 12:23:16 +1000 (EST)
Received: from mail112-co9 (localhost [127.0.0.1])	by
 mail112-co9-R.bigfish.com (Postfix) with ESMTP id 721A3C000FE	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 02:23:12 +0000 (UTC)
Received: from CO9EHSMHS019.bigfish.com (unknown [10.236.132.232])	by
 mail112-co9.bigfish.com (Postfix) with ESMTP id 8925E4C0060	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 02:23:11 +0000 (UTC)
Message-ID: <51BE7329.8070304@freescale.com>
Date: Mon, 17 Jun 2013 10:23:37 +0800
From: Lian Minghuan-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/5] powerpc/dts: add MPIC v4.3 dts node
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
 <1371242366.2996.10@snotra> <1371246799.2996.14@snotra>
In-Reply-To: <1371246799.2996.14@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

please see my comments.

On 06/15/2013 05:53 AM, Scott Wood wrote:
> On 06/14/2013 03:39:26 PM, Scott Wood wrote:
>> On 06/14/2013 02:15:55 AM, Minghuan Lian wrote:
>>> +msi0: msi@41600 {
>>> +    compatible = "fsl,mpic-msi", "fsl,mpic-msi-v4.3";
>>
>> More specific compatibles come first -- and I don't think this is 
>> 100% backwards compatible with "fsl,mpic-msi" anyway.
>
> Also please update the binding.
[Minghuan] Yes, maybe I should remove "fsl,mpic-msi". What do you think?
>
> -Scott
