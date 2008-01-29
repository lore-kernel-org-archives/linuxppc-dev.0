Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 511D7DDE48
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jan 2008 12:44:59 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0T1its6028923
	for <linuxppc-embedded@ozlabs.org>; Mon, 28 Jan 2008 20:44:55 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0T1itNR115660
	for <linuxppc-embedded@ozlabs.org>; Mon, 28 Jan 2008 18:44:55 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0T1iscr015567
	for <linuxppc-embedded@ozlabs.org>; Mon, 28 Jan 2008 18:44:54 -0700
Date: Mon, 28 Jan 2008 19:43:52 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Preferred GIT URL for arch/powerpc, and BINUTILS
Message-ID: <20080128194352.206f3ead@zod.rchland.ibm.com>
In-Reply-To: <20080128224710.9C1C4DDEE1@ozlabs.org>
References: <20080128224710.9C1C4DDEE1@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jan 2008 17:46:47 -0500
Steve Heflin <sheflin@newagemicro.com> wrote:

> At 02:30 PM 1/28/2008, Steve Heflin wrote:
> >Josh, you're a life saver!!  Your GIT tree is exactly what I've been
> >looking for. I have an AMCC440EPx based product that makes heavy use
> >of all the devices embedded in the microcontroller. I'll be able to
> >give that platform a very good testing.
> >
> >Now can you help me with BINUTILS?  What version do you use and can
> >you point me to a decent GIT tree for it?  I tried to use version
> >2.18 and the build blows up because it tries to "strip" a script file
> >"embedspu".
> 
> Whoa! I spoke too soon.  Upon attempting a "make menuconfig" on the 
> 2.6.24-rc8 which I cloned from your git tree, I don't even SEE the 
> powerpc architecture appearing!  What's up?

I dunno.  I never use make menuconfig.  I typically do:

make ARCH=powerpc sequoia_defconfig

or something similar if I'm cross-building from x86.  Otherwise if I'm
on the G5, it's just:

make sequoia_defconfig

josh
