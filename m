Return-Path: <breno.debian@gmail.com>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lwp66G0dzF0WL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 01:50:38 +1000 (AEST)
Received: by mail-qk0-f196.google.com with SMTP id v17-v6so1814016qkb.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Aug 2018 08:50:38 -0700 (PDT)
Subject: Re: [PATCH v2] powerpc/tm: Print 64-bits MSR
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
References: <5b85006b6695bd94f4818357be607036e9df8696.camel@neuling.org>
 <1533648900-7933-1-git-send-email-leitao@debian.org>
 <95db63eb-6fb7-eed3-1ce8-8b2c053dff47@c-s.fr>
 <c5be0bf4-de2c-6fe4-3192-f48aade9506b@debian.org>
 <20180807205718.Horde.hQCYOtyzfY7xFtxCwRj2Iw1@messagerie.si.c-s.fr>
From: Breno Leitao <leitao@debian.org>
Message-ID: <0378869f-cd56-db1c-f359-5b5791d9603f@debian.org>
Date: Wed, 8 Aug 2018 12:50:29 -0300
MIME-Version: 1.0
In-Reply-To: <20180807205718.Horde.hQCYOtyzfY7xFtxCwRj2Iw1@messagerie.si.c-s.fr>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Leroy,

On 08/07/2018 03:57 PM, LEROY Christophe wrote:
> Breno Leitao <leitao@debian.org> a écrit :

>> On 08/07/2018 02:15 PM, Christophe LEROY wrote:
>>> Le 07/08/2018 à 15:35, Breno Leitao a écrit :

>>> I think it would be better to change 'reason' to 'unsigned long' instead of
>>> replacing it by regs->msr for the printk.
>>
>> That was my initial approach, but this code seems to run on 32 bits system,
>> and I do not want to change the whole 'reason' bit width without having a 32
>> bits to test, at least.
> 
> But 'unsigned long' is still 32 bits on ppc32, so it makes no difference with
> 'unsigned int'
> And I will test it for you if needed

Cool, I really appreciate it, and I would definitely need it once I have a
more intrusive HTM patchset I am working on.

Regarding this one, I think the change is so simple as-is that  I would
prefer to continue with the v2 patch, if you do not mind.

Thank you!
