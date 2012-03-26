Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 98043B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2012 04:13:26 +1100 (EST)
Date: Mon, 26 Mar 2012 19:04:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v2.1 01/10] cpu: Introduce clear_tasks_mm_cpumask() helper
Message-ID: <20120326170443.GA25229@redhat.com>
References: <20120324102609.GA28356@lizard> <20120324102751.GA29067@lizard>
 <1332593021.16159.27.camel@twins> <20120324164316.GB3640@lizard>
 <20120325174210.GA23605@redhat.com> <1332748746.16159.62.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332748746.16159.62.camel@twins>
Cc: Mike Frysinger <vapier@gentoo.org>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, linux-mm@kvack.org,
 Anton Vorontsov <anton.vorontsov@linaro.org>, Paul Mundt <lethal@linux-sh.org>,
 John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Russell King <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/26, Peter Zijlstra wrote:
>
> On Sun, 2012-03-25 at 19:42 +0200, Oleg Nesterov wrote:
> > __cpu_disable() is called by __stop_machine(), we know that nobody
> > can preempt us and other CPUs can do nothing.
>
> It would be very good to not rely on that though,

Yes, yes, perhaps I wasn't clear but I think the patches are fine.

> I would love to get
> rid of the stop_machine usage in cpu hotplug some day.

Interesting... Why? I mean, why do you dislike stop_machine() in
_cpu_down() ? Just curious.

Oleg.
