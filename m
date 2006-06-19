Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FF3267B20
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 08:38:42 +1000 (EST)
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/9 v3] Add the MPC8641 HPCN platform files. 
In-Reply-To: Your message of "Tue, 20 Jun 2006 00:06:43 +0200."
	<F34E213C-B073-4D85-A323-644340E3C09D@kernel.crashing.org>
References: <E1Frjen-0004Oz-Hz@jdl.com>
	<1150600056.23600.152.camel@localhost.localdomain>
	<1150725866.9022.5.camel@cashmere.sps.mot.com>
	<F34E213C-B073-4D85-A323-644340E3C09D@kernel.crashing.org>
Date: Mon, 19 Jun 2006 17:38:35 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FsSOB-0000CE-2o@jdl.com>
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
> Btw, IMNSHO, it should be the firmware's job to synchronise
> the timebases, even before the kernel gets started; at least
> as the default.  We don't want to have millions of separate
> GPIO thingies, one for every board, unless really necessary,
> I think?

The second CPU isn't even running in the firmware.
It is in hard-reset until Linux says "Hey, start that
secondary CPU for me!".

Thanks,
jdl
