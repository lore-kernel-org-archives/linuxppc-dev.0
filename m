Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD0932C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 02:02:20 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: John Stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 6/6] hrtimer: Update hrtimer base offsets each
 hrtimer_interrupt
References: <1341960205-56738-1-git-send-email-johnstul@us.ibm.com>
 <1341960205-56738-8-git-send-email-johnstul@us.ibm.com>
 <m2y5mlnj5z.fsf__49536.0585897744$1342365803$gmane$org@igel.home>
Date: Sun, 15 Jul 2012 18:02:04 +0200
In-Reply-To: <m2y5mlnj5z.fsf__49536.0585897744$1342365803$gmane$org@igel.home>
 (Andreas Schwab's message of "Sun, 15 Jul 2012 17:22:32 +0200")
Message-ID: <m2txx9nhc3.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Prarit Bhargava <prarit@redhat.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Linux Kernel <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andreas Schwab <schwab@linux-m68k.org> writes:

> This breaks resume on the iBook G4 (PowerBook6,7).  Apparently during or
> before noirq resume the system is hanging by the same amount of time as
> the system was sleeping.

The point where the time is wasted actually appears to be _after_ resume
(the elapsed time for the resume itself isn't affected).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
