Return-Path: <compudj@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 081CF1A0144
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 01:42:52 +1000 (AEST)
Date: Mon, 31 Aug 2015 15:32:54 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-api <linux-api@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <131898944.32688.1441035174419.JavaMail.zimbra@efficios.com>
In-Reply-To: <1441004045.5735.8.camel@ellerman.id.au>
References: <1440698215-8355-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1440698215-8355-2-git-send-email-mathieu.desnoyers@efficios.com>
 <1441004045.5735.8.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 1/9] powerpc: allocate sys_membarrier system call
 number
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

----- On Aug 31, 2015, at 2:54 AM, Michael Ellerman mpe@ellerman.id.au wrote:

> On Thu, 2015-08-27 at 13:56 -0400, Mathieu Desnoyers wrote:
>> Allow it to be used from SPU, since it should not have unwanted
>> side-effects.
>> 
>> [ Untested on this architecture. To try it out: fetch linux-next/akpm,
>>   apply this patch, build/run a membarrier-enabled kernel, and do make
>>   kselftest. ]
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: linux-api@vger.kernel.org
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Paul Mackerras <paulus@samba.org>
>> CC: Michael Ellerman <mpe@ellerman.id.au>
>> CC: linuxppc-dev@lists.ozlabs.org
> 
> Thanks.
> 
> I get:
> 
> $ ./membarrier_test
> membarrier MEMBARRIER_CMD_QUERY syscall available.
> membarrier: MEMBARRIER_CMD_SHARED success.
> membarrier: tests done!
> 
> Which looks good.
> 
> Assuming the membarrier support hits 4.3, I'll take this via my tree for 4.3
> also.

Great! I'll take care of your comments about self-tests,

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
