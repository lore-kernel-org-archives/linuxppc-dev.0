Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLS5V3gCxzDqjw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 12:02:06 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id di3so4601831pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 19:02:06 -0700 (PDT)
Subject: Re: [PATCH 1/2] powerpc/timer - large decrementer support
To: Michael Neuling <mikey@neuling.org>, Oliver O'Halloran
 <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1464675936.30958.22.camel@neuling.org>
 <1464679016-10347-1-git-send-email-oohall@gmail.com>
 <1464758911.30958.113.camel@neuling.org>
Cc: Jack Miller <jack@codezen.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f20c99aa-7648-2b8f-489c-96b53bd3a9c1@gmail.com>
Date: Fri, 3 Jun 2016 12:01:56 +1000
MIME-Version: 1.0
In-Reply-To: <1464758911.30958.113.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/06/16 15:28, Michael Neuling wrote:
> On Tue, 2016-05-31 at 17:16 +1000, Oliver O'Halloran wrote:
>> POWER ISA v3 adds large decrementer (LD) mode of operation which
>> increases
>> the size of the decrementer register from 32 bits to an implementation
>> defined with of up to 64 bits.
>>
>> This patch adds support for the LD on processors with the
>> CPU_FTR_ARCH_300
>> cpu feature flag set. For CPUs with this feature LD mode is enabled when
>> when the ibm,dec-bits devicetree property is supplied for the boot CPU.
>> The
>> decrementer value is a signed quantity (with negative values indicating a
>> pending exception) and this property is required to find the maximum
>> positive decrementer value. If this property is not supplied then the
>> traditional decrementer width of 32 bits is assumed and LD mode is
>> disabled.
>>
>> This patch was based on initial work by Jack Miller.
>>
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>> Cc: Michael Neuling <mikey@neuling.org>
> 
> Acked-by: Michael Neuling <mikey@neuling.org>
> 
>> Cc: Balbir Singh <bsingharora@gmail.com>
>> Cc: Jack Miller <jack@codezen.org>

I had reviewed a previous post of this patchset

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
