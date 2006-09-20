Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B12E67A39
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 04:07:43 +1000 (EST)
Date: Tue, 19 Sep 2006 22:36:56 -0700
From: Brad Boyer <flar@allandria.com>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: Re: [PATCH] adbhid: make KEY_SYSRQ configurable on ADB based machines
Message-ID: <20060920053656.GA28326@cynthia.pants.nu>
References: <20060808154937.GC3363@cathedrallabs.org>
	<20060920134459.GC23803@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060920134459.GC23803@cathedrallabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 20, 2006 at 10:44:59AM -0300, Aristeu Sergio Rozanski Filho wrote:
> > This patch adds a sysfs entry on /sys/class/adb/keyboard0/sysrq_key to
> > configure which key will be mapped to KEY_SYSRQ. This is needed to make
> > sysrq usable on machines which doesn't have current sysrq key. This
> > patch and the previous two ones has been tested for some days in my
> > machine without problems.
> any comments on this one?

The only thing I see is that each ADB keyboard device will have an entry
in sysfs to change the sysrq key, but they will all set the same global.
It's a little misleading, but I don't think it's a major issue. And
before anyone asks, I have in fact had multiple ADB keyboards attached
to a single machine. It was useful for multi-player games.

	Brad Boyer
	flar@allandria.com
