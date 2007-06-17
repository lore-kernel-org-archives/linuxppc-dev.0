Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E65CBDDDE7
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 00:45:26 +1000 (EST)
In-Reply-To: <200706170214.11247.arnd@arndb.de>
References: <20070612163016.253915076@arndb.de>
	<200706150151.40056.arnd@arndb.de>
	<21B37470-5341-4AC7-9334-B58F0BCFAAC9@kernel.crashing.org>
	<200706170214.11247.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4E0AC3E6-98F8-40BD-BA85-60766E097E4A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 00/13] CPU selection Kconfig cleanup, take 3
Date: Sun, 17 Jun 2007 09:46:01 -0500
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


On Jun 16, 2007, at 7:14 PM, Arnd Bergmann wrote:

> On Sunday 17 June 2007, Kumar Gala wrote:
>>> For the 'at least one option selected' argument, I'm not sure how
>>> important that is, IMHO it falls into the same category as any
>>> other essential option that you can disable.
>>
>> People have run into the issue so I think it desires at least a
>> little concern.  See: http://marc.info/?t=117529164800005&r=1&w=2
>
> But isn't the reported problem just a bug in the build system?
> My impression was that the user did not complain about the fact
> that the kernel he was trying to build would not boot on any
> platform, but rather that the kernel tried to build a zImage
> that was not defined, resulting in a build error.
>
> Obviously, any configuration that can be selected by the user
> should be able to compile and link without errors, even if it's
> not particularly useful.
>
> Aside from the multiplatform enabling patches, are you happy with
> the patches 1-8 from my fourth version of the patch set?

I commented on some minor nits with the patches.  I'm probably ok  
with patches 1-7 going in.  I'm not ready for 8 at this point, we  
need to do more proper cleanup to get 85xx/cpm2 support into a  
multiplatforms single kernel state.

- k
