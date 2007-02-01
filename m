Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C1707DDDEC
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Feb 2007 11:55:23 +1100 (EST)
Date: Wed, 31 Jan 2007 16:55:21 -0800 (PST)
Message-Id: <20070131.165521.126576017.davem@davemloft.net>
To: ebiederm@xmission.com
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: David Miller <davem@davemloft.net>
In-Reply-To: <m1fy9rbq4t.fsf@ebiederm.dsl.xmission.com>
References: <1170032301.26655.140.camel@localhost.localdomain>
	<20070130.225232.112422538.davem@davemloft.net>
	<m1fy9rbq4t.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: kyle@parisc-linux.org, linuxppc-dev@ozlabs.org, brice@myri.com,
	greg@kroah.com, shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 31 Jan 2007 00:40:34 -0700

> I think you could have omitted your one liner if you had done:
> struct msi_desc *entry = get_irq_data(irq);
> struct pci_dev *dev = entry->dev;

Good idea, I reimplemented it that way.
