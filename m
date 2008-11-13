Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2FFCCDDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 04:55:13 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mADHsGiD000403
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 10:54:16 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mADHt0D3120032
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 10:55:01 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mADHsU83021340
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 10:54:31 -0700
Date: Thu, 13 Nov 2008 12:54:51 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 11/11] ppc440spe-adma: ADMA driver for PPC440SP(e) systems
Message-ID: <20081113125451.4a7bd7d9@zod.rchland.ibm.com>
In-Reply-To: <491C68F3.3030102@emcraft.com>
References: <1226589364-5619-1-git-send-email-yanok@emcraft.com>
	<1226589364-5619-12-git-send-email-yanok@emcraft.com>
	<20081113160307.GB2299@yoda.jdub.homelinux.org>
	<491C68F3.3030102@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, wd@denx.de,
	dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 13 Nov 2008 20:50:43 +0300
Ilya Yanok <yanok@emcraft.com> wrote:

> Josh Boyer wrote:
> > On Thu, Nov 13, 2008 at 06:16:04PM +0300, Ilya Yanok wrote:
> >   
> >> Adds the platform device definitions and the architecture specific support
> >> routines for the ppc440spe adma driver.
> >>
> >> Any board equipped with PPC440SP(e) controller may utilize this driver.
> >>
> >> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> >> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> >>     
> >
> > Before I really dig into reviewing this driver, I'm going to ask you as simple
> > question.  This looks like a 1/2 completed port of an arch/ppc driver that uses
> > the device tree (incorrectly) to get the interrupt resources and that's about it.
> > Otherwise, it's just a straight up platform device driver.  Is that correct?
> >   
> 
> Yep, that's correct.

OK.

> > If that is the case, I think the driver needs more work before it can be merged.
> > It should get the DCR and MMIO resources from the device tree as well.  It should
> > be binding on compatible properties and not based on device tree paths.  And it
> > should probably be an of_platform device driver.
> >   
> 
> Surely, you're right. I agree with you in that this driver isn't ready
> for merging. But it works so we'd like to publish it so interested
> people could use it and test it.

And that's fine.  I just wanted to see where you were headed with this
one for now.  I'll try to do a review in the next few days.  Thanks for
posting.

josh
