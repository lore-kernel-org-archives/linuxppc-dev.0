Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BCF27DDE3F
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 08:50:34 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1JLoVCg004246
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 16:50:31 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1JLoVbC298720
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 14:50:31 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1JLoVjY004837
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 14:50:31 -0700
Subject: Re: [RFC 3/3] zImage: Exception vector support
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45DA1919.7010706@am.sony.com>
References: <45D7A914.4040000@am.sony.com>
	<20070218014043.GD1038@crusty.rchland.ibm.com>
	<45D9BC29.5020507@am.sony.com>
	<1171920901.24204.55.camel@zod.rchland.ibm.com>
	<45DA1919.7010706@am.sony.com>
Content-Type: text/plain
Date: Mon, 19 Feb 2007 15:51:33 -0600
Message-Id: <1171921893.24204.57.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-19 at 13:39 -0800, Geoff Levand wrote:
> Josh Boyer wrote:
> > On Mon, 2007-02-19 at 07:03 -0800, Geoff Levand wrote:
> >> Josh Boyer wrote:
> >> > On Sat, Feb 17, 2007 at 05:17:08PM -0800, Geoff Levand wrote:
> >> >> Add SMP exception vector support to the powerpc zImage bootwrapper.  For
> >> >> platforms which have entry points in the vector table.  This implements
> >> >> SMP entry via the system reset vector.
> >> >> 
> >> >> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> >> >> 
> >> >> ---
> >> >>  arch/powerpc/boot/head.S       |   96 +++++++++++++++++++++++++++++++++++++++++
> >> >>  arch/powerpc/boot/zImage.lds.S |    2 
> >> > 
> >> > This one seems pretty PS3 specific, and there's no makefile entry to actually
> >> > compile it...  Could we name it head_ps3.S or something similar?
> >> > 
> >> > Or am I misunderstanding the code and it's really generic to most SMP
> >> > machines (which would make a case to arguably call it head_smp.S).
> >> 
> >> No, its not platform specific nor SMP specific, it should work
> >> with all SMP and UP platforms that need this kind of support.
> > 
> > Well, I'm not sure it will work with all UP platforms anyway.  The SPR
> > you're peeking at to look at the thread number doesn't even exist on 4xx
> > for example.
> 
> The 4xx wrapper needs a reset vector?  If so, what bootloader are you using?

Ok, sorry.  Getting ahead of myself there.  I'll shut up now.

josh
