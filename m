Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 11978DDF5A
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 06:21:14 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m23JLBHs013231
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 14:21:11 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m23JLAnc119994
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 14:21:10 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m23JLAmo007892
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 14:21:10 -0500
Date: Mon, 3 Mar 2008 13:21:07 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2 v2] [POWERPC] Ignore disabled serial ports
Message-ID: <20080303132107.67200634@weaponx>
In-Reply-To: <20080303190925.GA6735@loki.buserror.net>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301081746.689a0a17@zod.rchland.ibm.com>
	<200803030443.43346.arnd@arndb.de>
	<20080302224317.15f259ca@zod.rchland.ibm.com>
	<20080303190925.GA6735@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 3 Mar 2008 13:09:25 -0600
Scott Wood <scottwood@freescale.com> wrote:

> On Sun, Mar 02, 2008 at 10:43:17PM -0600, Josh Boyer wrote:
> > On Mon, 3 Mar 2008 04:43:42 +0100
> > Arnd Bergmann <arnd@arndb.de> wrote:
> > > I wonder whether we should move the check for "used-by-rtas" into the
> > > of_device_is_available function. I understand that used-by-rtas is
> > > another way of expressing the idea that the kernel is not supposed to
> > > access the specific device. In this case, the device is physically
> > > present, but is not available to the OS.
> > 
> > I'd rather not at the moment.  My intention was to only look at the
> > status property for now.  I'd like to avoid this function growing into
> > a huge switch statement for $random_firmware's way of flagging
> > something as "don't touch".
> 
> Better that than having the "huge" list of tests in every driver...

Perhaps.

This isn't set in stone.  I'd rather get what's in the patch in-tree
now and massage it as we go.  Otherwise this bike shed will wind up
being rainbow colored yet totally useless because it's a never-ending
patch rework.

josh
