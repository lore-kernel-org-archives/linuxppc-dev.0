Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk25Y4n3szDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 20:41:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/book3s64: Move PPC_DT_CPU_FTRs and enable it by
 default
In-Reply-To: <20170608182448.6ab0c1d3@roar.ozlabs.ibm.com>
References: <1496904701-29372-1-git-send-email-mpe@ellerman.id.au>
 <20170608182448.6ab0c1d3@roar.ozlabs.ibm.com>
Date: Thu, 08 Jun 2017 20:41:04 +1000
Message-ID: <874lvqep8f.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Thu,  8 Jun 2017 16:51:41 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> The PPC_DT_CPU_FTRs is a bit misplaced in menuconfig, it shows up with
>> other general kernel options. It's really more at home in the "Platform
>> Support" section, so move it there.
>> 
>> Also enable it by default, for Book3s 64. It does mostly nothing unless
>> the device tree properties are found, and we will want it enabled
>> eventually in distro kernels, so turn it on to start getting more
>> testing.
>> 
>> Fixes: 5a61ef74f269 ("powerpc/64s: Support new device tree binding for discovering CPU features")
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Well I'd better send the patch to enable it in firmware then.

At some point :)

It actually matters less when it goes into firmware, but yeah I think
it's sufficiently cooked that it should go in.

cheers
