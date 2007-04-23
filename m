Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 87374DDF13
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 07:25:12 +1000 (EST)
In-Reply-To: <3C290CCE-1B71-448A-8454-0C08BCF93279@freescale.com>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<95a9680c565aa196a4ef78964ef9dee1@kernel.crashing.org>
	<20070416102533.0f87396f.kim.phillips@freescale.com>
	<C793D7D1-CA26-4DCB-B513-56E927BF6BA9@kernel.crashing.org>
	<ba8618e3bd28389b66262e549387ac8d@kernel.crashing.org>
	<20070416115729.292c10b1.kim.phillips@freescale.com>
	<53810df560c7af272cd1c71c9d5fa1ab@kernel.crashing.org>
	<20070416193110.77b63e4b.kim.phillips@freescale.com>
	<788e650fbb3f95eaf1bfb6955f9cef17@kernel.crashing.org>
	<20070417152712.51c7348f.kim.phillips@freescale.com>
	<f170b2c44ae8a76dd4d35ceb94a624b0@kernel.crashing.org>
	<20070417201350.12727df7.kim.phillips@freescale.com>
	<524e7cf7aec7be8289ab2f99df8a0776@kernel.crashing.org>
	<20070418164849.6f0fd817.kim.phillips@freescale.com>
	<d16d2a0d1742a32e45597baabfc3735a@kernel.crashing.org>
	<6358CE18-B118-4BC1-B46A-D485449273D5@freescale.com>
	<19b21e979d2b23eba0073dadc7c65620@kernel.crashing.org>
	<3C290CCE-1B71-448A-8454-0C08BCF93279@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e58f755b0bf5535c99dd1ef2f603d5f7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Date: Mon, 23 Apr 2007 23:24:04 +0200
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> On some configurations, what PHY to use is a runtime
>> decision, not a static thing.  No device tree change
>> is necessary then.
>
> 1) Could you give me an example?

Some older (plugin) cards are like that.  I don't have
model numbers handy, sorry.

> 2) So you'd be having Linux ignore the phandle, then?

No, Linux would find all the PHYs connected, via the
device tree, and handle them all within the driver.


Segher
