Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 167361A068E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 01:39:24 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [Y2038] [PATCH 04/11] posix timers:Introduce the 64bit methods
 with timespec64 type for k_clock structure
Date: Wed, 22 Apr 2015 17:38:28 +0200
Message-ID: <2088991.9ogxlI08JT@wuerfel>
In-Reply-To: <20150422151445.GA2165@macpro.local>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
 <2500914.bVUENZ0dAZ@wuerfel> <20150422151445.GA2165@macpro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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

On Wednesday 22 April 2015 17:14:47 Luc Van Oostenryck wrote:
> On Wed, Apr 22, 2015 at 03:50:45PM +0200, Arnd Bergmann wrote:
> > On Wednesday 22 April 2015 13:07:44 Arnd Bergmann wrote:
> ...
> > select, old_selct, pselect6: deprecated
> 
> Small, copy&paste error here for pselect6.
> 

Right, that should have been poll.

	Arnd
