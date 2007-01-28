Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id F252ADE44B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 10:42:21 +1100 (EST)
Date: Sun, 28 Jan 2007 15:42:19 -0800 (PST)
Message-Id: <20070128.154219.55509563.davem@davemloft.net>
To: jeff@garzik.org
Subject: Re: [PATCH 0/6] MSI portability cleanups
From: David Miller <davem@davemloft.net>
In-Reply-To: <45BD0BDC.40205@garzik.org>
References: <m1hcubq6re.fsf@ebiederm.dsl.xmission.com>
	<1170015805.26655.15.camel@localhost.localdomain>
	<45BD0BDC.40205@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tony.luck@intel.com, grundler@parisc-linux.org,
	linux-kernel@vger.kernel.org, kyle@parisc-linux.org,
	linuxppc-dev@ozlabs.org, ebiederm@xmission.com, greg@kroah.com,
	shaohua.li@intel.com, mingo@elte.hu,
	linux-pci@atrey.karlin.mff.cuni.cz, brice@myri.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jeff Garzik <jeff@garzik.org>
Date: Sun, 28 Jan 2007 15:47:24 -0500

> I think the high-level ops approach makes more sense.  It's more future 
> proof, in addition to covering all existing implementations.

I totally agree with this.
