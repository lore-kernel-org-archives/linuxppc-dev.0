Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sz49h1fvJzDt3C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 05:59:04 +1100 (AEDT)
Received: by mail-yw0-x242.google.com with SMTP id w3so96748ywg.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 11:59:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 18 Oct 2016 14:58:58 -0400
From: Tejun Heo <tj@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 jiangshanlai@gmail.com, akpm@linux-foundation.org, kernel-team@fb.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
Message-ID: <20161018185858.GA2761@htj.duckdns.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y41mb7c9.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Michael.

On Tue, Oct 18, 2016 at 03:37:42PM +1100, Michael Ellerman wrote:
> That doesn't compile, wq doesn't exist.
> 
> I guessed that you meant:
> 
> +       wq_numa_init();
> +       list_for_each_entry(wq, &workqueues, list)
> +               wq_update_unbound_numa(wq, smp_processor_id(), true);

Yeap, sorry about that.

> And that does boot.
> 
> The sysrq-t output is below, it's rather large.

Didn't expect that many cpus but it looks good.  I'll post proper
patches soon.

Thanks!

-- 
tejun
