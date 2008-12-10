Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B844ADDF2F
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 23:37:57 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBACbG0X024882
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 07:37:16 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBACbr4T151780
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 07:37:53 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBADc2vU011530
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 08:38:03 -0500
Date: Wed, 10 Dec 2008 07:37:46 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: PPC4xx ECC Configs, Defines and Source
Message-ID: <20081210073746.78ec2187@zod.rchland.ibm.com>
In-Reply-To: <200812101007.16677.sr@denx.de>
References: <C562B54F.1351E%gerickson@nuovations.com>
	<20081208202152.GA10929@yoda.jdub.homelinux.org>
	<1228899216.22413.52.camel@pasglop> <200812101007.16677.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Grant Erickson <gerickson@nuovations.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 10 Dec 2008 10:07:16 +0100
Stefan Roese <sr@denx.de> wrote:

> On Wednesday 10 December 2008, Benjamin Herrenschmidt wrote:
> > > Why is there a need to have so many files?  I would think you could
> > > have a single file with all the ECC monitoring implementations in it
> > > called ppc4xx_ecc.c (or such).  Surely they would share some amount
> > > of code?
> >
> > Well, it depends how much they share, but I'd rather have separate files
> > with helpers in ppc4xx_soc.c if it's small, that way, it's easier to
> > only build selected files based on what SoC support is enabled.
> 
> ACK. The Denali core for example from 440EPx/GRx is completely different. 
> Trying to fit this Denali ECC handling into the IBM-DDR(2) code would result 
> in an ugly mess.

That's fine.  I think you are all jumping the gun a bit there.  Grant
is talking about providing a single scrub implementation for 405EXr,
not all of them.  Whether the other implementations ever even
materialize is something entirely different.

Anyway, separate files is fine.  For now, we'll have one. :)

josh
