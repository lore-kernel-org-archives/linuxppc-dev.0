Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E779BDDE11
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Apr 2008 13:21:37 +1000 (EST)
Date: Sat, 26 Apr 2008 20:21:35 -0700 (PDT)
Message-Id: <20080426.202135.145326755.davem@davemloft.net>
To: kevdig@hypersurf.com
Subject: Re: get_cycles()
From: David Miller <davem@davemloft.net>
In-Reply-To: <4813E74B.1020506@hypersurf.com>
References: <4812DFA3.6090106@hypersurf.com>
	<20080426.001102.65527296.davem@davemloft.net>
	<4813E74B.1020506@hypersurf.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kevin Diggs <kevdig@hypersurf.com>
Date: Sat, 26 Apr 2008 19:39:07 -0700

> This looks pretty cool ... but I don't want to create a dependency on
> hrtimer.

It doesn't create such a dependency.

We use it unconditionally in the generic networking.

Please don't use platform specific interfaces if you don't have to.
You're be insulated from so many things.
