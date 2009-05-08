Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 50B5CDDF9D
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 09:05:12 +1000 (EST)
Date: Fri, 08 May 2009 16:05:04 -0700 (PDT)
Message-Id: <20090508.160504.87589598.davem@davemloft.net>
To: cfriesen@nortel.com
Subject: Re: question about softirqs
From: David Miller <davem@davemloft.net>
In-Reply-To: <4A04B76D.20106@nortel.com>
References: <4A04B76D.20106@nortel.com>
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

From: "Chris Friesen" <cfriesen@nortel.com>
Date: Fri, 08 May 2009 16:51:25 -0600

> I'm trying to figure out where exactly softirqs are called on return
> from a syscall in 64-bit powerpc.  I can see where they get called for
> a normal interrupt via the irq_exit() path, but not for syscalls.
> 
> I'm sure I'm missing something obvious...can anyone help?

I can't see where it does this either, strange.

That would be a very terrible bug if it's not invoking
pending softirqs before return from system calls.

Although, it might be happening via some clever side effect
of how the software managed hardware interrupt stuff works
on powerpc.
