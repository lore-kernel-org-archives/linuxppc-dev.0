Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F15167A39
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2006 14:48:52 +1100 (EST)
Subject: Re: ibook1 hangs during boot, atyfb broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060223232423.GA29454@suse.de>
References: <20060223232423.GA29454@suse.de>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 14:48:48 +1100
Message-Id: <1140752928.8264.72.camel@localhost.localdomain>
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

On Fri, 2006-02-24 at 00:24 +0100, Olaf Hering wrote:
> My iBook1 did not work with recent kernels (2.6.15+), 2.6.13 was always ok.
> Today I did some more testing, with 2.6.16-rc4-git3.
> If I boot with 'quiet panic=1 root=/dev/blah', it will hang in 75% of the boots 
> before displaying the penguin.
> Adding video=atyfb:off did fix it, tried it a few times. Then I removed
> the quiet and video= option, and it did boot again. Then I reverted the
> atyfb to 2.6.15 status and did a reboot loop.
> Unfortunately, after 13 reboots with just 'panic=1 root=/x' it was stuck, after 
> time_init: processor frequency = 300MHz.

It boots with video=atyfb:noaccel ?

I suggest you report that to the linux-fbdev mailing list. That problem
seems to happen with some wallstreet powerbooks too, there is definitely
something broken there...

Ben.
