Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 195046876C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 06:37:03 +1100 (EST)
Date: Tue, 15 Nov 2005 13:34:47 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20051115175955.GA14518@kroah.com>
Message-ID: <Pine.LNX.4.44.0511151332310.28098-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

> You only register the driver once.  The individual devices can be bound
> to the same driver, right?
> 
> > Not registering it in CPM_UART, how the pdev could be obtained?
> > 
> > Maybe this is clear, but platform stuff is cumbersome some times...
> 
> Then make it cleaner :)

This is where the confusion is.  We have two instances of device A.  We 
want instance 1 of device A bound to driver "enet" and instance 2 of 
device A bound to "serial".

Today both instances are called "deviceA".  However we can't register two 
different drivers as "deviceA".

Not sure if that clarifies the issue any.

- kumar
