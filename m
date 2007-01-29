Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E4B10DDEA2
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 16:25:56 +1100 (EST)
Date: Sun, 28 Jan 2007 21:25:54 -0800 (PST)
Message-Id: <20070128.212554.23015561.davem@davemloft.net>
To: ebiederm@xmission.com
Subject: Re: [PATCH 0/6] MSI portability cleanups
From: David Miller <davem@davemloft.net>
In-Reply-To: <m1tzyammv0.fsf@ebiederm.dsl.xmission.com>
References: <m1hcuaohqj.fsf@ebiederm.dsl.xmission.com>
	<20070128.153707.30184351.davem@davemloft.net>
	<m1tzyammv0.fsf@ebiederm.dsl.xmission.com>
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
Date: Sun, 28 Jan 2007 22:18:59 -0700

> Regardless of my opinion on the sanity of the hypervisor architects.
> I have not seen anything that indicates it will be hard to support
> the hypervisor doing everything or most of everything for us, so
> I see no valid technical objection to it.  Nor have I ever.
> 
> So I have no problem with additional patches in that direction.

Ok, that's great to hear.

I know your bi-directional approach isn't exactly what Ben
wants but he can support his machines with it.  Maybe after
some time we can agree to move from that more towards the
totally abstracted scheme.
