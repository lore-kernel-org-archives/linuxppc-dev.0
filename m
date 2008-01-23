Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF713DDF57
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 06:38:54 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0NJco4C022533
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 14:38:50 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0NJcnwU114242
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 12:38:49 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0NJcnhH015535
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 12:38:49 -0700
Date: Wed, 23 Jan 2008 13:35:41 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCHv2 0/8] [POWERPC] 8xx cleanups
Message-ID: <20080123133541.24163d18@zod.rchland.ibm.com>
In-Reply-To: <20080123180012.GA23313@uranus.ravnborg.org>
References: <4797641F.4000902@scram.de>
	<CA8FFE19-B84A-426B-9B1C-EF0F7C87AE47@kernel.crashing.org>
	<20080123171252.GA22967@uranus.ravnborg.org>
	<47977A02.40506@freescale.com>
	<20080123180012.GA23313@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 Jan 2008 19:00:12 +0100
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Wed, Jan 23, 2008 at 11:31:46AM -0600, Jon Loeliger wrote:
> > Sam Ravnborg wrote:
> > >>What impact do the have on boards in arch/ppc being able to build?
> > >
> > >Byt the way what are the plans for powerpc?
> > >We have:
> > >arch/ppc
> > >arch/ppc64
> > >arch/powerpc
> > >
> > >It was my understanding that arch/powerpc was supposed
> > >to be the future unified powerpc architecture but it
> > >does not even provide a defconfig.
> > >
> > >And I do not see too much happening to do so - but that maybe
> > >because I looked at a wrong place.
> > 
> > You must have looked in the wrong place. :-)
> > 
> > arch/ppc is scheduled for removal from mainline in June.
> Good to hear.
> 
> > arch/powerpc is under significant development, with lots
> > of defconfigs in arch/powerpc/configs.
> Double checked - it was my build script that used ARCH=ppc
> Now I just need to build another toolchain as the ppc750 could not build
> the defconfig. crosstool is my friend here.

You'll need mkimage if you ever venture into some of the embedded board
configs.  Just an FYI.

josh
