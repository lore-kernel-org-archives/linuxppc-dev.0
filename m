Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id B67ED687C1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 10:50:27 +1100 (EST)
Date: Tue, 15 Nov 2005 14:40:56 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@gate.crashing.org>
Message-ID: <20051115224056.GA14357@kroah.com>
References: <20051115175955.GA14518@kroah.com>
	<Pine.LNX.4.44.0511151332310.28098-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0511151332310.28098-100000@gate.crashing.org>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Platform device model drawback
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Nov 15, 2005 at 01:34:47PM -0600, Kumar Gala wrote:
> > You only register the driver once.  The individual devices can be bound
> > to the same driver, right?
> > 
> > > Not registering it in CPM_UART, how the pdev could be obtained?
> > > 
> > > Maybe this is clear, but platform stuff is cumbersome some times...
> > 
> > Then make it cleaner :)
> 
> This is where the confusion is.  We have two instances of device A.  We 
> want instance 1 of device A bound to driver "enet" and instance 2 of 
> device A bound to "serial".

That's different from what was described earlier :)

In this case, you need two different struct devices.

> Today both instances are called "deviceA".  However we can't register two 
> different drivers as "deviceA".

Nor would you want to.

> Not sure if that clarifies the issue any.

A bit.  I think it still sounds messy...

thanks,

greg k-h
