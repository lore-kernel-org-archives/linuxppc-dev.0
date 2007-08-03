Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F3EEADDE19
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 22:59:12 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l73Cx9SX016293
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 08:59:09 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l73Cx9iG236496
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 06:59:09 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l73Cx99v023873
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 06:59:09 -0600
Date: Fri, 3 Aug 2007 07:59:08 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 4/6] PowerPC 440EPx: Sequoia bootwrapper
Message-ID: <20070803075908.6c762db3@weaponx.rchland.ibm.com>
In-Reply-To: <200708030838.25574.sr@denx.de>
References: <20070730151445.GA5075@ru.mvista.com>
	<20070802152941.579a55fa@weaponx.rchland.ibm.com>
	<200708030838.25574.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 3 Aug 2007 08:38:25 +0200
Stefan Roese <sr@denx.de> wrote:

> > > +static void ibm440epx_fixup_memsize(void)
> >
> > And we should move this at the same time.  Isn't denali used by another
> > CPU as well?
> 
> Right now the Denali DDR(2) core is only used by the 440EPx/440GRx. But other 
> AMCC PPC's using it will follow soon.

So that would be a yes :)  Good.  Then we should add the function to
4xx.c and call it ibm4xx_denali_fixup_memsize.

josh
