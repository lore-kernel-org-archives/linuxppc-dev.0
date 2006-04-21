Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C040C67A65
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 16:21:53 +1000 (EST)
Subject: Re: powermac S900 6 slot PCI broken in 2.6.16
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert Brose <linuxppcdev@qbjnet.com>
In-Reply-To: <20060420152250.17407.qmail@kunk.qbjnet.com>
References: <20060420152250.17407.qmail@kunk.qbjnet.com>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 16:21:45 +1000
Message-Id: <1145600505.4090.0.camel@localhost.localdomain>
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

On Thu, 2006-04-20 at 15:22 +0000, Robert Brose wrote:
> The s900 has a 6 slot PCI bus. It works fine in 2.6.15. In 2.6.16 it
> appears the interrupts are being assigned in an incorrect way, I get
> an interrupt assignment failure on the device on the 21052 bridge.
> (notice in the interrupt assignment at the end that the stuff on the
> bridge is on irq 25 when it works in 2.6.15 and irq 1 when it doesn't
> work in 2.6.16).

can you send me a tarball of /proc/device-tree along with a complete
dmesg output and lspci -vv log as root for both 2.6.15 and .16 ? Thanks.

Ben.
