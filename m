Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id AB946DE171
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 21:24:40 +1000 (EST)
Date: Thu, 5 Jun 2008 13:24:36 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@linux-foundation.org>, linuxppc-dev@ozlabs.org
Subject: Re: Linux 2.6.26-rc5
Message-ID: <20080605112436.GA4533@aepfle.de>
References: <alpine.LFD.1.10.0806042018060.3473@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LFD.1.10.0806042018060.3473@woody.linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 04, Linus Torvalds wrote:

> Another week, another batch of mostly pretty small fixes. Hopefully the 
> regression list is shrinking, and we've fixed at least a couple of the 
> oopses on Arjan's list.

SATA on a dualcore G5 is broken, it happend between
c3b25b32e8bef526cca748e1ba023c6bdd705a99..53c8ba95402be65d412a806cda3430f0e72cd107

irq 18: nobody cared (try booting with the "irqpoll" option)
Disabling IRQ #18


ctrl alt del on the USB keyboard does not trigger a reboot.
Sometimes the cursor stops blinking, sometimes just nothing happens
after ctrl alt del.


Does 53c8ba95402be65d412a806cda3430f0e72cd107 work for others on G5?
