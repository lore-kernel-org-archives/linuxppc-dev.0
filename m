Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C1A26DDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 00:47:33 +1000 (EST)
In-Reply-To: <20070514011915.GH6517@localhost.localdomain>
References: <20070511175553.GA14692@ld0162-tx32.am.freescale.net>
	<20070514011915.GH6517@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c754337f305dd81a568ac3564c2f2cfe@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [DTC PATCH] Remove overreaching semantic tests.
Date: Mon, 14 May 2007 14:40:19 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Exactly - which is why I really don't want to simply tear out this
> checking code.  I've never gotten around to reworking the
> error/warning system so it can sensibly divide things into such
> classes, and keep detecting further warnings after picking up some
> non-fatal ones and so forth.
>
> I'd much prefer you just disable these tests for now, either by
> commenting code out, or removing calls to checking functions.  That
> will make it easier to optionally reinstate later.

IMO it would be better to have a separate tool to do
semantical checking on a DTB.  Until that exists, it
can be helpful to have some checks in the DT compiler.


Segher
