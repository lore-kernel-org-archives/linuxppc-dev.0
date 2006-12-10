Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C7A8167B6C
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Dec 2006 23:17:50 +1100 (EST)
In-Reply-To: <200612091236.57252.arnd@arndb.de>
References: <20061208114113.2191e446@localhost>
	<1165618381.1103.89.camel@localhost.localdomain>
	<F6853CAA-5CBD-4BA8-A330-55D66AB3E853@kernel.crashing.org>
	<200612091236.57252.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D4C188FC-1FCF-4E56-8A9B-3701CEF84C2A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch] powerpc: add scanning of ebc bus to of_platform
Date: Sun, 10 Dec 2006 13:17:39 +0100
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> That's probably best -- no sense in registering devices
>> on buses that the platform doesn't know how to drive!
>
> But the platform doesn't need how to drive them, the device driver
> needs to.

No -- the platform needs to know how to do low-level
bus operations (I/O reads, etc).  For most memory-mapped
buses this is pretty trivial, of course.

Maybe we're just disagreeing over the word "platform"
here?


Segher
