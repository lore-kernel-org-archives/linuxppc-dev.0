Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2C4B67B17
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 09:36:49 +1000 (EST)
In-Reply-To: <E1FsTE0-0000U4-Mp@jdl.com>
References: <E1Frjen-0004Oz-Hz@jdl.com>
	<1150600056.23600.152.camel@localhost.localdomain>
	<1150725866.9022.5.camel@cashmere.sps.mot.com>
	<F34E213C-B073-4D85-A323-644340E3C09D@kernel.crashing.org>
	<E1FsSOB-0000CE-2o@jdl.com>
	<A609CF22-66E8-404C-A6F2-528BE097BF57@kernel.crashing.org>
	<E1FsSuB-0000Qc-P6@jdl.com>
	<F5D6E2FC-CE35-4681-9F42-A1B4E2BFE097@kernel.crashing.org>
	<E1FsTE0-0000U4-Mp@jdl.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BF0ECF8F-8083-47E7-A0DB-76801C7E8ADD@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/9 v3] Add the MPC8641 HPCN platform files. 
Date: Tue, 20 Jun 2006 01:36:41 +0200
To: Jon Loeliger <jdl@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>  Are you saying Linux manually starts
>> all non-boot CPUs?!?
>
> Right.  The secondary CPUs are not clocking, not able to
> fetch memory, not nothing until Linux gets a shot at
> smp_secondary_kick()'ing them into motion.  And then we
> have the ability to start the scondary CPUs one at a time.

So you start them with a GPIO?  Would it be feasible to
sync the time bases right there?  Constrain the ugliness
to just that one spot, as it were.  Although it ends up
with the same complexity, sigh.


Segher
