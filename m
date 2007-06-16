Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 043D9DDDF5
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 23:42:22 +1000 (EST)
In-Reply-To: <200706161506.33589.mb@bu3sch.de>
References: <200706141739.12754.mb@bu3sch.de>
	<1181955074.26853.105.camel@localhost.localdomain>
	<200706161504.41168.mb@bu3sch.de> <200706161506.33589.mb@bu3sch.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dd677c0cd2ce32d05fa425afd7cff306@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Powerbook hard shutdown after boot if it's hot
Date: Sat, 16 Jun 2007 15:42:15 +0200
To: Michael Buesch <mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Oh, and I completely forgot to say that this problem does
> not exist when booting OSX. So if I try to boot linux and it
> fails because of the issue and I immediately boot OSX it will succeed.

Right -- and if you're running OSX (and run the box hot),
and then boot Linux, does it happen then?


Segher
