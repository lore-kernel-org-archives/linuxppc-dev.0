Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AC05CDDE10
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 00:09:50 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m15D9gvK028618
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2008 08:09:42 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m15D9gGk218266
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2008 06:09:42 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m15D9fTr020180
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2008 06:09:42 -0700
Date: Tue, 5 Feb 2008 07:08:33 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sven Luther <sven@powerlinux.fr>
Subject: Re: compile quirk linux-2.6.24 (with workaround)
Message-ID: <20080205070833.3a5b7c11@zod.rchland.ibm.com>
In-Reply-To: <20080204095121.GA18167@powerlinux.fr>
References: <200802031729.12069.bernhard@intevation.de>
	<20080204095121.GA18167@powerlinux.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Bernhard Reiter <bernhard@intevation.de>,
	debian-powerpc@lists.debian.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 4 Feb 2008 10:51:21 +0100
Sven Luther <sven@powerlinux.fr> wrote:

> On Sun, Feb 03, 2008 at 05:29:05PM +0100, Bernhard Reiter wrote:
> > Dear linux powerpc Maintainers and Users,
> > 
> > recently I have tried to compile a new kernel on a Debian sarge ppc
> > system (PowerBook5,6 MacRISC3 Power Macintosh).
> 
> This is a G4 based system.
> 
> > The build system bailed out with
> >        BOOTCC  arch/powerpc/boot/4xx.o
> >         cc1: error: bad value (440) for -mcpu= switch
> >         make[1]: *** [arch/powerpc/boot/4xx.o] Fehler 1
> > 
> > I have tracked this a few steps and the attached patch made the compile for me
> > as my compiler gcc-Version 3.3.5 (Debian 1:3.3.5-13) 
> > cannot produce code for 4xx it seems.
> 
> You should normally not need to build the 4xx bootloader part. Make sure
> that, i don't know why this happens. Can you look into
> arch/powerpc/boot/Makefile, to see what option enables the 4xx build,
> and make sure it is disabled in the main config ?

That's not true.  All the wrapper bits are built for every board always.

josh
