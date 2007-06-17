Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2FAF7DDECA
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jun 2007 10:22:28 +1000 (EST)
In-Reply-To: <200706170214.11247.arnd@arndb.de>
References: <20070612163016.253915076@arndb.de>
	<200706150151.40056.arnd@arndb.de>
	<21B37470-5341-4AC7-9334-B58F0BCFAAC9@kernel.crashing.org>
	<200706170214.11247.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <f8a87cbd246847e830d0e6e986eec408@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 00/13] CPU selection Kconfig cleanup, take 3
Date: Sun, 17 Jun 2007 02:22:22 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> People have run into the issue so I think it desires at least a =A0
>> little concern. =A0See: http://marc.info/?t=3D117529164800005&r=3D1&w=3D=
2
>
> But isn't the reported problem just a bug in the build system?

Yes, that's a completely separate bug.

> My impression was that the user did not complain about the fact
> that the kernel he was trying to build would not boot on any
> platform, but rather that the kernel tried to build a zImage
> that was not defined, resulting in a build error.

It's the only valid complaint, anyway :-)

> Obviously, any configuration that can be selected by the user
> should be able to compile and link without errors, even if it's
> not particularly useful.

Yes.


Segher
