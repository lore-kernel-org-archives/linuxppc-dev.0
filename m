Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CAB0686DF
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2005 12:53:33 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eddy =?iso-8859-2?Q?Petri=BAor?= <eddy.petrisor@gmail.com>
In-Reply-To: <60381eeb0511091712u115979f2jf92717a3641f7952@mail.gmail.com>
References: <1130999620.4680.28.camel@gaston> <436F1A9E.80105@idtect.com>
	<1131397208.4652.41.camel@gaston>
	<60381eeb0511091712u115979f2jf92717a3641f7952@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 10 Nov 2005 12:51:28 +1100
Message-Id: <1131587489.24637.132.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-11-10 at 03:12 +0200, Eddy Petrişor wrote:
> On 11/7/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > > i've applied your patch and it seems that when i put my powerbook to
> > > sleep ( by closing the lid ) the kernel just crashes since everytime i
> > > come back, the machine is turned off. I had a look at the logs and i see
> > > that i'm having a reboot almost immediateley after the lid is closed.
> > > However i've got no trace of a kernel panic .....
> > > my conf:
> >
> > What about this patch ?
> 
> I tried to apply this patch and the previous one over 2.6.14, but they failed.
> I also tied to apply the second patch over the first, also the third
> over the first, but I had the same result.
> 
> Over which version should these pacthes be applied?

2.6.14 :) (But not some git checkout from after 2.6.14 release)

Ben.
