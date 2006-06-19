Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 71F7967A6C
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 08:06:58 +1000 (EST)
In-Reply-To: <1150725866.9022.5.camel@cashmere.sps.mot.com>
References: <E1Frjen-0004Oz-Hz@jdl.com>
	<1150600056.23600.152.camel@localhost.localdomain>
	<1150725866.9022.5.camel@cashmere.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F34E213C-B073-4D85-A323-644340E3C09D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/9 v3] Add the MPC8641 HPCN platform files.
Date: Tue, 20 Jun 2006 00:06:43 +0200
To: Jon Loeliger <jdl@freescale.com>
Cc: Jon Loeliger <jdl@jdl.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On 19-jun-2006, at 16:04, Jon Loeliger wrote:

> On Sat, 2006-06-17 at 22:07, Benjamin Herrenschmidt wrote:
>
>>
>> You don't have any way to freeze the timebase ? (No GPIO controlling
>> TBEN ?) It's pretty nasty to rely on software sync,

Btw, IMNSHO, it should be the firmware's job to synchronise
the timebases, even before the kernel gets started; at least
as the default.  We don't want to have millions of separate
GPIO thingies, one for every board, unless really necessary,
I think?


Segher
