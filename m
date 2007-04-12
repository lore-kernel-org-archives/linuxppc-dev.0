Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D6102DDF6A
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 16:40:37 +1000 (EST)
Date: Wed, 11 Apr 2007 23:40:38 -0700 (PDT)
Message-Id: <20070411.234038.28809187.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] Start split out of common open firmware code
From: David Miller <davem@davemloft.net>
In-Reply-To: <1176359774.8061.129.camel@localhost.localdomain>
References: <1176357020.8061.123.camel@localhost.localdomain>
	<20070411.232545.45203999.davem@davemloft.net>
	<1176359774.8061.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 12 Apr 2007 16:36:14 +1000

> Note that for the filesystem, we really want to stick to our binary
> representation while you really want to stick to your text rep (we
> decided to disagree iirc :-) I think we could keep a lot in common still
> and just have a mount option to indicate how the file content is
> exposed.

I'm fine with that.

> It's not really 2.6.22 material as far as I'm concerned as I'm pretty
> busy with other things, unless of course Stephen feel like doing it
> all :-) I'll see what I can do for the next cycle though.

It would be nice to merge as much of the truly common stuff as
soon as possible.

The sooner I don't have to fix the same bug in multiple locations, the
better :)
