Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 9A06EDE133
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 10:37:09 +1100 (EST)
Date: Sun, 28 Jan 2007 15:37:07 -0800 (PST)
Message-Id: <20070128.153707.30184351.davem@davemloft.net>
To: ebiederm@xmission.com
Subject: Re: [PATCH 0/6] MSI portability cleanups
From: David Miller <davem@davemloft.net>
In-Reply-To: <m1hcuaohqj.fsf@ebiederm.dsl.xmission.com>
References: <m1bqkiq25v.fsf@ebiederm.dsl.xmission.com>
	<1170022154.26655.63.camel@localhost.localdomain>
	<m1hcuaohqj.fsf@ebiederm.dsl.xmission.com>
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
Date: Sun, 28 Jan 2007 16:26:44 -0700

> Yes.  In general the mainline linux kernel does not support certain
> classes of stupidity.  TCP offload engines, firmware drivers for
> hardware we care about, a fixed ABI to binary only modules, etc.
> It is the responsibility of the OS to setup MSI so we do it, not
> the firmware so we do it.

I absolutely disagree with you Eric, and I think you're being
rediculious.

If the hypervisor doesn't control the MSI PCI config space
register writes, this allows the device to spam PCI devices
which belong to other domains.

It's a freakin' reasonable design trade off decision, get over
it! :-)

Yes it can be done at the hardware level, and many hypervisor
based systems do that, but it's not the one-and-only true
way to implment inter-domain protection behind a single
PCI host controller.
