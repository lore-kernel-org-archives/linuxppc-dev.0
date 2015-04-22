Return-Path: <luc.vanoostenryck@gmail.com>
Received: from mail-wi0-x244.google.com (mail-wi0-x244.google.com
 [IPv6:2a00:1450:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FE6C1A0541
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 01:15:01 +1000 (AEST)
Received: by wivz2 with SMTP id z2so6928950wiv.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 08:14:57 -0700 (PDT)
Date: Wed, 22 Apr 2015 17:14:47 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH 04/11] posix timers:Introduce the 64bit methods
 with timespec64 type for k_clock structure
Message-ID: <20150422151445.GA2165@macpro.local>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
 <alpine.DEB.2.11.1504220946460.13914@nanos>
 <2233518.Z2Q4dpO62C@wuerfel> <2500914.bVUENZ0dAZ@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2500914.bVUENZ0dAZ@wuerfel>
Cc: pang.xunlei@linaro.org, Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 cl@linux.com, Ingo Molnar <mingo@kernel.org>, heenasirwani@gmail.com,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, y2038@lists.linaro.org,
 rafael.j.wysocki@intel.com, ahh@google.com,
 Frederic Weisbecker <fweisbec@gmail.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, pjt@google.com,
 riel@redhat.com, richardcochran@gmail.com, Tejun Heo <tj@kernel.org>,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 rth@twiddle.net, Baolin Wang <baolin.wang@linaro.org>,
 gregkh@linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 22, 2015 at 03:50:45PM +0200, Arnd Bergmann wrote:
> On Wednesday 22 April 2015 13:07:44 Arnd Bergmann wrote:
...
> select, old_selct, pselect6: deprecated

Small, copy&paste error here for pselect6.


Luc
