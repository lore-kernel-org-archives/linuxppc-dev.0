Return-Path: <jdl@jdl.com>
Received: from jdl.com (colo.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8EFA967B1D
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 09:11:43 +1000 (EST)
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/9 v3] Add the MPC8641 HPCN platform files. 
In-Reply-To: Your message of "Tue, 20 Jun 2006 00:44:35 +0200."
	<A609CF22-66E8-404C-A6F2-528BE097BF57@kernel.crashing.org>
References: <E1Frjen-0004Oz-Hz@jdl.com>
	<1150600056.23600.152.camel@localhost.localdomain>
	<1150725866.9022.5.camel@cashmere.sps.mot.com>
	<F34E213C-B073-4D85-A323-644340E3C09D@kernel.crashing.org>
	<E1FsSOB-0000CE-2o@jdl.com>
	<A609CF22-66E8-404C-A6F2-528BE097BF57@kernel.crashing.org>
Date: Mon, 19 Jun 2006 18:11:39 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FsSuB-0000Qc-P6@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Segher Boessenkool mumbled:
> 
> In that case you obviously need to sync the timebases, sure.
> The firmware could be smart and do the sync at CPU start-up
> time though.

I am investigating this and, as I indicated to Ben, submit
a follow up patch to  implement it if I figure out to do it.

> In
> some cases the kernel explicitly tells the firmware to start/
> stop the timebases, that's better than the kernel having to
> handle the nitty-gritty details itself already.
> 
> Thoughts?

Well, by the time Linux is running, there is no more firmware
available.  Linux is essentially autononomous at this stage,
and I think it will have to arrange for the TB sync itself.

jdl
