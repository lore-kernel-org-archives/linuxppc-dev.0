Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id A9C0367B1A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 00:56:16 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j45F0mnm016991
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 5 May 2005 18:00:48 +0300 (EEST)
Message-ID: <427A3069.4020906@intracom.gr>
Date: Thu, 05 May 2005 17:40:41 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: jmasel@arabellasw.com
References: <E1DTgrw-0004Lt-00@gold.webfusion.co.uk>
In-Reply-To: <E1DTgrw-0004Lt-00@gold.webfusion.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC][PATCH 2.6.12-rc2 3/3] FCC Ethernet PlatformDevice
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jonathan Masel wrote:
> Are you interested in looking at our Resource Manager? It works in 2.4 and
> 2.6 kernels for a wide range of PQ's (virtually all of them).
> 
> It seems to take some of these ideas, but further. The basic idea is to
> handle at all on-chip resources in an orderly and robust way (not just
> modularly, but that too). We allocate parallel port pins, clocks (BRG or
> CLK), internal DPRAM and communication channels to "consumers". Board
> specific (if/where needed) are all located in a single per-board file.
> Allocation is all dynamic and we can check that we're not conflicting with
> prior requests. There are quite a few other goodies too (display all
> consumers to which certain resources are allocated, etc).
> 
> This lets us easily handle dynamic configurations. E.g. configure pins for
> I2C during reset or start-up, modify them later on when you need ATM (they
> are multiplexed on the same pins on several devices). Or, as you mentioned,
> dynamic modules - but even when they have potentially conflicting requests.
> 
> And it is one, simple to use mechanism that we use across all devices
> (adapted for PQ1, PQ2 and PQ3).
> 
> If you're interested, please let me know. We'd be happy to contribute it if
> it will help.
> 
> Jonathan
> 
> 

Hi Jonathan.

This is a good time for everyone working in freescale platforms to
just put on the table what it uses and see if a common ground can
be found.

So please post the files, and some comments on how they work.

Regards

Pantelis
