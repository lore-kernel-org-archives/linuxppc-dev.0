Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF3E2DE518
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 01:19:34 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7KFJNYI020940
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 11:19:23 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7KFJDlD144792
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 11:19:13 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7KFJC0E003139
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 11:19:12 -0400
Date: Wed, 20 Aug 2008 11:19:11 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/9] powerpc/44x: Add PowerPC 44x simple platform support
Message-ID: <20080820111911.483a0576@zod.rchland.ibm.com>
In-Reply-To: <1219243548.26429.25.camel@jdub.homelinux.org>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<496103659f7b122a8301703b055ef4c6bd3092af.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<200808201533.22258.arnd@arndb.de>
	<fa686aa40808200715x6c850593p5655d8b5b8e7b61e@mail.gmail.com>
	<1219243548.26429.25.camel@jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 Aug 2008 10:45:47 -0400
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Wed, 2008-08-20 at 08:15 -0600, Grant Likely wrote:
> > On Wed, Aug 20, 2008 at 7:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tuesday 19 August 2008, Josh Boyer wrote:
> > >> This adds a common board file for almost all of the "simple" PowerPC 44x
> > >> boards that exist today.  This is intended to be a single place to add
> > >> support for boards that do not differ in platform support from most of the
> > >> evaluation boards that are used as reference platforms.  Boards that have
> > >> specific requirements or custom hardware setup should still have their own
> > >> board.c file.
> > >
> > > The code looks correct, but since this is going to be example code
> > > that may get copied into other platforms, I would take extra care
> > > for coding style:
> > 
> > I second Arnd's comments.  Otherwise, this looks pretty good to me.
> 
> You should fix 52xx with the same for loop change then, since I
> blatantly most of this file from you ;)
           ^ stole

/me sighs.

josh
