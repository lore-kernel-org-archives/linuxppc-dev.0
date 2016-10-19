Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szTsx5QNwzDt24
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 22:16:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 jiangshanlai@gmail.com, akpm@linux-foundation.org, kernel-team@fb.com,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
In-Reply-To: <20161018185858.GA2761@htj.duckdns.org>
References: <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
 <87a8eb5dwa.fsf@concordia.ellerman.id.au>
 <20161014150757.GA11102@mtj.duckdns.org>
 <87eg3fcge5.fsf@concordia.ellerman.id.au>
 <20161017181556.GB6248@htj.duckdns.org>
 <20161017193047.GC6248@htj.duckdns.org>
 <87y41mb7c9.fsf@concordia.ellerman.id.au>
 <20161018185858.GA2761@htj.duckdns.org>
Date: Wed, 19 Oct 2016 22:16:52 +1100
Message-ID: <87r37c4mhn.fsf@concordia.ellerman.id.au>
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

Tejun Heo <tj@kernel.org> writes:

> Hello, Michael.
>
> On Tue, Oct 18, 2016 at 03:37:42PM +1100, Michael Ellerman wrote:
>> That doesn't compile, wq doesn't exist.
>> 
>> I guessed that you meant:
>> 
>> +       wq_numa_init();
>> +       list_for_each_entry(wq, &workqueues, list)
>> +               wq_update_unbound_numa(wq, smp_processor_id(), true);
>
> Yeap, sorry about that.

No worries.

>> And that does boot.
>> 
>> The sysrq-t output is below, it's rather large.
>
> Didn't expect that many cpus but it looks good.

I have another system here with twice as many CPUs if that would help ;)

> I'll post proper patches soon.

Thanks. Can you pull the current series out of linux-next for now until
you merge the new series?

cheers
