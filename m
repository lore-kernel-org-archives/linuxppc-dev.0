Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 872D3DE060
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 07:59:45 +1100 (EST)
In-Reply-To: <1204663317.21545.73.camel@pasglop>
References: <1204588953.7921.13.camel@basalt>
	<20080303213718.12291eee@zod.rchland.ibm.com>
	<200803040715.22301.sr@denx.de> <1204612384.21545.50.camel@pasglop>
	<9eeb7e8e1acf8a9217a5121fe4ec69d8@kernel.crashing.org>
	<1204663317.21545.73.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1a852cd10d2aab54aaa7d810649ab1b3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Bamboo PCI interrupt issues
Date: Tue, 4 Mar 2008 21:59:28 +0100
To: benh@kernel.crashing.org
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>,
	linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> More generally, the target interrupt descriptors (sense values, in
>> particular) in a device tree interrupt map describe the interrupts as
>> seen on the target interrupt controller, *not* as seen on this 
>> (source)
>> interrupt domain.  This should be obvious, but since the source
>> interrupt
>> descriptor for PCI doesn't have a sense value (it's always level low,
>> after all), it can be confusing.  Well, interrupts always are 
>> confusing
>> :-)
>
> Sure. But if your stupid bridge sticks a not gate between the PIRQ 
> input
> and the UIC (interrupt controller), effectively, the UIC sees a 
> reversed
> polarity. Thus you need to put in your interrupt map a reversed 
> polarity
> information for the UIC interrupt specifiers.

That's what I said, isn't it?  :-)


Segher
