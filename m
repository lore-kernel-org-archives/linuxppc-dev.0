Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C198CDDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 06:09:22 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8RK9Jt3000820
	for <linuxppc-embedded@ozlabs.org>; Thu, 27 Sep 2007 16:09:19 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8RK7XJ4476734
	for <linuxppc-embedded@ozlabs.org>; Thu, 27 Sep 2007 14:09:19 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8RK3EQM001678
	for <linuxppc-embedded@ozlabs.org>; Thu, 27 Sep 2007 14:03:14 -0600
Date: Thu, 27 Sep 2007 15:03:12 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] Add platform support for the MPC837x RDB board
Message-ID: <20070927150312.4eea96fd@weaponx.rchland.ibm.com>
In-Reply-To: <20070927195351.GE7838@mag.az.mvista.com>
References: <11909173512321-git-send-email-ljd015@freescale.com>
	<20070927191036.GD7838@mag.az.mvista.com>
	<C908B0B881A6B949985D6BAA0D9469B402CD36A7@az33exm20.fsl.freescale.net>
	<20070927195351.GE7838@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: D'Abbraccio Joe-ljd015 <Joe.D'abbraccio@freescale.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 27 Sep 2007 12:53:51 -0700
"Mark A. Greer" <mgreer@mvista.com> wrote:

> On Thu, Sep 27, 2007 at 12:41:57PM -0700, D'Abbraccio Joe-ljd015 wrote:
> > Thanks for the advice, but I was just basing the list to post to on the
> > MAINTAINERS file which states that this is the one for Embedded PPC83XX.
> > If you still think that I should post to linuxppc-dev, let me know.
> 
> Yes, I think it would be better to repost to linuxppc-dev.
> 
> Does anyone have an objection to changing all of the:
> 
> 	"L:	linuxppc-embedded@ozlabs.org"
> 
> in MAINTAINERS to:
> 
> 	"L:	linuxppc-dev@ozlabs.org" ??
> 
> Kumar, Josh, Vitaly, et. al.?

I personally don't care either way.  I'm already subscribed to both
lists.

Makes sense to go to linuxppc-dev given the arch/powerpc migration.

josh
