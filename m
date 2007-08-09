Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD53DDDEB6
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 23:34:51 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l79DYm58013476
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 09:34:48 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l79DYmZt263544
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 07:34:48 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l79DYmcK005415
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 07:34:48 -0600
Date: Thu, 9 Aug 2007 08:34:43 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: Sequoia 440EPx patches not working
Message-ID: <20070809083443.2b2f5407@zod.rchland.ibm.com>
In-Reply-To: <46BAF36F.4030801@ru.mvista.com>
References: <1186598710.5459.7.camel@laptop>
	<20070809030856.GC8261@localhost.localdomain>
	<46BAF36F.4030801@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 09 Aug 2007 14:58:55 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> David Gibson wrote:
> > On Wed, Aug 08, 2007 at 01:45:10PM -0500, Jerone Young wrote:
> >> Using the Sequoia (AMCC 440EPx) patches recently submitted to the
> >> list I am unable to boot to fully boot a uImage built with these
> >> patches under Uboot. It appears to hang in very early boot.
> > 
> > I'm guessing this is an old version of u-boot, that's not device
> > tree aware.  That would need a cuImage, not a uImage, and IIRC the
> > posted patches didn't yet have cuboot support for Sequoia.
> > 
> 
> The patches do have cuImage support.
> I have a Sequoia board with uBoot 1.1.6 and it boots cuImage fine.

Speaking of those patches, are you planning on rebasing them against
the latest 4xx series I sent out soon?  That should have some cleanups
that make adding sequoia support a bit easier.

josh
