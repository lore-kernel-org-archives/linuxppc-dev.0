Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 5F3A6DDF8C
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 15:21:39 +1100 (EST)
Date: Mon, 19 Jan 2009 23:21:36 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Defconfig support
Message-ID: <20090119232136.717eddf3@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since the list seems quiet right now, thought I would ask a question.
Up till now I haven't really worried about the warp defconfig being up
to date since, realistically, the stock kernel was not usable on the
warp. Since it usually boots from NAND, the lack of an ndfc driver
made it unbootable in a production system.

However, the 2.6.29 kernel will boot, so the defconfig problem becomes
more acute. The problem is keeping the changes that are required for
the warp while also handling the normal changes that happen every
release.

For example, the current git diff shows CONFIG_SIMPLE_GPIO which is
just a new feature and can be safely left unset. But the watchdog made
it into the kernel, so CONFIG_PIKA_WDT should be set for a warp.

Any ideas for a good way of handling this?

Cheers,
   Sean
