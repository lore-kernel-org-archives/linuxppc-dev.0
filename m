Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6FD58DDE07
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 22:56:30 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7LCuPFj004908
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 08:56:25 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7LCuPkw208790
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 06:56:25 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7LCuONZ011796
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 06:56:24 -0600
Date: Tue, 21 Aug 2007 07:56:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3 v2] Remove need for include/asm-ppc
Message-ID: <20070821075623.74ac17de@weaponx.rchland.ibm.com>
In-Reply-To: <200708211405.59226.arnd@arndb.de>
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>
	<20070820214730.1b3b6fd6@vader.jdub.homelinux.org>
	<20070821025015.GN15469@localhost.localdomain>
	<200708211405.59226.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 21 Aug 2007 14:05:58 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 21 August 2007, David Gibson wrote:
> >=20
> > > > > The point would be to keep the two trees separate, so that one
> > > > > doesn't need to worry about breaking arch/ppc when making a change
> > > > > to arch/powerpc.
> > > >=20
> > > > Exactly so. =C2=A0Having to be careful about not breaking arch/ppc =
when
> > > > doing cleanups for arch/powerpc is a pain in the bum.
> > >=20
> > > How many times has that happened recently? =C2=A0If it's fairly infre=
quent,
> >=20
> > It's infrequent because I've shyed away from cleaning up shared files,
> > precisely because I'm afraid of breaking arch/ppc.
>=20
> How about splitting the files on a per-case bases then? There are at least
> 95 files that would need to be duplicated (again) to make ppc independent
> from powerpc, and most of these files are about userland interfaces where
> duplication makes no sense at all.

Sure.  I said that in my previous reply too.

> Some files in there (irq.h, ipic.h, dcr.h, i8259.h) already have large
> parts hidden in #ifdef CONFIG_PPC_MERGE, so I guess for those it may
> actually be interesting to split them in two again.

Yeah, for those it might.

josh
