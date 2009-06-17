Return-Path: <mohan@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4799DB7246
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 23:34:42 +1000 (EST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 01E5FDDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 23:34:41 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp07.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5HNYauR031337
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 09:34:36 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5HDYaOv1003596
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 23:34:36 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5HDYZpj005468
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 23:34:36 +1000
Date: Wed, 17 Jun 2009 19:04:35 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH] Do not inline putprops function
Message-ID: <20090617133435.GB4059@in.ibm.com>
References: <20090617113456.GC31595@in.ibm.com>
	<20090617114551.GA5672@verge.net.au>
	<20090617115917.GD31595@in.ibm.com>
	<1245241595.4269.15.camel@concordia>
	<20090617130413.GB2774@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090617130413.GB2774@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org, miltonm@bga.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 17, 2009 at 09:04:13AM -0400, Neil Horman wrote:
> On Wed, Jun 17, 2009 at 10:26:35PM +1000, Michael Ellerman wrote:
> > 
> > What compiler version are you using? Does the behaviour change if you
> > use a newer/older compiler? It sounds to me like there's some deeper bug
> > and your patch is just papering over it.
> > 

I tried with gcc 4.3.2. Let me try with a recent version and update.

> Agreed, this doesn't make any sense. Try changing the compiler version to see if
> the problem goes away or stops.  It might also be worthwhile to dump the
> contents of the device tree at the start and end of the kexec process.  If the
> changing of how a function is inlined is causing a hang, its likely changing how
> the putprops function is writing information to the device tree.  Understanding
> what that change is will likely provide clues to how the code has changed.

Neil, there was no code change in fs2dt.c

Regards,
M. Mohan Kumar
