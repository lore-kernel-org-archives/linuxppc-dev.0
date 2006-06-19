Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AF4E767B8B
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 09:18:17 +1000 (EST)
In-Reply-To: <E1FsSuB-0000Qc-P6@jdl.com>
References: <E1Frjen-0004Oz-Hz@jdl.com>
	<1150600056.23600.152.camel@localhost.localdomain>
	<1150725866.9022.5.camel@cashmere.sps.mot.com>
	<F34E213C-B073-4D85-A323-644340E3C09D@kernel.crashing.org>
	<E1FsSOB-0000CE-2o@jdl.com>
	<A609CF22-66E8-404C-A6F2-528BE097BF57@kernel.crashing.org>
	<E1FsSuB-0000Qc-P6@jdl.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F5D6E2FC-CE35-4681-9F42-A1B4E2BFE097@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/9 v3] Add the MPC8641 HPCN platform files. 
Date: Tue, 20 Jun 2006 01:18:06 +0200
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

>> In that case you obviously need to sync the timebases, sure.
>> The firmware could be smart and do the sync at CPU start-up
>> time though.
>
> I am investigating this and, as I indicated to Ben, submit
> a follow up patch to  implement it if I figure out to do it.

Great.

>> In
>> some cases the kernel explicitly tells the firmware to start/
>> stop the timebases, that's better than the kernel having to
>> handle the nitty-gritty details itself already.
>>
>> Thoughts?
>
> Well, by the time Linux is running, there is no more firmware
> available.  Linux is essentially autononomous at this stage,
> and I think it will have to arrange for the TB sync itself.

I'm confused now.  So are or arent't all CPUs running at the
time Linux is started?  Are you saying Linux manually starts
all non-boot CPUs?!?


Segher
