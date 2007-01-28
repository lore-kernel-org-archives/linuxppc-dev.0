Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E8797DE4E1
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 10:44:54 +1100 (EST)
Date: Sun, 28 Jan 2007 15:44:53 -0800 (PST)
Message-Id: <20070128.154453.112622887.davem@davemloft.net>
To: ebiederm@xmission.com
Subject: Re: [PATCH 0/6] MSI portability cleanups
From: David Miller <davem@davemloft.net>
In-Reply-To: <m1bqkiq25v.fsf@ebiederm.dsl.xmission.com>
References: <1170015805.26655.15.camel@localhost.localdomain>
	<45BD0BDC.40205@garzik.org>
	<m1bqkiq25v.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tony.luck@intel.com, grundler@parisc-linux.org, jeff@garzik.org,
	linux-kernel@vger.kernel.org, kyle@parisc-linux.org,
	linuxppc-dev@ozlabs.org, brice@myri.com, greg@kroah.com,
	shaohua.li@intel.com, mingo@elte.hu, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 28 Jan 2007 14:20:12 -0700

> I see people pushing ridiculous interfaces like the RTAS hypervisor
> interface at me, and saying we must support running firmware drivers
> in the msi code.

This is not what's going on.

The hypervisor does the PCI config space programming on the
device to setup the MSI so that it can be done in a controlled
manner and such that the device cannot ever be configured by
one domain to shoot MSI packets over at devices which belong
to another domain.

It's that simple.

That's absolutely reasonable, and is I believe what you'll see the
sparc64 hypervisor(s) all needing as well.
