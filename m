Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CA5467D93
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 07:46:37 +1000 (EST)
Message-ID: <42EAA3B5.70902@pobox.com>
Date: Fri, 29 Jul 2005 17:46:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
References: <23F9076F-9FBB-43C8-83CD-F630E694203D@freescale.com>
In-Reply-To: <23F9076F-9FBB-43C8-83CD-F630E694203D@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH RFC]: PHY Abstraction Layer III
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andy Fleming wrote:
> Here's the latest version of the patch, done against a cogito  linux-2.6 
> branch.  It has a handful of small changes, which I hope  will speed 
> acceptance:
> 
> * Interrupts are no longer requested at interrupt time
> * There is a function to print out PHY status
> * The PHY drivers' probe function now serves only to initialize  driver 
> state
> * A new config_init functor has been created to configure PHY state  
> just after reset (so that the PHYs will be returned to a sane state  if 
> they don't start up that way)
> * Stephen Hemminger's patch to allow better module support in the  
> drivers has been included

OK, DaveM and I are OK with merging this.

Send me a single One Big Patch which adds all the new files and such, 
I'll give it a final review, and queue it for 2.6.14.

	Jeff
