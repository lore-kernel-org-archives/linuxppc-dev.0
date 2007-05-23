Return-Path: <pterry@micromemory.com>
Received: from mail.micromemory.com
	(ip67-95-226-82.z226-95-67.customer.algx.net [67.95.226.82])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8E36DDF32
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 01:54:17 +1000 (EST)
Received: from [192.168.0.90] by micromemory.com (MDaemon PRO v9.5.6)
	with ESMTP id md50000412570.msg
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 08:54:15 -0700
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
Date: Wed, 23 May 2007 08:54:13 -0700
Message-Id: <1179935653.11247.27.camel@pterry-fc6.micromemory.com>
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
> 
> These codes are reviewing and testing with our engineers. 

Can you tell me what your testing it on cos we need to get a good
interim base for our own development. The 8641_hpcn doesn't have support
for serial rapidio so I was looking at the 8548 eval system. The ltib
support is way back at 2.6.10 for that board but I was going to try and
make my powerpc/rapidio support both the 8641 and 8548 so I could test
in this way. Is your patch generic or 8641 specific?

Also either on this list or privately can you tell me what the plans are
for migrating the other freescale processors to powerpc and updating to
the latest kernel?

Cheers
Phil

> Could you
> waiting for a little while? It will be soon.
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
