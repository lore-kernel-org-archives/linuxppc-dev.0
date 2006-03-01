Return-Path: <bcollins@ubuntu.com>
Received: from a34-mta02.direcway.com (a34-mta02.direcpc.com [66.82.4.91])
	by ozlabs.org (Postfix) with ESMTP id D1C5467B33
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Mar 2006 10:50:30 +1100 (EST)
Received: from mail.phunnypharm.org ([72.169.114.90]) by a34-mta02.direcway.com
	(iPlanet Messaging Server 5.2 HotFix 1.25 (built Mar  3 2004))
	with ESMTP id <0IVH00KTM3JWPS@a34-mta02.direcway.com> for
	linuxppc-dev@ozlabs.org; Wed, 01 Mar 2006 18:50:27 -0500 (EST)
Date: Wed, 01 Mar 2006 18:49:25 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
In-reply-to: <1141254596.3889.26.camel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-id: <1141256965.4378.145.camel@grayson>
MIME-version: 1.0
Content-type: text/plain
References: <jehd7527wq.fsf@sykes.suse.de>
	<1139783738.5247.54.camel@localhost.localdomain>
	<20060226173908.GA4871@suse.de> <20060301223034.GA5965@suse.de>
	<1141254596.3889.26.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Ben Collins <ben.collins@ubuntu.com>, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-03-02 at 10:09 +1100, Benjamin Herrenschmidt wrote:
> > > This (sort of) breaks PowerMac3,4 (69 (PowerMac G4 Silver)). I have to
> > > force it on up to now, but with this patch the internal speaker will not
> > > work with or without my patch to force it on.
> > 
> > But the patch fixes also my PowerBook4,1, I dont have to toggle the headphone
> > once to get the built-in speakers enabled.
> > Looks like 2.6.16 stuff, but its been broken for so long now...
> 
> What is the status of Ben's latest stuff ?

I'm rediffing now. However, I may not include my tumbler changes
immediately. For some reason, those are the ones causing problems. I
need to review the diff and see if I can find the problem (which I
cannot reproduce).

The toonie stuff is great. Been working really well for all the folks
I've heard from, and for me on my PowerBook5,9.

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/
