Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id CE4AEDDE09
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 07:35:15 +1000 (EST)
Date: Sat, 22 Sep 2007 07:35:15 +1000
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 2/4] Implement generic time of day clocksource for
	powerpc machines.
Message-ID: <20070921213515.GC9814@bakeyournoodle.com>
References: <1190345162.620000.305760830507.qpush@thor>
	<20070921032603.07AF232C889@thor>
	<20070921145212.7e8a7b89.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070921145212.7e8a7b89.sfr@canb.auug.org.au>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 02:52:12PM +1000, Stephen Rothwell wrote:
> Small comments.

Thanks.

> I think this is redundant as if __USE_RTC() is true, you register
> clocksource_rtc below.

Yup you're right.

> The #ifdef is redundant since if CONFIG_ISERIES is not set,
> firmware_has_feature(FW_FEATURE_ISERIES) is constant 0.

Ahh okay.  I got too fancy for my own good.

patch comming.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
