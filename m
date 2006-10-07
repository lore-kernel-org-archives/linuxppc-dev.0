Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F18A67E79
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Oct 2006 01:16:44 +1000 (EST)
In-Reply-To: <1160233817.4795.85.camel@pmac.infradead.org>
References: <1160148208.4795.30.camel@pmac.infradead.org>
	<1160170374.22232.135.camel@localhost.localdomain>
	<20061007145811.GA4043@krispykreme>
	<1160233817.4795.85.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BBD9FB3D-EF0F-4698-BD64-25D77844CD39@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: vsdo_datapage.h WTF?
Date: Sat, 7 Oct 2006 17:16:35 +0200
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> We need a way to export cache size/associativity information (sysfs,
>> /proc/device-tree parsing?) and a plan to fix the applications using
>> it first.
>
> ELF auxvec?

sysfs is the only choice that stands a chance of being
cross-platform portable (which should be an important goal
of exporting this information at all).


Segher
