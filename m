Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [193.178.161.156])
 by ozlabs.org (Postfix) with ESMTP id 272F32C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 06:53:49 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andreas Schwab <schwab@linux-m68k.org>, John Stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 6/6] hrtimer: Update hrtimer base offsets each
 hrtimer_interrupt
Date: Sun, 15 Jul 2012 22:28:36 +0200
References: <1341960205-56738-1-git-send-email-johnstul@us.ibm.com>
 <1341960205-56738-8-git-send-email-johnstul@us.ibm.com>
 <m2y5mlnj5z.fsf@igel.home>
In-Reply-To: <m2y5mlnj5z.fsf@igel.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Message-Id: <201207152228.36740.rjw@sisk.pl>
Cc: Prarit Bhargava <prarit@redhat.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Linux PM list <linux-pm@vger.kernel.org>,
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

On Sunday, July 15, 2012, Andreas Schwab wrote:
> This breaks resume on the iBook G4 (PowerBook6,7).  Apparently during or
> before noirq resume the system is hanging by the same amount of time as
> the system was sleeping.

I'm able to reproduce this problem on Toshiba Portege R500 with similar
symptoms, although that box sometimes hangs hard during resume from system
suspend with the "caps lock" LED blinking.

Reverting the patch fixes the problem 100% of the time.

Thanks,
Rafael
