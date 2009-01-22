Return-Path: <paul@burly.ondioline.org>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by ozlabs.org (Postfix) with ESMTP id 3C8ACDDF2E
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 19:19:06 +1100 (EST)
From: Paul Collins <paul@burly.ondioline.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Badness at kernel/time/timekeeping.c:98 in pmud
	(timekeeping_suspended)
References: <87prihcepl.fsf@burly.wgtn.ondioline.org>
	<200901211713.39630.rjw@sisk.pl>
Date: Thu, 22 Jan 2009 21:19:04 +1300
In-Reply-To: <200901211713.39630.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 21 Jan 2009 17:13:39 +0100")
Message-ID: <87k58nda87.fsf@burly.wgtn.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Wednesday 21 January 2009, Paul Collins wrote:
>> Got a couple of these on a PowerBook running 2.6.29-rc2 either during
>> suspend or resume -- it's hard to tell.  (The suspend message is
>> timestamped in syslog with the time I resumed, so I guess it was
>> buffered along with the subsequent "Badness" messages.)
>
> Please check if the patch from http://lkml.org/lkml/2009/1/13/144 fixes the
> problem for you.

It does not fix the problem.

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
