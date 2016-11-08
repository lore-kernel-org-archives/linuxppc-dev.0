Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCVNM2Mh9zDt0R
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 11:21:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com
Subject: Re: [PATCH v2] ppc: cpufreq: disable preemption while checking CPU
 throttling state
In-Reply-To: <CAOJe8K1Cb_UH+yRb8_hYB3T9i8EqteS_nTgWWNcA-EtZvm-wNg@mail.gmail.com>
References: <1478257718-14923-1-git-send-email-kda@linux-powerpc.org>
 <87fun3n3lt.fsf@concordia.ellerman.id.au>
 <CAOJe8K1Cb_UH+yRb8_hYB3T9i8EqteS_nTgWWNcA-EtZvm-wNg@mail.gmail.com>
Date: Tue, 08 Nov 2016 11:21:23 +1100
Message-ID: <87k2celt30.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Denis Kirjanov <kda@linux-powerpc.org> writes:
> On 11/7/16, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Denis Kirjanov <kda@linux-powerpc.org> writes:
>>>     [   67.700897] BUG: using smp_processor_id() in preemptible [00000000] code: cat/7343
>>>     [   67.700988] caller is .powernv_cpufreq_throttle_check+0x2c/0x710
>>
>> When did this break?
>
> I think that problem exists since commit
> 09a972d1620934142d30cfda455ffe429af751c4 ("cpufreq: powernv: Report
> cpu frequency throttling") but I can be wrong

Yep that looks right to me, thanks.

Gautham, how bad is the bug here, do we want to send this to stable?

cheers
