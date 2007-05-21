Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE0C5DDE21
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 09:15:12 +1000 (EST)
Subject: Re: Interrupt routing broken on TiBook IV with 2.6.21.x ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian =?ISO-8859-1?Q?B=F6hme?= <monodhs@gmx.de>
In-Reply-To: <4652219D.6050308@gmx.de>
References: <4650E27B.3020401@gmx.de>
	<1179712614.32247.597.camel@localhost.localdomain>
	<4651FC48.8000002@gmx.de>
	<1179785502.32247.748.camel@localhost.localdomain>
	<4652219D.6050308@gmx.de>
Content-Type: text/plain; charset=utf-8
Date: Tue, 22 May 2007 09:15:04 +1000
Message-Id: <1179789304.32247.760.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-22 at 00:47 +0200, Christian Böhme wrote:
> It's not that I am not interested nor completely new to this, it's just that
> I am currently a little short on time for things like these.  The last time
> I checked, the Linux people have just started to make use of DMA maps, a
> concept that other OS/architecture combos employed for years already.  Is
> that what is used in the TiBooks to allocate DMA channels ?

I'm not sure what you are talking about here. DMA mapping has existed in
linux for years.

Ben.
