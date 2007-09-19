Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 4507DDDE40
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 16:53:30 +1000 (EST)
Date: Wed, 19 Sep 2007 16:53:29 +1000
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/5] Implement {read,update}_persistent_clock.
Message-ID: <20070919065329.GU9814@bakeyournoodle.com>
References: <1190184586.867449.381310088392.qpush@thor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1190184586.867449.381310088392.qpush@thor>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2007 at 04:49:46PM +1000, Tony Breeds wrote:
> With these functions implemented we cooperate better with the generic
> timekeeping code.  This obsoletes the need for the timer sysdev as a bonus.

I should have added that this patch series applies on top of Benh's 601
fixes.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
