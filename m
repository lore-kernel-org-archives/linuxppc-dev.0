Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 206C2687FF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 04:23:53 +1100 (EST)
Date: Wed, 23 Nov 2005 11:21:00 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
In-Reply-To: <1132761494.2776.14.camel@localhost>
Message-ID: <Pine.LNX.4.44.0511231119240.2433-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Tsi108
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 23 Nov 2005, Adrian Cox wrote:

> I've just received the evaluation board for the Tsi108 bridge:
> 
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MCEVALHPC2-7448&nodeId=0162468rH3bTdGb9MM
> 
> The kernel supplied is 2.6.11.1, and it looks like it needs the
> following to bring it up to date:
> 
> 1) Using platform_device for on-chip resources.
> 2) Coding standards cleanup.
> 3) Fix the ethernet driver
> 3a) Fix bugs in stopping and starting interface
> 3b) remove virt_to_phys
> 3c) ethtool support?
> 
> Has anybody started on this before I begin?

I'm not aware of anyone, but I know I told people at FSL to clean this up.

Also, the PIC code needs to be looked at. The TSI108 looked too similar to 
openpic to warrant its own code when I reviewed this code awhile ago.

- kumar
