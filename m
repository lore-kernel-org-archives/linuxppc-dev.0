Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB7901A0162
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 06:30:31 +1000 (EST)
Date: Thu, 18 Sep 2014 22:27:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH v4 1/3] init/main.c: Give init_task a canary
Message-ID: <20140918202701.GA10695@redhat.com>
References: <1410527779-8133-1-git-send-email-atomlin@redhat.com>
 <1410527779-8133-2-git-send-email-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410527779-8133-2-git-send-email-atomlin@redhat.com>
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com, x86@kernel.org,
 akpm@linux-foundation.org, peterz@infradead.org, bmr@redhat.com,
 prarit@redhat.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 minchan@kernel.org, mingo@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
 hannes@cmpxchg.org, jgh@redhat.com, linuxppc-dev@lists.ozlabs.org,
 tglx@linutronix.de, akpm@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/12, Aaron Tomlin wrote:
>
> Tasks get their end of stack set to STACK_END_MAGIC with the
> aim to catch stack overruns. Currently this feature does not
> apply to init_task. This patch removes this restriction.
>
> Note that a similar patch was posted by Prarit Bhargava [1]
> some time ago but was never merged.
>
> [1]: http://marc.info/?l=linux-kernel&m=127144305403241&w=2
>
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Oleg Nesterov <oleg@redhat.com>
