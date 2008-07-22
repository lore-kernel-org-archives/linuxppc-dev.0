Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06C9DDE2FF
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 23:11:42 +1000 (EST)
Message-Id: <9D2D9C95-C2B7-408C-BDA1-89B7748F6977@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: benh@kernel.crashing.org
In-Reply-To: <1216711931.11027.193.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [git pull] Please pull from powerpc.git merge branch
Date: Tue, 22 Jul 2008 08:11:25 -0500
References: <1216711931.11027.193.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 22, 2008, at 2:32 AM, Benjamin Herrenschmidt wrote:

> Hi Linus !
>
> Here's the second batch of powerpc updates. I should have a last one
> before the end of the merge window for things that are stealing  
> dealing
> with conflicts or dependencies but we are getting there.
>
> So please pull from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge
>
> Hopefully this one shouldn't whack the main Makefile :-)
>
> Note a couple of fbdev updates. One is an offb change by me, this is
> a powerpc specific driver so that shouldn't affect anybody else, and
> one is the ps3 specific fbdev by Geoff, so again, there should be
> no collateral damage.
>
> Some drivers/net changes to freescale specific drivers are coming from
> Kumar's tree. Kumar, I merged them, however, shouldn't we have Jeff's
> ack on these things or is it ok as long as those are arch specific
> drivers and the changes boring ?

they had jeff's ack.  I just didn't update the commits, my bad and  
I'll fix that in the future.

- k
