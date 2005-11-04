Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7878568679
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Nov 2005 08:49:37 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vivenzio Pagliari <vivenzio@web.de>
In-Reply-To: <436BB734.5010409@web.de>
References: <1130999620.4680.28.camel@gaston>
	<60381eeb0511030103w551fad25h3d9d7fa258764d5e@mail.gmail.com>
	<1131052876.4680.78.camel@gaston>
	<60381eeb0511032313i426db0c8o7254009240f6988a@mail.gmail.com>
	<1131088730.4680.251.camel@gaston>  <436BB734.5010409@web.de>
Content-Type: text/plain
Date: Sat, 05 Nov 2005 08:48:31 +1100
Message-Id: <1131140912.29195.15.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	Eddy =?iso-8859-2?Q?Petri=BAor?= <eddy.petrisor@gmail.com>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-11-04 at 20:32 +0100, Vivenzio Pagliari wrote:
> Benjamin Herrenschmidt wrote:
> > 
> > I would say your first mistake is to use PREEMPT :) There are various
> > issues with PREEMPT on ppc32 that have not really been addressed so far,
> > and the USB code has some "holes" that I wouldn't trust in a PREEMPT
> > environment.
> > 
> 
> What do you mean exactly? Should CONFIG_PREEMPT not be used?
> And what about CONFIG_PREEMPT_VOLUNTARY?

I would avoid both for now.

Ben.
