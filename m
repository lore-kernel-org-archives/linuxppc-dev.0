Return-Path: <bcollins@ubuntu.com>
Received: from a34-mta01.direcway.com (a34-mta01.direcpc.com [66.82.4.90])
	by ozlabs.org (Postfix) with ESMTP id BA9FF68A02
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jan 2006 15:44:16 +1100 (EST)
Received: from mail.phunnypharm.org ([67.142.247.22]) by a34-mta01.direcway.com
	(iPlanet Messaging Server 5.2 HotFix 2.05 (built Mar  3 2005))
	with ESMTP id <0ITE0060PZNKK2@a34-mta01.direcway.com> for
	linuxppc-dev@ozlabs.org; Fri, 20 Jan 2006 18:23:48 -0500 (EST)
Date: Fri, 20 Jan 2006 18:22:10 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [Alsa-devel] RFC: OSS driver removal,
	a slightly different	approach
In-reply-to: <1137799001.12998.59.camel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-id: <1137799330.13530.30.camel@grayson>
MIME-version: 1.0
Content-type: text/plain
References: <20060119174600.GT19398@stusta.de>
	<20060120115443.GA16582@palantir8> <20060120190415.GM19398@stusta.de>
	<20060120212917.GA14405@suse.de>
	<1137799001.12998.59.camel@localhost.localdomain>
Cc: alsa-devel@alsa-project.org, Ben Collins <ben.collins@ubuntu.com>,
	linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
	linuxppc-dev@ozlabs.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-01-21 at 10:16 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2006-01-20 at 22:29 +0100, Olaf Hering wrote:
> >  On Fri, Jan 20, Adrian Bunk wrote:
> > 
> >  
> > > Can someone from the ppc developers drop me a small note whether 
> > > SND_POWERMAC completely replaces DMASOUND_PMAC?
> > 
> > It doesnt. Some tumbler models work only after one plug/unplug cycle of
> > the headphone. early powerbooks report/handle the mute settings
> > incorrectly. there are likely more bugs.
> 
> Interesting... Ben Collins hacked something to have Toonie work as a
> "default" driver for non supported machine and saw that problem too, I
> think he fixes it, I'll check with him what's up there and if his fix
> applied to tumbler.c as well.

My "fix" was basically the result of converting to the platform
functions. It's hit or miss whether this works with tumbler too.

You can try the Ubuntu kernel packages (they can be unpacked and used on
non Ubuntu systems pretty easily) to see if it works for you. Tumbler
platform function conversion isn't even tested, so I'd be happy to hear
any feedback.

-- 
Ben Collins
Kernel Developer - Ubuntu Linux
