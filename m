Return-Path: <jdl@jdl.com>
Received: from jdl.com (mail.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE62E67B28
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 09:52:07 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1FsTXI-0000Wq-3s
	for linuxppc-dev@ozlabs.org; Mon, 19 Jun 2006 18:52:04 -0500
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 5/9 v3] Add the MPC8641 HPCN platform files. 
In-Reply-To: Your message of "Tue, 20 Jun 2006 01:36:41 +0200."
	<BF0ECF8F-8083-47E7-A0DB-76801C7E8ADD@kernel.crashing.org>
References: <E1Frjen-0004Oz-Hz@jdl.com>
	<1150600056.23600.152.camel@localhost.localdomain>
	<1150725866.9022.5.camel@cashmere.sps.mot.com>
	<F34E213C-B073-4D85-A323-644340E3C09D@kernel.crashing.org>
	<E1FsSOB-0000CE-2o@jdl.com>
	<A609CF22-66E8-404C-A6F2-528BE097BF57@kernel.crashing.org>
	<E1FsSuB-0000Qc-P6@jdl.com>
	<F5D6E2FC-CE35-4681-9F42-A1B4E2BFE097@kernel.crashing.org>
	<E1FsTE0-0000U4-Mp@jdl.com>
	<BF0ECF8F-8083-47E7-A0DB-76801C7E8ADD@kernel.crashing.org>
Date: Mon, 19 Jun 2006 18:52:04 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FsTXI-0000Wq-3s@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Segher Boessenkool mumbled:
> So you start them with a GPIO?

Yeah, magic system register write.

>  Would it be feasible to
> sync the time bases right there?  Constrain the ugliness
> to just that one spot, as it were.  Although it ends up
> with the same complexity, sigh.

That's the sort of thing I will be investigating, yep...

jdl
