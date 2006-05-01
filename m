Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3102967B4F
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 17:17:40 +1000 (EST)
Subject: Re: windfarm for PM72/PM73/RM31
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
In-Reply-To: <20060501002719.GD15141@curie-int.vc.shawcable.net>
References: <20060501002719.GD15141@curie-int.vc.shawcable.net>
Content-Type: text/plain
Date: Mon, 01 May 2006 17:17:33 +1000
Message-Id: <1146467853.30710.43.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 1. Message naming consistancy - there are a number of printk/DBG
> statements that seem to flip randomly between using a prefix of
> 'windfarm:' or 'wf:', and then some that omit it entirely.
> Any consensus on which one is preferred?

Not really... I tended to use "wf" for debug and "windfarm" for normally
visible messages but I may not have been totally consistent.

> 2. Could somebody please send me a tarball of /proc/device-tree/ from a
> RackMac3,1 unit? I've got the data for PM72/73 already.

I'll do so tomorrow, ping me if you don't hear from me.

Ben.
