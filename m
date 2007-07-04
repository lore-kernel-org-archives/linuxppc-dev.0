Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 78373DDF0A
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 14:40:54 +1000 (EST)
Date: Wed, 4 Jul 2007 14:40:54 +1000
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/3] Modify sched_clock() to make CONFIG_PRINTK_TIME more
	sane.
Message-ID: <20070704044054.GA10345@bakeyournoodle.com>
References: <20070704040431.1A13432C46D@thor>
	<1183523268.26479.0.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1183523268.26479.0.camel@concordia.ozlabs.ibm.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 04, 2007 at 02:27:48PM +1000, Michael Ellerman wrote:
 
> Is this what other archs do?

They either use jiffies, or AFAICT an external counter that is
initialised to 0 at system powerup.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
