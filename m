Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 38836DDE43
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jun 2007 09:52:17 +1000 (EST)
In-Reply-To: <200706150151.40056.arnd@arndb.de>
References: <20070612163016.253915076@arndb.de>
	<18032.40447.579128.989284@cargo.ozlabs.ibm.com>
	<B4E893D5-A61E-4A91-B31C-AF9B7C0B116D@kernel.crashing.org>
	<200706150151.40056.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <21B37470-5341-4AC7-9334-B58F0BCFAAC9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 00/13] CPU selection Kconfig cleanup, take 3
Date: Sat, 16 Jun 2007 18:52:51 -0500
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


On Jun 14, 2007, at 6:51 PM, Arnd Bergmann wrote:

> On Thursday 14 June 2007, Kumar Gala wrote:
>> I'm a little hesitant to move the embedded ppc's over to
>> multiplatform quite yet.  One feature I wanted was in Kconfig a way
>> to enforce the selection of at least one choice, as well as being
>> able to optimize things since we only had one choice selected.
>
> What would such a potential optimization be like? Are you thinking
> of turning the 'platform_is(foo)' check into a compile-time choice,
> or are there more places where you can imagine an optimization?
> I'd like to understand better what you want to achieve there,
> maybe I can find a way to do that in the same series.

Sort of, in that if we were built with the  
CONFIG_ONLY_HAD_ONE_MACHINE we could optimize the machine_is() checks  
away.

> For the 'at least one option selected' argument, I'm not sure how
> important that is, IMHO it falls into the same category as any
> other essential option that you can disable.

People have run into the issue so I think it desires at least a  
little concern.  See: http://marc.info/?t=117529164800005&r=1&w=2

- k
