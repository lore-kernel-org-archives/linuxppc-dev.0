Return-Path: <richardcochran@gmail.com>
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com
 [IPv6:2a00:1450:400c:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E9311A0BE2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 00:54:42 +1000 (AEST)
Received: by wiun10 with SMTP id n10so60428973wiu.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 07:54:39 -0700 (PDT)
Date: Wed, 22 Apr 2015 16:54:32 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH 04/11] posix timers:Introduce the 64bit methods
 with timespec64 type for k_clock structure
Message-ID: <20150422145432.GA31405@localhost.localdomain>
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
 riel@redhat.com, Tejun Heo <tj@kernel.org>,
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
> time, stime, gettimeofday, settimeofday, adjtimex, nanosleep,
> getitimer, setitimer:
>  all deprecated => wontfix

If adjtimex is deprecated, what will replace it?  It is really
important for ntp.

Thanks,
Richard
