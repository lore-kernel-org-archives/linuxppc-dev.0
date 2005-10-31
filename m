Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 50F60685E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Nov 2005 02:30:03 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 31 Oct 2005 17:29:57 +0200
References: <200510280857.44625.david.jander@protonic.nl>
	<003501c5de1a$be79b390$0301a8c0@chuck2>
	<200510311408.41691.david.jander@protonic.nl>
In-Reply-To: <200510311408.41691.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510311629.57608.david.jander@protonic.nl>
Subject: Re: Kernel 2.6 on MPC8xx performance trouble...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 31 October 2005 14:08, David Jander wrote:
> On Monday 31 October 2005 13:58, Mark Chambers wrote:
> >[...]
> >
> > > No, sir, no cache detected !
> > >
> > > Where do I have to look now?
> >
> > Could the cache be in writethrough mode? (Instead of writeback)
>
> Good point. I just checked the same test, but reading instead of writing.
> Same result, no cache detected.
>
> I know how to change cache policy in u-boot, but does the kernel change
> that? If so, where?

Sorry for the stupid question. I did not remember it was there right before my 
eyes. It seems I just got lost in the new menu structure of the Kconfig.
And yes, cache was in writethrough mode!!
It seems as though this option disables cache entirely, because after turning 
it on, I suddenly get 2.4-type speed measurements.
With CONFIG_8xx_COPYBACK undefined, both reading and writing gives results as 
if there was simply no cache. Shouldn't it at least speed up memory-read 
access?
Sorry to everone for wasting their time with this stupid mistake of mine.
Thanks for all the help anyway.

Greetings,

-- 
David Jander
