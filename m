Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swr1422x6zDt4W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Oct 2016 14:43:52 +1100 (AEDT)
Received: by mail-pa0-x244.google.com with SMTP id qn10so6746368pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 20:43:52 -0700 (PDT)
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
To: Tejun Heo <tj@kernel.org>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
 <87a8eb5dwa.fsf@concordia.ellerman.id.au>
 <3f7ddc83-fcd3-79c4-81b6-ec3c4de53be6@gmail.com>
 <20161014150848.GB11102@mtj.duckdns.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <a21b5b8e-5ced-8f1e-7945-2f3819194442@gmail.com>
Date: Sat, 15 Oct 2016 14:43:51 +1100
MIME-Version: 1.0
In-Reply-To: <20161014150848.GB11102@mtj.duckdns.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 15/10/16 02:08, Tejun Heo wrote:
> Hello, Balbir.
> 
> On Tue, Oct 11, 2016 at 11:21:09PM +1100, Balbir Singh wrote:
>> FYI: I see the samething on my cpu as well, its just that I get lucky
>> and cpu_online(cpu) returns false.
> 
> Are you seeing this on x86 or is your test setup also a power machine?
> 
> Thanks.
> 

I saw this on a powerpc box

Balbir Singh.
