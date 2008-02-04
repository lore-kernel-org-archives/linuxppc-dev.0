Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F424DE02A
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 08:02:28 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m14JwlHt005816
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Feb 2008 14:58:47 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m14L2M61143322
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Feb 2008 14:02:23 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m14L2LBJ019332
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Feb 2008 14:02:22 -0700
Date: Mon, 4 Feb 2008 15:01:21 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Bernhard Reiter <bernhard@intevation.de>
Subject: Re: compile quirk linux-2.6.24 (with workaround)
Message-ID: <20080204150121.02355054@zod.rchland.ibm.com>
In-Reply-To: <200802031729.12069.bernhard@intevation.de>
References: <200802031729.12069.bernhard@intevation.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 3 Feb 2008 17:29:05 +0100
Bernhard Reiter <bernhard@intevation.de> wrote:

> Dear linux powerpc Maintainers and Users,
> 
> recently I have tried to compile a new kernel on a Debian sarge ppc
> system (PowerBook5,6 MacRISC3 Power Macintosh).
> 
> The build system bailed out with
>        BOOTCC  arch/powerpc/boot/4xx.o
>         cc1: error: bad value (440) for -mcpu= switch
>         make[1]: *** [arch/powerpc/boot/4xx.o] Fehler 1
> 
> I have tracked this a few steps and the attached patch made the compile for me
> as my compiler gcc-Version 3.3.5 (Debian 1:3.3.5-13) 
> cannot produce code for 4xx it seems.
> 
> The "ARCH=ppc64" I have came about also looked wrong, but I do not know
> if this part of the patch is really necessary.
> It is just a workaround, as I have no insight of what is really going wrong.

That patch really won't fly.  I'll try go come up with something a bit
more robust when I can.

josh
