Return-Path: <htejun@gmail.com>
Received: from mail-yb0-x234.google.com (mail-yb0-x234.google.com
 [IPv6:2607:f8b0:4002:c09::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swWFw4SzdzDt3Q
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Oct 2016 02:08:52 +1100 (AEDT)
Received: by mail-yb0-x234.google.com with SMTP id 184so43616013yby.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 08:08:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 14 Oct 2016 11:08:48 -0400
From: Tejun Heo <tj@kernel.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
Message-ID: <20161014150848.GB11102@mtj.duckdns.org>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
 <87a8eb5dwa.fsf@concordia.ellerman.id.au>
 <3f7ddc83-fcd3-79c4-81b6-ec3c4de53be6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3f7ddc83-fcd3-79c4-81b6-ec3c4de53be6@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Balbir.

On Tue, Oct 11, 2016 at 11:21:09PM +1100, Balbir Singh wrote:
> FYI: I see the samething on my cpu as well, its just that I get lucky
> and cpu_online(cpu) returns false.

Are you seeing this on x86 or is your test setup also a power machine?

Thanks.

-- 
tejun
