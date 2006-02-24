Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E9CA679F3
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2006 22:08:37 +1100 (EST)
Subject: Re: ibook1 hangs during boot, atyfb broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Heikki Lindholm <holindho@cs.helsinki.fi>
In-Reply-To: <43FEB064.1@cs.helsinki.fi>
References: <20060223232423.GA29454@suse.de>
	<1140752928.8264.72.camel@localhost.localdomain>
	<43FEB064.1@cs.helsinki.fi>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 22:08:21 +1100
Message-Id: <1140779302.8264.79.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Using an older DVI TiBook, atyfb has been broken at least since 2.6.8 or 
> so, and still is with 2.6.15, in that it can't seem to synchronize with 
> the LCD and maybe 50% of the (re-)boots produce just more-or-less 
> shimmering/flashing garbage on screen. Doesn't completely hang though...

Except that no tibook ever used atyfb...

Ben.
