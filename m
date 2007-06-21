Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 2FEBBDDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 14:29:11 +1000 (EST)
Date: Thu, 21 Jun 2007 14:29:10 +1000
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH/RFC] Modify sched_clock() to make CONFIG_PRINTK_TIME more
	sane.
Message-ID: <20070621042910.GS9768@bakeyournoodle.com>
References: <20070619063557.GK9768@bakeyournoodle.com>
	<20070619145356.GA20382@lixom.net>
	<20070620020211.GO9768@bakeyournoodle.com>
	<Pine.LNX.4.62.0706200936300.27011@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.LNX.4.62.0706200936300.27011@pademelon.sonytel.be>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: Olof Johansson <olof@lixom.net>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2007 at 09:37:51AM +0200, Geert Uytterhoeven wrote:

Hi Geert,
 
> Just wondering, does the INITIAL_JIFFIES mechanism to catch wrap bugs still
> work after this patch?
> 
> include/linux/jiffies.h:
> | /*
> |  * Have the 32 bit jiffies value wrap 5 minutes after boot
> |  * so jiffies wrap bugs show up earlier.
> |  */
> | #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

I've done a quick check and I can't see how my patch would break
anything,  given that sched_clock() on powerpc returns a timebase value
generally not related to jiffies.

I hope I haven't missed anything.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
