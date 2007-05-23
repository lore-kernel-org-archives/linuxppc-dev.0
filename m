Return-Path: <pterry@micromemory.com>
Received: from mail.micromemory.com
	(ip67-95-226-82.z226-95-67.customer.algx.net [67.95.226.82])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D22BADDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 01:42:38 +1000 (EST)
Received: from [192.168.0.90] by micromemory.com (MDaemon PRO v9.5.6)
	with ESMTP id md50000412553.msg
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 08:42:34 -0700
Subject: RE: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
From: Phil Terry <pterry@micromemory.com>
To: Wei.Zhang@freescale.com
In-Reply-To: <46B96294322F7D458F9648B60E15112C234AEC@zch01exm26.fsl.freescale.net>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
	<20070523133238.GB942@mag.az.mvista.com>
	<46B96294322F7D458F9648B60E15112C234AEC@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Wed, 23 May 2007 08:42:32 -0700
Message-Id: <1179934952.11247.18.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: pterry@micromemory.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-23 at 22:03 +0800, Zhang Wei-r63237 wrote:
> Hi, Mark
> 
> Yes, I'm glad to share it. I have added the memory mapping codes into
> it.
I have memory mapping requirements for my board above and beyond the
current driver. I'd like to see the above to see if its addressing my
needs.
> 
> These codes are reviewing and testing with our engineers. Could you
> waiting for a little while? It will be soon.
Well I'm stuck for hw to test on at the moment so I don't need tested
patches right now but I would like to see whats covered so I can check
what I still need to do for my application. Soon means???

Cheers
Phil

> 
> Best Regards,
> Zhang Wei
> 
> > -----Original Message-----
> > From: Mark A. Greer [mailto:mgreer@mvista.com] 
> > Sent: Wednesday, May 23, 2007 9:33 PM
> > To: Zhang Wei-r63237
> > Cc: pterry@micromemory.com; linuxppc-dev@ozlabs.org
> > Subject: Re: Porting RapidIO from ppc arch to powerpc arch in 
> > support of MPC8641D
> > 
> > On Wed, May 23, 2007 at 09:26:59PM +0800, Zhang Wei-r63237 wrote:
> > > I've finished the porting RIO from ppc to powerpc, do you need some
> > > helps?
> > 
> > Care to share the patches?
> > 
> > Mark
> > 
> 
> 
