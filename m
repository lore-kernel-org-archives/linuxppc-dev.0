Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 232D92BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Dec 2004 02:31:01 +1100 (EST)
In-Reply-To: <200412301246.48870.david.jander@protonic.nl>
References: <200412301246.48870.david.jander@protonic.nl>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C6D7331E-5A77-11D9-AECD-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 30 Dec 2004 10:30:46 -0500
To: David Jander <david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: SMC/SCC uart problem with MPC852T
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 30, 2004, at 6:46 AM, David Jander wrote:

> I have been searching for a way to do the BRG routing to SCC3 and SCC4 
> on the
> MPC852T, so that BGR3 is routed to SCC3 and SMC1 and BRG4 to SCC4. I 
> could
> not find anything in the kernel (CVS linux_2_4_devel from DENX) to do 
> this.

There isn't anything exactly to do this.  If you get the linuxppc-2.4 
from BK,
there is an updated uart.c driver that will help with this.  All of the 
BRG
management is handled by a single function, and you can modify this
accordingly to meet your requirements.


> Searching on Google I was able to find these boot-messages from 
> someone using
> an MPC852T:

Must have been a locally customized driver.


	-- Dan
