Return-Path: <B31939@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB5B32C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 15:15:19 +1000 (EST)
Received: from mail79-co9 (localhost [127.0.0.1])	by mail79-co9-R.bigfish.com
 (Postfix) with ESMTP id 52A431402A9	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 17 Jun 2013 05:15:15 +0000 (UTC)
Received: from CO9EHSMHS025.bigfish.com (unknown [10.236.132.225])	by
 mail79-co9.bigfish.com (Postfix) with ESMTP id AE4702026D	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 05:15:13 +0000 (UTC)
Message-ID: <51BE9B78.9080302@freescale.com>
Date: Mon, 17 Jun 2013 13:15:36 +0800
From: Lian Minghuan-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/5] powerpc/dts: remove msi-available-ranges property
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
 <1371194159-17332-4-git-send-email-Minghuan.Lian@freescale.com>
 <1371247853.2996.17@snotra>
In-Reply-To: <1371247853.2996.17@snotra>
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

On 06/15/2013 06:10 AM, Scott Wood wrote:
> On 06/14/2013 02:15:58 AM, Minghuan Lian wrote:
>> For MPIC v4.3 MSIIR supports 8 MSI registers and MSIIR1 supports
>> 16 MSI registers, but uses different IBS and SRS shift. For the
>> first register, when using MSIIR we will get the irqs 0x0 0x1 0x2
>> ...0x1f, but when using MSIIR1, the irqs are 0x0 0x10 0x20 ... 0x1f0
>> It is hard to describe the available irqs using property
>> 'msi-available-ranges'. The patch removes this property.
>
> Only remove it from mpic 4.3.  And since you introduced 
> qoriq-mpic4.3.dtsi earlier in the patchset, why didn't you just avoid 
> adding it then?
>
[Minghuan] If adding it in qoriq-mpic4.3, and the 3-5 patches are not 
accepted, mpic4.3 can also work.
> -Scott
