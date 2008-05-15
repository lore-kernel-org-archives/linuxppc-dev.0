Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 77224DDF12
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 09:20:33 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4FNKUHg012190
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 19:20:30 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4FNKUFl148942
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 19:20:30 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4FNKUEm003126
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 19:20:30 -0400
Date: Thu, 15 May 2008 18:17:15 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Convert remaining dts-v0 files to v1
Message-ID: <20080515181715.06dd124f@zod.rchland.ibm.com>
In-Reply-To: <482C9B6F.1020907@am.sony.com>
References: <20080515064639.GB30996@yookeroo.seuss>
	<482C9B6F.1020907@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 15 May 2008 13:22:07 -0700
Geoff Levand <geoffrey.levand@am.sony.com> wrote:

> David Gibson wrote:
> > At the moment we have a mixture of left-over version 0 and new-format
> > version 1 files in arch/powerpc/boot/dts.  This is potentially
> > confusing to people new to the dts format attempting to figure it out.p
> > 
> > So, this patch converts all the as-yet unconverted dts v0 files and
> > converts them to v1.  They're mechanically-converted, and not hand
> > tweaked so in some cases they're not 100% in keeping with usual v1
> > style, but the convertor program does have some heuristics so the
> > discrepancies aren't too bad.
> > 
> > I have checked that this patch produces no changes to the resulting
> > dtb binaries.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > 
> ...
> > Index: working-2.6/arch/powerpc/boot/dts/ps3.dts
> > ===================================================================
> > --- working-2.6.orig/arch/powerpc/boot/dts/ps3.dts	2008-05-15 16:32:08.000000000 +1000
> > +++ working-2.6/arch/powerpc/boot/dts/ps3.dts	2008-05-15 16:32:08.000000000 +1000
> 
> I tested this on PS3 and it seems to work OK.
> 
> Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>

Paul,

Since this mostly effects DTSs for my boards, do you mind if I pull
this into my tree?  I spoke with Geoff today and he doesn't have any
planned PS3 DTS updates, so we shouldn't get conflicts doing it that
way.

josh
