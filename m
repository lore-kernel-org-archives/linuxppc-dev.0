Return-Path: <rjwysocki@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzBMj0PllzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 06:38:57 +1000 (AEST)
Received: by mail-it0-x241.google.com with SMTP id 188so1998773itx.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 13:38:56 -0700 (PDT)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <3wyzKL1g2Vz9s65@ozlabs.org>
References: <20170614130241.19865-2-npiggin@gmail.com>
 <3wyzKL1g2Vz9s65@ozlabs.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Jun 2017 22:38:54 +0200
Message-ID: <CAJZ5v0g2DMRcL78k2+qA0svxGqtt-sTW2BpcfvRjU-=iCBjEYg@mail.gmail.com>
Subject: Re: [1/3] cpuidle: powerpc: cpuidle set polling before enabling irqs
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 29, 2017 at 2:21 PM, Michael Ellerman
<patch-notifications@ellerman.id.au> wrote:
> On Wed, 2017-06-14 at 13:02:39 UTC, Nicholas Piggin wrote:
>> local_irq_enable can cause interrupts to be taken which could
>> take significant amount of processing time. The idle process
>> should set its polling flag before this, so another process that
>> wakes it during this time will not have to send an IPI.
>>
>> Expand the TIF_POLLING_NRFLAG coverage to as large as possible.
>>
>> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> Series applied to powerpc next, thanks.
>
> https://git.kernel.org/powerpc/c/3fc5ee927ff4ffed6aa2fcd44d2fbf

OK

I've applied it too, so I guess I should drop it?

Thanks,
Rafael
