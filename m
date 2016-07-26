Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz0YS6X7hzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 11:15:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: chengang@emindsoft.com.cn, benh@kernel.crashing.org, paulus@samba.org,
 dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH v2] include: mman: Use bool instead of int for the return
 value of arch_validate_prot
In-Reply-To: <20160725170859.1be58d7f19b72a0340ee65c7@linux-foundation.org>
References: <1469331815-2026-1-git-send-email-chengang@emindsoft.com.cn>
 <8737my1exd.fsf@concordia.ellerman.id.au>
 <20160725170859.1be58d7f19b72a0340ee65c7@linux-foundation.org>
Date: Tue, 26 Jul 2016 11:15:40 +1000
Message-ID: <87vaztrygz.fsf@concordia.ellerman.id.au>
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

Andrew Morton <akpm@linux-foundation.org> writes:
> On Mon, 25 Jul 2016 15:10:06 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>> chengang@emindsoft.com.cn writes:
>> > From: Chen Gang <chengang@emindsoft.com.cn>
>> >
>> > For pure bool function's return value, bool is a little better more or
>> > less than int.
>> >
>> > Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
>> 
>> LGTM.
>> 
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>> 
>> Andrew do you want to take this or should I?
>
> I grabbed it, thanks.

Thanks.
